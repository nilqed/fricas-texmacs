;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; MODULE      : fricas-input.scm
;; DESCRIPTION : FriCAS input conversions
;; COPYRIGHT   : (C) 1999  Joris van der Hoeven, 2012  Albert Graef
;;             : (C) 2012 Andrey Grozin, 2024 Kurt Pagani
;; This software falls under the GNU general public license version 3 or later.
;; It comes WITHOUT ANY WARRANTY WHATSOEVER. For details, see the file LICENSE
;; in the root directory or <http://www.gnu.org/licenses/gpl-3.0.html>.
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(texmacs-module (fricas-input)
  (:use (utils plugins plugin-convert)))

;; NOTE: Some kludges are needed to bring some constructs such as limits and
;; big operators (sums, integrals, etc.) into a form which prevents Pure
;; syntax errors and allows easy interaction with Reduce. I hope that these
;; will work correctly in most cases; if it doesn't, please submit a bug
;; report with the offending expression and I will try to fix it.

;; Symbols in the following list have "big" variants created automatically if
;; they are used as a big operator, e.g.: cap -> bigcap, vee -> bigvee etc.,
;; so that the base symbols can be used as binary functions or operators at
;; the same time. (TODO: This is probably incomplete, add others as needed.)
(define fricas-big-ops
  (list "cap" "cup" "sqcap" "sqcup" "vee" "wedge" "curlyvee" "curlywedge"
	"uplus" "box" "oplus" "otimes" "odot"));

;; Please also see the end of this file for input conversions which you might
;; want to adjust for your needs.

;; do something reasonable with sub- and superscripts

(define (fricas-rsub r)
  (display "[")
  (plugin-input (car r))
  (display "]"))

(define (fricas-rsup r)
  (display "^(")
  (plugin-input (car r))
  (display ")"))

(define (fricas-lsub r)
  (display "(!(")
  (plugin-input (car r))
  (display "))"))

(define (fricas-lsup r)
  (display "(^(")
  (plugin-input (car r))
  (display "))"))

(define (fricas-above t)
  (display "(above (")
  (plugin-input (car t))
  (display ",")
  (plugin-input (cadr t))
  (display ")"))

(define (fricas-below t)
  (display "(below (")
  (plugin-input (car t))
  (display ",")
  (plugin-input (cadr t))
  (display ")"))

;; primes and accents

(define (fricas-prime r)
  (plugin-input (car r)))

(define (fricas-wide t)
  (let* ((op (car t))
	 (acc (cadr t)))
    (display "(")
    (cond ((and (string? acc) (== acc "^"))
	   (display "hat"))
	  ((and (string? acc) (== acc "~"))
	   (display "tilde"))
	  (else (plugin-input acc)))
    (display " (")
    (plugin-input op)
    (display "))")))

(define (fricas-neg r)
  (display "~(")
  (plugin-input (car r))
  (display ")"))


;;;
;;; NEW: pattern matching for "fractions" to
;;; detect derivatives. We will use the "match?"
;;; function (maybe "select" as well).
;;;

;; for debug / matches every a/b
(define p0 '('x 'y)) 

;; matches df(x)/dx (incl. partial)
(define p1 '((concat 'x1  (around* "(" 'x2 ")" )) 'y)) 

;; matches d^m f(x) / dx^m (incl. partial single denom)
(define p2 '((concat 'x1 (rsup 'x2) 'x3 (around* "(" 'x4 ")" )) (concat 'y1 (rsup 'y2))))

;; TODO: mixed partials and d: expressions

;; (string-any (lambda (x) (== x #\d)) "d f" 0 1)
;; (string-prefix? "d" (string-trim " d f "))
;; (string-prefix? "<mathd>" (string-trim " <mathd> f ")) / <partial> ...


;; Check if s contains a derivative symbol
(define (is-deriv? s)
  (or (string-prefix? "d" (string-trim s))
      (string-prefix? "<mathd>" (string-trim s))
      (string-prefix? "<partial>" (string-trim s))))
 
;; Remove derivative symbol from string (if is-deriv?)
(define (strip-deriv-op s)
  (let ((ts (string-trim s)))
    (cond 
      ( (string-prefix? "d" ts) (string-trim (string-drop ts 1)) )
      ( (string-prefix? "<mathd>" ts) (string-trim (string-drop ts 7)) )
      ( (string-prefix? "<partial>" ts) (string-trim (string-drop ts 9)) )
      ( else ts)
    )))

;; Handle pattern p1.
(define (handle-p1 t p) 
  (let* ((m1 (match? t p))
    (x1 (assq-ref (car m1) 'x1))
    (x2 (assq-ref (car m1) 'x2))
    (y (assq-ref (car m1) 'y))) 
    (if (and (is-deriv? x1) (is-deriv? y))
      (display (string-join 
        (list "D(" (strip-deriv-op x1) "(" x2 ")," (strip-deriv-op y) ")")))  
      (fricas-std-frac t))))
      
;; Handle pattern p2.
(define (handle-p2 t p) 
  (let* ((m1 (match? t p))
    (x1 (assq-ref (car m1) 'x1))
    (x2 (assq-ref (car m1) 'x2))
    (x3 (assq-ref (car m1) 'x3))
    (x4 (assq-ref (car m1) 'x4))
    (y1 (assq-ref (car m1) 'y1))
    (y2 (assq-ref (car m1) 'y2))) 
    (if (and (is-deriv? x1) (is-deriv? y1) (== (string-trim x2) (string-trim y2)))
      (display (string-join 
        (list "D(" x3 "(" x4 ")," (strip-deriv-op y1) "," (string-trim x2)  ")")))  
      (fricas-std-frac t))))


;; fractions
;; TODO: might be a derivative?
(define (fricas-std-frac t)
  (display "((")
  (plugin-input (car t))
  (display ")/(")
  (plugin-input (cadr t))
  (display "))"))
  
(define (fricas-frac t)
  (cond
    ;((match? t p0) (begin (display "p0") (display (match? t p0)))) 
    ((match? t p1) (handle-p1 t p1))
    ((match? t p2) (handle-p2 t p2))
    (else (fricas-std-frac t))))


;; Brackets: |.| and ||.|| are mapped to abs and norm, respectively, others
;; are left as is.

(define (fricas-around t)
  (let* ((left (car t))
	 (op (cadr t))
	 (right (caddr t)))
    (cond ((and (== left "|") (== right "|"))
	   (display "(abs (")
	   (plugin-input op)
	   (display "))"))
	  ((and (== left "<||>") (== right "<||>"))
	   (display "(norm (")
	   (plugin-input op)
	   (display "))"))
	  ((and (== left "<nobracket>") (== right "<nobracket>"))
	   (display "(")
	   (plugin-input op)
	   (display ")"))
	  (else
	   (plugin-input left)
	   (plugin-input op)
	   (plugin-input right)))))

;; This removes special markup around some math constructs. It also covers the
;; case of a singleton | (needed for comprehensions in Pure), which can be
;; entered either as Shift-F5 | or as a "middle |" (Alt+M |) in TeXmacs.

(define (fricas-math t)
  (plugin-input (car t)))

(define (fricas-space t)
  (display " "))

;; Support for matrices and various kinds of tables. This was originally
;; pilfered from maxima-input.scm, but has been heavily modified to support
;; various kinds of tables including stacks and choices.

(define fricas-inside-case? #f)
(define fricas-inside-eqn? #f)

(define fricas-matrix-delims (list "["	"]"	", "	"["	"]"	", "))
(define fricas-stack-delims  (list " "	" "	" "	""	""	" "))
(define fricas-choice-delims (list " "	" "	"; = "	""	""	" "))
(define fricas-case-delims   (list " "	" end "	"; "	""	""	" "))
(define fricas-delims fricas-matrix-delims)

(define (fricas-outer-left)   (list-ref fricas-delims 0))
(define (fricas-outer-right)  (list-ref fricas-delims 1))
(define (fricas-outer-middle) (list-ref fricas-delims 2))
(define (fricas-inner-left)   (list-ref fricas-delims 3))
(define (fricas-inner-right)  (list-ref fricas-delims 4))
(define (fricas-inner-middle) (list-ref fricas-delims 5))

(define (fricas-var-row2 r)
  (if (nnull? r)
      (begin
	(display (fricas-inner-middle))
	(plugin-input (car r))
	(fricas-var-row2 (cdr r)))))

(define (fricas-var-row r)
  (if (nnull? r)
      (begin
	(display (fricas-inner-middle))
	(plugin-input (car r))
	(fricas-var-row2 (cdr r)))))

(define (fricas-row r)
  (display (fricas-inner-left))
  (plugin-input (car r))
  (fricas-var-row (cdr r))
  (display (fricas-inner-right)))

(define (fricas-var-rows t)
  (if (nnull? t)
      (begin
	(display (fricas-outer-middle))
	(fricas-row (car t))
	(fricas-var-rows (cdr t)))))

(define (fricas-rows t)
  (display (fricas-outer-left))
  (fricas-row (car t))
  (fricas-var-rows (cdr t))
  (display (fricas-outer-right)))

(define (fricas-descend-last args)
  (if (null? (cdr args))
      (plugin-input (car args))
      (fricas-descend-last (cdr args))))

(define (fricas-det args)
  (with delims fricas-delims
	(display "(det ")
	(set! fricas-delims fricas-matrix-delims)
	(fricas-descend-last args)
	(set! fricas-delims delims)
	(display ")")))

(define (fricas-matrix args)
  (with delims fricas-delims
	(set! fricas-delims fricas-matrix-delims)
	(fricas-descend-last args)
	(set! fricas-delims delims)))

(define (fricas-stack args)
  (with delims fricas-delims
	(set! fricas-delims fricas-stack-delims)
	(fricas-descend-last args)
	(set! fricas-delims delims)))

(define (fricas-choice args)
  (with delims fricas-delims
	(set! fricas-delims
	      (cond (fricas-inside-case? fricas-case-delims)
		    (fricas-inside-eqn? fricas-choice-delims)
		    (else fricas-stack-delims)))
	(fricas-descend-last args)
	(set! fricas-inside-case? #f)
	(set! fricas-inside-eqn? #f)
	(set! fricas-delims delims)))

(define (fricas-binom args)
  (display "binom (")
  (plugin-input (car args))
  (display ") (")
  (plugin-input (cadr args))
  (display ")"))

;; trees

(define (fricas-tree-args args)
  (display "(")
  (plugin-input (car args))
  (display ")")
  (if (nnull? (cdr args))
      (begin
	(display ",")
	(fricas-tree-args (cdr args)))))

(define (fricas-tree args)
  (display "(tree (")
  (if (nnull? args) (fricas-tree-args args))
  (display "))"))

;; roots (also pilfered from maxima-input.scm)

(define (fricas-sqrt args)
  (if (= (length args) 1)
      (begin
        (display "sqrt(")
        (plugin-input (car args))
        (display ")"))
      (begin
        (display "(")
        (plugin-input (car args))
        (display ")^(1%(")
        (plugin-input (cadr args))
        (display "))"))))

;; Sums, integrals etc. This is quite different from the Maxima code to
;; accommodate the Pure syntax. It also offers support for entering aggregates
;; of list comprehensions (sum, product), if you leave away the superscript and
;; specify the generator and filter clauses of the comprehension in the
;; subscript.

(define (fricas-comp op body args)
  (display op)
  (display " [")
  (plugin-input body)
  (if (nnull? args)
      (if (nnull? (cdr args))
          (begin ;; both lower and upper index
            (display "|")
            (plugin-input (car args))
            (display "..")
            (plugin-input (cadr args))
            (display "]"))
          (begin ;; lower index only
            (display "|")
            (plugin-input (car args))
            (display "]")))
      (display "]")))

(define (fricas-rewrite-body s)
  (if (string? s)
      (cond ((string-contains? s "*<mathd>*")
	     (string-replace s "*<mathd>*" "*d*"))
	    ((string-contains? s "<mathd>")
	     (string-replace s "<mathd>" ","))
	    ((== s "d") ",")
	    (else
	     (let* ((toks (string-tokenize
			   s (char-set-complement char-set:whitespace)))
		    (ws1 (if (and (nnull? toks)
				  (char-whitespace? (string-ref s 0)))
			     " " ""))
		    (ws2 (if (and (nnull? toks)
				  (char-whitespace?
				   (string-ref s (1- (string-length s)))))
			     " " "")))
	       (if (and (nnull? toks)
			(or (nnull? (cdr toks))
			    (not (string-null? ws1))
			    (not (string-null? ws2))))
		   (string-append
		    ws1
		    (string-join (map fricas-rewrite-body toks) " ")
		    ws2)
		   s))))
      s))

(define (fricas-big op body args)
  (display "(")
  (display op)
  (display " (")
  (plugin-input
   (if (== op "integrate")
       ;; We need to rewrite <mathd> to "," here to get the integration
       ;; variable as a separate argument, as required by Reduce. (We don't
       ;; want to do this unconditionally since we also use <mathd> for
       ;; differentials.)
       (if (list? body)
	   (map fricas-rewrite-body body)
	   (fricas-rewrite-body body))
       body))
  (if (nnull? args)
      (let* ((sub (car args)) (sup (cdr args)))
        (if (== op "integrate")
          (display "=")
          (display ","))
	;; Yet another awful kludge which massages a subscript of the form
	;; "n = start" into two separate arguments as Reduce wants them. Where
	;; things get really awful is when the subscript is a concat node.
	;; Is there a better way to do this?
	(cond ((string? sub)
	       (display (string-replace sub "=" " = ")))
	      ((and (list? sub) (nnull? sub) (eq? (car sub) 'concat)
		    (string? (cadr sub)))
		 (with s (string-replace (cadr sub) "=" " = ")
		       (plugin-input (append (list 'concat s) (cddr sub)))))
	      (else (plugin-input sub)))
        (if (nnull? sup)
            (begin
              (display "..")
              (plugin-input (car sup))))
        (display "))"))
      (display "))")))

(define (fricas-big-around args)
  (let* ((b `(big-around ,@args))
	 (op (big-name b))
	 (op (if (list-find fricas-big-ops (lambda (s) (== op s)))
		 (string-append "big" op) op))
	 (sub (big-subscript b))
	 (sup (big-supscript b))
	 (body (big-body b))
	 (l (cond ((and sub sup) (list sub sup))
		  (sub (list sub))
		  (else (list)))))
    (cond ((or (== op "intlim") (== op "int") (== op "oint"))
	   ;; not sure about oint, but the rest is supported by Pure/Reduce
	   (fricas-big "integrate" body l))
	  ((and sub sup (== op "sum"))
	   ;; supported if both lower and upper bound is given
	   (fricas-big op body l))
	  ((and sub sup (== op "prod"))
	   ;; supported if both lower and upper bound is given
	   (fricas-big "product" body l))
	  ;; anything else is assumed to be a aggregate which translates
	  ;; to a list comprehension
	  (else (fricas-comp op body l)))))

(define (fricas-check-tag? s t)
  (cond ((null? s) #f)
	((string? s) (string-contains? s t))
	((and (list? s)
	      ;; recursively descend into the last argument
	      (if (nnull? (cdr s))
		  (fricas-last-token? (cdr s) t)
		  (fricas-last-token? (car s) t))))
	(else #f)))

(define (fricas-last-token? s t)
  (cond ((null? s) #f)
	((string? s)
	 (let* ((cs (if (char-set-contains? char-set:letter+digit
					    (string-ref t 0))
			char-set:letter+digit
			(char-set-complement
			 (string->char-set ";<>()[]{}" char-set:whitespace))))
		(toks (string-tokenize s cs))
		(tok (if (null? toks) "" (car (last-pair toks)))))
	   (and (== t tok)
		(string-suffix? t (string-delete s char-set:whitespace)))))
	((and (list? s)
	      ;; recursively descend into the last argument
	      (if (nnull? (cdr s))
		  (fricas-last-token? (cdr s) t)
		  (fricas-last-token? (car s) t))))
	(else #f)))

(define (fricas-is-space? arg)
  (or (func? arg 'space)
      (and (func? arg 'text) (null? (cdr arg)) (string? (car arg))
	   (string-every char-set:whitespace (car arg)))
      (and (string? arg) (string-every char-set:whitespace arg))))

(define (fricas-skip-space args)
  (if (or (null? args) (not (fricas-is-space? (car args)))) args
      (fricas-skip-space (cdr args))))

(define (fricas-concat args)
  ;; (format #t "concat: ~s\n" args)
  (cond ((null? args) (noop))
	;; This rule brings limits into a more digestible form. This isn't
	;; 100% fool-proof but it's the best that we can do since TeXmacs has
	;; no special markup for limits.
	((and (or (fricas-last-token? (car args) "lim")
	          (fricas-last-token? (car args) "liminf")
	          (fricas-last-token? (car args) "limsup"))
	      (func? (cadr args) 'rsub)
	      (with s (cadr (cadr args))
		    (and (string? s) (string-contains s "<rightarrow>"))))
	 ;(plugin-input (car args))
	 (display "(limit (")
	 (fricas-concat (cddr args))
	 (display ",")
	 (with s (cadr (cadr args))
	       (plugin-input (string-replace s "<rightarrow>" "=")))
	 (display ")) "))  
	;; These rules are used to format <choice> expressions.
	((and (fricas-last-token? (car args) "of")
	      ;; look ahead, skipping over space, to see whether <choice>
	      ;; follows
	      (with l (fricas-skip-space (cdr args))
		    (and (nnull? l) (func? (car l) 'choice))))
	 (plugin-input (car args))
	 (set! fricas-inside-case? #t)
	 (fricas-concat (cdr args)))
	((and (fricas-last-token? (car args) "=")
	      ;; look ahead, skipping over space, to see whether <choice>
	      ;; follows
	      (with l (fricas-skip-space (cdr args))
		    (and (nnull? l) (func? (car l) 'choice))))
	 (plugin-input (car args))
	 (set! fricas-inside-eqn? #t)
	 (fricas-concat (cdr args)))
	(else
	 (plugin-input (car args))
	 (fricas-concat (cdr args)))))

;; XXXTODO: We'd really like to open this up to the user so that he has an
;; easy way of specifying his own conversions which take precedence over the
;; ones given here.

(define fricas-converters
'(
  ;; Only change these if you know what you are doing. Many special
  ;; constructs are defined here.
  (concat fricas-concat)
  (tree fricas-tree)
  (rows fricas-rows)
  (tabular fricas-matrix)
  (tabular* fricas-matrix)
  (block fricas-matrix)
  (block* fricas-matrix)
  (matrix fricas-matrix)
  (det fricas-det)
  (eqnarray fricas-stack)
  (eqnarray* fricas-stack)
  (equation fricas-descend-last)
  (equation* fricas-descend-last)
  (stack fricas-stack)
  (choice fricas-choice)
  (binom fricas-binom)
  (sqrt fricas-sqrt)
  (big-around fricas-big-around)
  (around fricas-around)
  (around* fricas-around)
  (space fricas-space)
  (mid fricas-math)
  (really-tiny fricas-math)
  (tiny fricas-math)
  (very-small fricas-math)
  (small fricas-math)
  (normal-size fricas-math)
  (large fricas-math)
  (very-large fricas-math)
  (huge fricas-math)
  (really-huge fricas-math)
  (math-bf fricas-math)
  (math-it fricas-math)
  (math-sl fricas-math)
  (math-ss fricas-math)
  (math-tt fricas-math)
  (math-up fricas-math)
  (rprime fricas-prime)
  (lprime fricas-prime)
  (above fricas-above)
  (below fricas-below)
  (lsub fricas-lsub)
  (lsup fricas-lsup)
  (rsub fricas-rsub)
  (rsup fricas-rsup)
  (wide fricas-wide)
  (frac fricas-frac)
  (dfrac fricas-frac)
  (tfrac fricas-frac)
  (frac* fricas-frac)
  (neg fricas-neg)

;; Stuff below you might want to change to add your own symbol mappings or
;; adjust the ones given here. Some the symbols are pilfered from the generic
;; converter, others I gleaned from the menus or by looking at the tree form
;; of math formulas. There's surely some stuff missing here. Note that many of
;; these symbols aren't defined in Pure by default, so you can give them any
;; meaning that you want.

  ;; These all have a predefined meaning in Pure (except matheuler). The e, pi
  ;; and i symbol will only be defined if the math module is loaded, however.
  ("<backslash>"  "\\")
  ("<infty>"      " %plusInfinity ")
  ("<mathe>"      " %e ")
  ("<mathpi>"     " %pi ")
  ("<mathi>"      " %i ")
  ("<matheuler>"  " matheuler ")
  ;; Differentials. These are taken care of in texmacs.pure.
  ("<partial>"    " d ")
  ("<mathd>"      " d ")
  ;; Reduce/tmprint uses this to display empty lists, so we follow suit and
  ;; allow this on the input side as well. Change this if you'd like this
  ;; symbol to produce a different Pure container (such as a set) instead.
  ("<emptyset>"   "[]")

  ("<longequal>" "==") ;; equality in Pure
  ("<assign>" ":=")
  ("<plusassign>" "+=")
  ("<minusassign>" "-=")
  ("<timesassign>" "*=")
  ("<overassign>" "/=")
  ("<lflux>" "<<")
  ("<gflux>" ">>")

  ("<implies>" "=<gtr>")
  ("<Rightarrow>" "=<gtr>")
  ("<Leftrightarrow>" "<less>=<gtr>")
  ("<neg>" "~") ; negation symbol
  ("<sim>" "~") ; tilde
  ("<wedge>" "&&")
  ("<vee>" "||")
  ("<equiv>" "===") ; syntactic identity in Pure
  ("<nequiv>" "~==") ; dito
  ("<neq>" "~=")
  ("<less>" "<less>")
  ("<gtr>" "<gtr>")
  ("<leq>" "<less>=")
  ("<geq>" "<gtr>=")
  ("<leqslant>" "<less>=")
  ("<geqslant>" "<gtr>=")
  ("<ll>" "<less><less>")
  ("<gg>" "<gtr><gtr>")
  ("<into>" "-<gtr>")
  ;("<mapsto>" "|-<gtr>")
  ("<mapsto>"     " +-> ")
  ;("<assign>"     " := ")
  ("<rightarrow>" "-<gtr>")
  ("<transtype>" ":<gtr>")

  ;; different kinds of brackets and delimiters
  ("<lfloor>" "floor (")
  ("<rfloor>" ")")
  ("<lceil>" "ceil (")
  ("<rceil>" ")")
  ("<langle>" "(")
  ("<rangle>" ")")
  ("<llbracket>" "[")
  ("<rrbracket>" "]")
  ("<nobracket>" " ")
  ;; various kinds of "non-symbols" (typically symbol+space combinations)
  ("<comma>" ",")
  ("<nocomma>" ",")
  ("<nospace>" " ")
  ("<nosymbol>" ".")
  ("<noplus>" "+")

  ("<um>" "-")
  ("<upl>" "") ; unary plus not supported in Pure
  ("<circ>" ".") ; function composition in Pure
  ("<colons>" "::")
  ("<div>" "%")
  ("<times>" "*")
  ("<ast>" "*")
  ("<cdot>" "*")
  ("<ldots>" "..")

;; Here are a few other operators that might be useful. This list is probably
;; incomplete, add others as needed. Note that none of these is predefined in
;; Pure, so you'll have to declare them as infix symbols if you want to use
;; them.

  ("<pm>" " pm ")
  ("<mp>" " mp ")
  ("<in>" " in ")
  ("<angle>" " angle ")
  ("<star>" " star ")
  ("<bullet>" " bullet ")
  ("<cdots>" " cdots ")
  ("<hdots>" " hdots ")
  ("<vdots>" " vdots ")
  ("<ddots>" " ddots ")
  ("<udots>" " udots ")
  ("<flat>" "flat ")
  ("<natural>" "natural ")
  ("<sharp>" "sharp ")
  ("<forall>" "forall ")
  ("<exists>" "exists ")
  ("<curlywedge>" " curlywedge ")
  ("<curlyvee>" " curlyvee ")
  ("<barwedge>" " barwedge ")
  ("<veebar>" " veebar ")
  ("<vdash>" " vdash ")
  ("<Vdash>" " Vdash ")
  ("<Vvdash>" " Vvdash ")
  ("<vDash>" " vDash ")
  ("<dashv>" " dashv ")
  ("<vdash>" " vdash ")
  ("<cap>" " cap ")
  ("<cup>" " cup ")
  ("<sqcap>" " sqcap ")
  ("<sqcup>" " sqcup ")
  ("<uplus>" " uplus ")
  ("<oplus>" " oplus ")
  ("<ominus>" " ominus ")
  ("<otimes>" " otimes ")
  ("<oslash>" " oslash ")
  ("<odot>" " odot ")
  ("<obar>" " obar ")
  ("<varocircle>" " varocircle ")
  ("<circledast>" " circledast ")
  ("<boxplus>" " boxplus ")
  ("<boxminus>" " boxminus ")
  ("<boxtimes>" " boxtimes ")
  ("<boxslash>" " boxslash ")
  ("<boxbox>" " boxbox ")
  ("<boxbar>" " boxbar ")
  ("<boxast>" " boxast ")

  ;; accents
  ("<bar>" "bar ")
  ("<vect>" "vect ")
  ("<check>" "check ")
  ("<breve>" "breve ")
  ("<dot>" "dot ")
  ("<ddot>" "ddot ")
  ("<accute>" "accute ")
  ("<grave>" "grave ")

;; Special glyphs available in TeXmacs. Unicode actually has equivalents for
;; most of these in the MathML character set, which may be used as identifier
;; constituents in Pure. Unfortunately, those code points are different from
;; what TeXmacs uses internally, so it won't display the MathML characters
;; correctly if Pure sends them. Thus, in order to make these glyphs just work
;; without causing too much havoc, for the time being we map them to ordinary
;; Latin letters instead. Note that this means that Pure won't be able to
;; distinguish, say, 𝔄, 𝓐 or 𝔸 from A, so these will all denote the same
;; identifier in Pure.

  ("<bbb-A>" "AA")
  ("<bbb-B>" "BB")
  ("<bbb-C>" "CC")
  ("<bbb-D>" "DD")
  ("<bbb-E>" "EE")
  ("<bbb-F>" "FF")
  ("<bbb-G>" "GG")
  ("<bbb-H>" "HH")
  ("<bbb-I>" "II")
  ("<bbb-J>" "JJ")
  ("<bbb-K>" "KK")
  ("<bbb-L>" "LL")
  ("<bbb-M>" "MM")
  ("<bbb-N>" "NN")
  ("<bbb-O>" "OO")
  ("<bbb-P>" "PP")
  ("<bbb-Q>" "QQ")
  ("<bbb-R>" "RR")
  ("<bbb-S>" "SS")
  ("<bbb-T>" "TT")
  ("<bbb-U>" "UU")
  ("<bbb-V>" "VV")
  ("<bbb-W>" "WW")
  ("<bbb-X>" "XX")
  ("<bbb-Y>" "YY")
  ("<bbb-Z>" "ZZ")

  ("<bbb-a>" "aa")
  ("<bbb-b>" "bb")
  ("<bbb-c>" "cc")
  ("<bbb-d>" "dd")
  ("<bbb-e>" "ee")
  ("<bbb-f>" "ff")
  ("<bbb-g>" "gg")
  ("<bbb-h>" "hh")
  ("<bbb-i>" "ii")
  ("<bbb-j>" "jj")
  ("<bbb-k>" "kk")
  ("<bbb-l>" "ll")
  ("<bbb-m>" "mm")
  ("<bbb-n>" "nn")
  ("<bbb-o>" "oo")
  ("<bbb-p>" "pp")
  ("<bbb-q>" "qq")
  ("<bbb-r>" "rr")
  ("<bbb-s>" "ss")
  ("<bbb-t>" "tt")
  ("<bbb-u>" "uu")
  ("<bbb-v>" "vv")
  ("<bbb-w>" "ww")
  ("<bbb-x>" "xx")
  ("<bbb-y>" "yy")
  ("<bbb-z>" "zz")

  ("<cal-A>" "A")
  ("<cal-B>" "B")
  ("<cal-C>" "C")
  ("<cal-D>" "D")
  ("<cal-E>" "E")
  ("<cal-F>" "F")
  ("<cal-G>" "G")
  ("<cal-H>" "H")
  ("<cal-I>" "I")
  ("<cal-J>" "J")
  ("<cal-K>" "K")
  ("<cal-L>" "L")
  ("<cal-M>" "M")
  ("<cal-N>" "N")
  ("<cal-O>" "O")
  ("<cal-P>" "P")
  ("<cal-Q>" "Q")
  ("<cal-R>" "R")
  ("<cal-S>" "S")
  ("<cal-T>" "T")
  ("<cal-U>" "U")
  ("<cal-V>" "V")
  ("<cal-W>" "W")
  ("<cal-X>" "X")
  ("<cal-Y>" "Y")
  ("<cal-Z>" "Z")

  ("<frak-A>" "A")
  ("<frak-B>" "B")
  ("<frak-C>" "C")
  ("<frak-D>" "D")
  ("<frak-E>" "E")
  ("<frak-F>" "F")
  ("<frak-G>" "G")
  ("<frak-H>" "H")
  ("<frak-I>" "I")
  ("<frak-J>" "J")
  ("<frak-K>" "K")
  ("<frak-L>" "L")
  ("<frak-M>" "M")
  ("<frak-N>" "N")
  ("<frak-O>" "O")
  ("<frak-P>" "P")
  ("<frak-Q>" "Q")
  ("<frak-R>" "R")
  ("<frak-S>" "S")
  ("<frak-T>" "T")
  ("<frak-U>" "U")
  ("<frak-V>" "V")
  ("<frak-W>" "W")
  ("<frak-X>" "X")
  ("<frak-Y>" "Y")
  ("<frak-Z>" "Z")

  ("<frak-a>" "a")
  ("<frak-b>" "b")
  ("<frak-c>" "c")
  ("<frak-d>" "d")
  ("<frak-e>" "e")
  ("<frak-f>" "f")
  ("<frak-g>" "g")
  ("<frak-h>" "h")
  ("<frak-i>" "i")
  ("<frak-j>" "j")
  ("<frak-k>" "k")
  ("<frak-l>" "l")
  ("<frak-m>" "m")
  ("<frak-n>" "n")
  ("<frak-o>" "o")
  ("<frak-p>" "p")
  ("<frak-q>" "q")
  ("<frak-r>" "r")
  ("<frak-s>" "s")
  ("<frak-t>" "t")
  ("<frak-u>" "u")
  ("<frak-v>" "v")
  ("<frak-w>" "w")
  ("<frak-x>" "x")
  ("<frak-y>" "y")
  ("<frak-z>" "z")

  ("<b-up-A>" "A")
  ("<b-up-B>" "B")
  ("<b-up-C>" "C")
  ("<b-up-D>" "D")
  ("<b-up-E>" "E")
  ("<b-up-F>" "F")
  ("<b-up-G>" "G")
  ("<b-up-H>" "H")
  ("<b-up-I>" "I")
  ("<b-up-J>" "J")
  ("<b-up-K>" "K")
  ("<b-up-L>" "L")
  ("<b-up-M>" "M")
  ("<b-up-N>" "N")
  ("<b-up-O>" "O")
  ("<b-up-P>" "P")
  ("<b-up-Q>" "Q")
  ("<b-up-R>" "R")
  ("<b-up-S>" "S")
  ("<b-up-T>" "T")
  ("<b-up-U>" "U")
  ("<b-up-V>" "V")
  ("<b-up-W>" "W")
  ("<b-up-X>" "X")
  ("<b-up-Y>" "Y")
  ("<b-up-Z>" "Z")

  ("<b-a>" "a")
  ("<b-b>" "b")
  ("<b-c>" "c")
  ("<b-d>" "d")
  ("<b-e>" "e")
  ("<b-f>" "f")
  ("<b-g>" "g")
  ("<b-h>" "h")
  ("<b-i>" "i")
  ("<b-j>" "j")
  ("<b-k>" "k")
  ("<b-l>" "l")
  ("<b-m>" "m")
  ("<b-n>" "n")
  ("<b-o>" "o")
  ("<b-p>" "p")
  ("<b-q>" "q")
  ("<b-r>" "r")
  ("<b-s>" "s")
  ("<b-t>" "t")
  ("<b-u>" "u")
  ("<b-v>" "v")
  ("<b-w>" "w")
  ("<b-x>" "x")
  ("<b-y>" "y")
  ("<b-z>" "z")

  ("<b-0>" "0")
  ("<b-1>" "1")
  ("<b-2>" "2")
  ("<b-3>" "3")
  ("<b-4>" "4")
  ("<b-5>" "5")
  ("<b-6>" "6")
  ("<b-7>" "7")
  ("<b-8>" "8")
  ("<b-9>" "9")

  ("<alpha>"      "alpha")
  ("<beta>"       "beta")
  ("<gamma>"      "gamma")
  ("<delta>"      "delta")
  ("<epsilon>"    "epsilon")
  ("<varepsilon>" "epsilon")
  ("<zeta>"       "zeta")
  ("<eta>"        "eta")
  ("<theta>"      "theta")
  ("<vartheta>"   "theta")
  ("<iota>"       "iota")
  ("<kappa>"      "kappa")
  ("<lambda>"     "lambda")
  ("<mu>"         "mu")
  ("<nu>"         "nu")
  ("<xi>"         "xi")
  ("<omicron>"    "omicron")
  ("<pi>"         "pi")
  ("<varpi>"      "pi")
  ("<rho>"        "rho")
  ("<varrho>"     "varrho")
  ("<sigma>"      "sigma")
  ("<varsigma>"   "sigma")
  ("<tau>"        "tau")
  ("<upsilon>"    "upsilon")
  ("<phi>"        "phi")
  ("<varphi>"     "phi")
  ("<chi>"        "chi")
  ("<psi>"        "psi")
  ("<omega>"      "omega")

  ("<Alpha>"      "Alpha")
  ("<Beta>"       "Beta")
  ("<Gamma>"      "Gamma")
  ("<Delta>"      "Delta")
  ("<Epsilon>"    "Epsilon")
  ("<Zeta>"       "Zeta")
  ("<Eta>"        "Eta")
  ("<Theta>"      "Theta")
  ("<Iota>"       "Iota")
  ("<Kappa>"      "Kappa")
  ("<Lambda>"     "Lambda")
  ("<Mu>"         "Mu")
  ("<Nu>"         "Nu")
  ("<Xi>"         "Xi")
  ("<Omicron>"    "Omicron")
  ("<Pi>"         "Pi")
  ("<Rho>"        "Rho")
  ("<Sigma>"      "Sigma")
  ("<Tau>"        "Tau")
  ("<Upsilon>"    "Upsilon")
  ("<Phi>"        "Phi")
  ("<Chi>"        "Chi")
  ("<Psi>"        "Psi")
  ("<Omega>"      "Omega")))

;; FIXME: Is it really necessary to register a separate converter for each and
;; every plugin here even though the converters are all the same? This is
;; awfully clumsy. But AFAICT plugin and converter *must* always have the same
;; name to make them work together.

(eval `(plugin-input-converters fricas ,@fricas-converters))
;(eval `(plugin-input-converters fricas-debug ,@fricas-converters))
;(eval `(plugin-input-converters fricas-math ,@fricas-converters))
;(eval `(plugin-input-converters fricas-script ,@fricas-converters))
;(eval `(plugin-input-converters fricas-script-math ,@fricas-converters))

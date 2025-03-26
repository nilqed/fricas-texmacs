# fricas-texmacs
FriCAS &amp; TeXmacs (plugin enhancements + SPAD support)

:construction: work in progress :warning:

### Improved Math Input 
Using the pattern matcher of guile/scheme.

![math-input](./docs/math-input.jpg?raw=true)

### Package TMSPT (tmspt.spad)
The `TexmacsSupport` package allows to control most of the __TeXmacs__
menu commands from __FriCAS__.

![tmspt](./docs/tmspt.jpg?raw=true)


### .fricas.input
One may use the FriCAS startup file `~/.fricas.input`  to tailor the initial
__TeXmacs__ environment.

Example:

    -- Usage: quickLoad pkg 
    -- => same as )lisp (ql:quickload pkg)
    macro quickLoad(s) ==
      syscmd(s) ==> systemCommand(s)$MoreSystemCommands
      lisp2(f,a) ==> syscmd string(FORMAT('NIL,"lisp (~A _"~A_")",f,a)$Lisp)
      syscmd "lisp (defvar |$inclAssertions| NIL)" 
      lisp2("load", "~/quicklisp/setup")
      lisp2("ql:quickload",s)

    -- Usage: setPromot("beforeNumber","afterNumber")
    -- Example: setprompt("",". ") --> "10. " instead of "(10)-> "
    macro setPrompt(beg,end) ==
      syscmd(s) ==> systemCommand(s)$MoreSystemCommands
      fmt1:="(DEFUN MKPROMPT () (PROG () (RETURN (STRCONC " 
      fmt2:="(STRINGIMAGE |$IOindex|) " 
      fmt3:= "))))"
      cmd:="lisp " fmt1  "_"" beg "_"" fmt2 "_"" end "_"" fmt3
      syscmd(cmd)  

    -- Usgae: lisp str (evaluates the string in Lisp and returns an SExpression)
    lisp(s:String):SExpression == EVAL(READ_-FROM_-STRING(s)$Lisp)$Lisp

    -- If one calls the following macro, the prompt will be changed
    -- the package TMSPT will be loaded (if in ~/quicklisp/local-projects), 
    -- the "types" output will be redefined and the start banner will be deleted.
    macro tmenv ==
      setPrompt("",". ")
      quickLoad tmspt
      ioHook()
      removeBanner()



  



TODO: 
* more math input patterns
* menu
* documentation
* tidy up


:date: 15-JAN-2025

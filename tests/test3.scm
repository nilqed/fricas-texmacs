(document (TeXmacs "2.1.4") (style (tuple "generic")) (body (document (session "fricas" "defau lt" (document (folded-io (document "(6) -<gtr> ") (document ")read test_serializer.input ") (document "-- texmacs -x \\\"(begin (make-session \\\\\\\"fricas\\\\\\\" \\\\\\\"default\\\\\\\")(display \\\\\\\"Hello\\\\\\\"))\\\"" "-- fri$ ==<gtr> starts fricas session" "--  texmacs -x \\\"(begin " "--    (make-session \\\\\\\"fricas\\\\\\\" \\\\\\\"default\\\\\\\")(insert  \\\\\\\"Hello\\\\\\\"))\\\"" "" "" "--start with in work/fricas+texmacs:  ./tmfs.sh $PWD/test_serializer.input" "quickLoad tmspt" " " "Value = |$inclAssertions|" "Value = T" "To load \\\"tmspt\\\":" "  Load 1 ASDF system:" "    tmspt" "; Loading \\\"tmspt\\\"" "   The current FriCAS default directory is " "      /home/kfp/quicklisp/local-projects/spadlib/tmspt/lib " "   Compiling FriCAS source code from file " "      /home/kfp/quicklisp/local-projects/spadlib/tmspt/lib/../src/tmspt.spad" "      using old system compiler." "   TMSPT abbreviates package TexmacsSupport ")) (input-math "Fricas] " (document "")) (unfolded-io-math (document "(6) -<gtr> ") (document (frac "d f" "d x")) (document (with "color" "darkgrey" "font-size" "0.59" "Compiling function tmMath with type String -<gtr> String ") (with "mode" "math" (text (concat "\\\"" (math "((d f)/(d x))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (unfolded-io-math (document "16. ") (document (frac (concat "d f" (around* "(" "x" ")")) "d x")) (document "" (with "mode" "math" (text (concat "\\\"" (math "p1: (((y . d x) (x2 . x) (x1 . d f)))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (unfolded-io-math (document "17. ") (document (frac (concat "d" (rsup "m") "H" (around* "(" "u" ")")) (concat "d u" (rsup "m")))) (document "" (with "mode" "math" (text (concat "\\\"" (math "p2: (((y2 . m) (y1 . d u) (x4 . u) (x3 . H) (x2 . m) (x1 . d)))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (unfolded-io-math (document "18. ") (document (frac (concat "<partial>f" (around* "(" "x,y,z" ")")) "<partial>z")) (document "" (with "mode" "math" (text (concat "\\\"" (math "p1: (((y . <partial>z) (x2 . x,y,z) (x1 . <partial>f)))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (unfolded-io-math (document "19. ") (document (frac (concat "<partial>" (rsup "m") "G" (around* "(" "x,y,z" ")")) (concat "<partial>x" (rsup "m")))) (document "" (with "mode" "math" (text (concat "\\\"" (math "p2: (((y2 . m) (y1 . <partial>x) (x4 . x,y,z) (x3 . G) (x2 . m) (x1 . <partial>)))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (unfolded-io-math (document "20. ") (document (frac (concat "<partial>" (rsup "m") "G" (around* "(" "x,y,z" ")")) (concat "<partial>x" (rsup "m") " <partial>y" (rsup "r")))) (document "" (with "mode" "math" (text (concat "\\\"" (math "(( d ^(m)G(x,y,z))/( d x^(m)  d y^(r)))") "\\\""))) (with "color" "darkgrey" "font-size" "0.59" "Type: String "))) (input-math (document "21. ") (document "")))))) (initial (collection (associate "page-medium" "paper"))))


(frac (concat "<partial>" (rsup "m") "G" (around* "(" "x,y,z" ")")) (concat "<partial>x" (rsup "m") " <partial>y" (rsup "r"))))

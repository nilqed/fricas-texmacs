#!/bin/bash
infile="/home/kfp/Desktop/work/spadlib/tmspt/test/test_gle.input"
texmacs -x  "(begin \
   (make-session \"fricas\" \"default\") \ 
   (field-remove-banner (focus-tree)) \ 
   (insert  \")read $infile \")  \
   (session-evaluate-all))"

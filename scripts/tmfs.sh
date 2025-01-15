#!/bin/bash
if [ -z "$1" ]; then echo *.input ... filename expected; exit 1; fi
texmacs -x  "(begin \
   (make-session \"fricas\" \"default\") \ 
   (field-remove-banner (focus-tree)) \ 
   (insert  \")read $1 \")  \
   (session-evaluate-all))"

<TeXmacs|2.1.4>

<style|generic>

<\body>
  <\session|fricas|defau lt>
    <\folded-io>
      (6) -\<gtr\>\ 
    <|folded-io>
      )read test_serializer.input\ 
    <|folded-io>
      -- texmacs -x "(begin (make-session \\"fricas\\" \\"default\\")(display
      \\"Hello\\"))"

      -- fri$ ==\<gtr\> starts fricas session

      -- \ texmacs -x "(begin\ 

      -- \ \ \ (make-session \\"fricas\\" \\"default\\")(insert
      \ \\"Hello\\"))"

      \;

      \;

      --start with in work/fricas+texmacs: \ ./tmfs.sh
      $PWD/test_serializer.input

      quickLoad tmspt

      \ 

      Value = \|$inclAssertions\|

      Value = T

      To load "tmspt":

      \ \ Load 1 ASDF system:

      \ \ \ \ tmspt

      ; Loading "tmspt"

      \ \ \ The current FriCAS default directory is\ 

      \ \ \ \ \ \ /home/kfp/quicklisp/local-projects/spadlib/tmspt/lib\ 

      \ \ \ Compiling FriCAS source code from file\ 

      \ \ \ \ \ \ /home/kfp/quicklisp/local-projects/spadlib/tmspt/lib/../src/tmspt.spad

      \ \ \ \ \ \ using old system compiler.

      \ \ \ TMSPT abbreviates package TexmacsSupport\ 
    </folded-io>

    <\input-math|Fricas] >
      \;
    </input-math>

    <\unfolded-io-math>
      (6) -\<gtr\>\ 
    <|unfolded-io-math>
      <frac|d f|d x>
    <|unfolded-io-math>
      <with|color|darkgrey|font-size|0.59|Compiling function tmMath with type
      String -\<gtr\> String >

      <with|mode|math|<text|"<math|((d f)/(d x))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      16.\ 
    <|unfolded-io-math>
      <frac|d f<around*|(|x|)>|d x>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p1: (((y . d x) (x2 . x) (x1 . d f)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      17.\ 
    <|unfolded-io-math>
      <frac|d<rsup|m>H<around*|(|u|)>|d u<rsup|m>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p2: (((y2 . m) (y1 . d u) (x4 . u) (x3 .
      H) (x2 . m) (x1 . d)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      18.\ 
    <|unfolded-io-math>
      <frac|\<partial\>f<around*|(|x,y,z|)>|\<partial\>z>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p1: (((y . \<partial\>z) (x2 . x,y,z) (x1
      . \<partial\>f)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      19.\ 
    <|unfolded-io-math>
      <frac|\<partial\><rsup|m>G<around*|(|x,y,z|)>|\<partial\>x<rsup|m>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p2: (((y2 . m) (y1 . \<partial\>x) (x4 .
      x,y,z) (x3 . G) (x2 . m) (x1 . \<partial\>)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      20.\ 
    <|unfolded-io-math>
      <frac|\<partial\><rsup|m>G<around*|(|x,y,z|)>|\<partial\>x<rsup|m>
      \<partial\>y<rsup|r>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|(( d ^(m)G(x,y,z))/( d x^(m) \ d
      y^(r)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\input-math>
      21.\ 
    <|input-math>
      \;
    </input-math>
  </session>
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>
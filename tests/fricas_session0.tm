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
      <frac|d f<around*|(|x|)>|d x>
    <|unfolded-io-math>
      <with|color|darkgrey|font-size|0.59|Compiling function tmMath with type
      String -\<gtr\> String >

      <with|mode|math|<text|"<math|p1: (((y . d x) (x2 . x) (x1 . d f)))D( f
      ( x ), x )>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      16.\ 
    <|unfolded-io-math>
      <frac|d<rsup|3> f<around*|(|z|)>|d z<rsup|3>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p2: (((y2 . 3) (y1 . d z) (x4 . z) (x3 .
      \ f) (x2 . 3) (x1 . d)))D( \ f ( z ), z , 3 )>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      20.\ 
    <|unfolded-io-math>
      <frac|\<partial\><rsup|2>f<around*|(|x,y|)>|\<partial\>y<rsup|2>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p2: (((y2 . 2) (y1 . \<partial\>y) (x4 .
      x,y) (x3 . f) (x2 . 2) (x1 . \<partial\>)))D( f ( x,y ), y , 2 )>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      22.\ 
    <|unfolded-io-math>
      <frac|\<partial\><rsup|m+1>f<around*|(|x,y|)>|\<partial\>y<rsup|m+1>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p2: (((y2 . m+1) (y1 . \<partial\>y) (x4 .
      x,y) (x3 . f) (x2 . m+1) (x1 . \<partial\>)))D( f ( x,y ), y , m+1
      )>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      25.\ 
    <|unfolded-io-math>
      continuedFraction(5/8)
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|continuedFraction(5/8)>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io>
      26.\ 
    <|unfolded-io>
      continuedFraction(5/8)
    <|unfolded-io>
      \;

      <with|mode|math|<frac|1|1+<frac|1|1+<frac|1|1+<frac|1|2>>>>>

      <with|color|darkgrey|font-size|0.59|Type: ContinuedFraction(Integer) >
    </unfolded-io>

    <\unfolded-io-math>
      27.\ 
    <|unfolded-io-math>
      \<alpha\>+\<beta\>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|alpha+beta>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      28.\ 
    <|unfolded-io-math>
      2/8
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|2/8>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      29.\ 
    <|unfolded-io-math>
      <around*|[|1,2333|]>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|[1,2333]>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      30.\ 
    <|unfolded-io-math>
      taylor<around*|(|sin x,x=0|)>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|taylor(sin x,x=0)>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      31.\ 
    <|unfolded-io-math>
      f:u\<mapsto\>f<around*|(|u|)>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|f:u +-\<gtr\> f(u)>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\input-math>
      32.\ 
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
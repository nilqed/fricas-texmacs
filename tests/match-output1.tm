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

      ------------------------------------------------------------------------

      \ \ \ initializing NRLIB TMSPT for TexmacsSupport\ 

      \ \ \ compiling into NRLIB TMSPT\ 
    </folded-io>

    <\input-math|Fricas] >
      \;
    </input-math>

    <\unfolded-io-math>
      (6) -\<gtr\>\ 
    <|unfolded-io-math>
      <frac|a|b>
    <|unfolded-io-math>
      <with|color|darkgrey|font-size|0.59|Compiling function tmMath with type
      String -\<gtr\> String >

      <with|mode|math|<text|"<math|p0(((y . b) (x . a)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      16.\ 
    <|unfolded-io-math>
      <frac|\<mathd\> f|\<mathd\> x>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p0(((y . d x) (x . d f)))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      22.\ 
    <|unfolded-io-math>
      <frac|\<mathd\> f<around*|(|x|)>|\<mathd\> x>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p0(((y . d x) (x concat d f (around* ( x
      )))))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      23.\ 
    <|unfolded-io-math>
      <frac|\<mathd\><rsup|n> f<around*|(|x|)>|\<mathd\> x<rsup|n>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p0(((y concat d x (rsup n)) (x concat d
      (rsup n) \ f (around* ( x )))))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\unfolded-io-math>
      24.\ 
    <|unfolded-io-math>
      <frac|\<partial\><rsup|p> f<around*|(|x,y,z|)>|\<partial\>
      x<rsup|a>\<partial\> y<rsup|b> \<partial\> z<rsup|c>>
    <|unfolded-io-math>
      \;

      <with|mode|math|<text|"<math|p0(((y concat \<partial\> x (rsup a)
      \<partial\> y (rsup b) \ \<partial\> z (rsup c)) (x concat \<partial\>
      (rsup p) \ f (around* ( x,y,z )))))>">>

      <with|color|darkgrey|font-size|0.59|Type: String >
    </unfolded-io-math>

    <\input-math>
      25.\ 
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
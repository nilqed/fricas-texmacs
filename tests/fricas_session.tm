<TeXmacs|2.1.4>

<style|generic>

<\body>
  <\session|fricas|default>
    <\output>
      Checking for foreign routines

      FRICAS="/usr/local/lib/fricas/target/x86_64-linux-gnu"

      spad-lib="/usr/local/lib/fricas/target/x86_64-linux-gnu//lib/libspad.so"

      foreign routines found

      openServer result -2

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ FriCAS Computer Algebra
      System\ 

      \ \ \ \ \ \ \ \ \ \ \ Version: FriCAS 2024-04-15 built with sbcl
      2.2.9.debian

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Timestamp: Di 28 Mai 2024
      21:49:04 CEST

      -----------------------------------------------------------------------------

      \ \ \ Issue )copyright to view copyright notices.

      \ \ \ Issue )summary for a summary of useful system commands.

      \ \ \ Issue )quit to leave FriCAS and return to shell.

      -----------------------------------------------------------------------------

      \ 

      \ \ \ Function declaration sixel : TexFormat -\<gtr\> Void has been
      added to\ 

      \ \ \ \ \ \ workspace.

      Value = #\<less\>INTERPRETED-FUNCTION NIL {10020A026B}\<gtr\>
    </output>

    <\unfolded-io>
      (6) -\<gtr\>\ 
    <|unfolded-io>
      x
    <|unfolded-io>
      \;

      <with|mode|math|x>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Variable(x)
    </unfolded-io>

    <\unfolded-io>
      (7) -\<gtr\>\ 
    <|unfolded-io>
      [2/i for i in 1..10]
    <|unfolded-io>
      \;

      <with|mode|math|[2,1,<frac|2|3>,<frac|1|2>,<frac|2|5>,<frac|1|3>,<frac|2|7>,<frac|1|4>,<frac|2|9>,<frac|1|5>]>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      List(Fraction(Integer))
    </unfolded-io>

    <\unfolded-io>
      (8) -\<gtr\>\ 
    <|unfolded-io>
      %*%
    <|unfolded-io>
      \ \ \ There are 31 exposed and 40 unexposed library operations named *\ 

      \ \ \ \ \ \ having 2 argument(s) but none was determined to be
      applicable.\ 

      \ \ \ \ \ \ Use HyperDoc Browse, or issue

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ )display
      op *

      \ \ \ \ \ \ to learn more about the available operations. Perhaps\ 

      \ \ \ \ \ \ package-calling the operation or using coercions on the
      arguments

      \ \ \ \ \ \ will allow you to apply the operation.

      \ 

      \ \ \ Cannot find a definition or applicable library operation named *\ 

      \ \ \ \ \ \ with argument type(s)\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ List(Fraction(Integer))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ List(Fraction(Integer))

      \ \ \ \ \ \ 

      \ \ \ \ \ \ Perhaps you should use "@" to indicate the required return
      type,\ 

      \ \ \ \ \ \ or "$" to specify which version of the function you need.

      \;
    </unfolded-io>

    <\unfolded-io>
      (8) -\<gtr\>\ 
    <|unfolded-io>
      2*%
    <|unfolded-io>
      \;

      <with|mode|math|[4,2,<frac|4|3>,1,<frac|4|5>,<frac|2|3>,<frac|4|7>,<frac|1|2>,<frac|4|9>,<frac|2|5>]>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Vector(Fraction(Integer))
    </unfolded-io>

    <\unfolded-io>
      (9) -\<gtr\>\ 
    <|unfolded-io>
      %/6
    <|unfolded-io>
      \ \ \ There are 11 exposed and 15 unexposed library operations named /\ 

      \ \ \ \ \ \ having 2 argument(s) but none was determined to be
      applicable.\ 

      \ \ \ \ \ \ Use HyperDoc Browse, or issue

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ )display
      op /

      \ \ \ \ \ \ to learn more about the available operations. Perhaps\ 

      \ \ \ \ \ \ package-calling the operation or using coercions on the
      arguments

      \ \ \ \ \ \ will allow you to apply the operation.

      \ 

      \ \ \ Cannot find a definition or applicable library operation named /\ 

      \ \ \ \ \ \ with argument type(s)\ 

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Vector(Fraction(Integer))

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ PositiveInteger

      \ \ \ \ \ \ 

      \ \ \ \ \ \ Perhaps you should use "@" to indicate the required return
      type,\ 

      \ \ \ \ \ \ or "$" to specify which version of the function you need.

      \;
    </unfolded-io>

    <\unfolded-io>
      (9) -\<gtr\>\ 
    <|unfolded-io>
      1/7*%
    <|unfolded-io>
      \;

      <with|mode|math|[<frac|4|7>,<frac|2|7>,<frac|4|21>,<frac|1|7>,<frac|4|35>,<frac|2|21>,<frac|4|49>,<frac|1|14>,<frac|4|63>,<frac|2|35>]>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Vector(Fraction(Integer))
    </unfolded-io>

    <\unfolded-io>
      (10) -\<gtr\>\ 
    <|unfolded-io>
      x
    <|unfolded-io>
      \;

      <with|mode|math|x>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Variable(x)

      <timing|64 msec>
    </unfolded-io>

    <\unfolded-io>
      (11) -\<gtr\>\ 
    <|unfolded-io>
      )edit
    <|unfolded-io>
      \;

      Warning: environment variable FRICASEDITOR not set.

      Launching 'less' in an 'xterm'.

      Press space to continue, 'q' to quit.

      <timing|13.69 sec>
    </unfolded-io>

    <\unfolded-io>
      (11) -\<gtr\>\ 
    <|unfolded-io>
      )system pwd
    <|unfolded-io>
      /home/kfp

      <timing|42 msec>
    </unfolded-io>

    <\unfolded-io-math>
      (12) -\<gtr\>\ 
    <|unfolded-io-math>
      <big|sum><rsub|j=1><rsup|12>floor<around*|(|j|)>
    <|unfolded-io-math>
      \;

      <with|mode|math|78>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Integer)

      <timing|73 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (13) -\<gtr\>\ 
    <|unfolded-io-math>
      <big|sum><rsub|k=1><rsup|12>\<mathe\><rsup|\<mathi\>*k*<frac|\<mathpi\>|12>>
    <|unfolded-io-math>
      \;

      <with|mode|math|-<frac|2*\<mathe\><rsup|<frac|\<mathi\>*\<mathpi\>|12>>|\<mathe\><rsup|<frac|\<mathi\>*\<mathpi\>|12>>-1>>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Complex(Integer))

      <timing|163 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (14) -\<gtr\>\ 
    <|unfolded-io-math>
      <big|int>\<mathe\><rsup|-x<rsup|2>> d x
    <|unfolded-io-math>
      \;

      <with|mode|math|<frac|erf(x)*<sqrt|\<mathpi\>>|2>>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Union(Expression(Integer),...)

      <timing|207 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (15) -\<gtr\>\ 
    <|unfolded-io-math>
      <frac|d erf<around*|(|z|)>|d z>
    <|unfolded-io-math>
      \;

      <with|mode|math|<frac|2*\<mathe\><rsup|(-z<rsup|2>)>|<sqrt|\<mathpi\>>>>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Integer)

      <timing|83 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (16) -\<gtr\>\ 
    <|unfolded-io-math>
      <frac|d Gamma<around*|(|x|)>|d x>
    <|unfolded-io-math>
      \;

      <with|mode|math|Gamma(x)*digamma(x)>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Integer)

      <timing|78 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (17) -\<gtr\>\ 
    <|unfolded-io-math>
      <big|prod><rsub|k=1><rsup|12>k<rsup|2>
    <|unfolded-io-math>
      \;

      <with|mode|math|229442532802560000>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Integer)

      <timing|59 msec>
    </unfolded-io-math>

    <\unfolded-io-math>
      (18) -\<gtr\>\ 
    <|unfolded-io-math>
      <frac|\<partial\> cosh<around*|(|x*y|)>|\<partial\>x>
    <|unfolded-io-math>
      \;

      <with|mode|math|y*sinh(x*y)>

      \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Type:
      Expression(Integer)

      <timing|84 msec>
    </unfolded-io-math>

    <\input-math>
      (19) -\<gtr\>\ 
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
<TeXmacs|2.1.4>

<style|tmdoc>

<\body>
  <\tmdoc-title>
    FriCAS & <TeXmacs>
  </tmdoc-title>

  <section|Introduction>

  FriCAS <cite|bib-FriCAS:website> and <TeXmacs> <cite|TeXmacs:website> are
  well documented, so that we can set the focus on the essential parts of
  their interplay. In the first place there is the FriCAS plugin that comes
  with the <TeXmacs> installation and comprises the main interface between
  the tho pieces of software. This plugin was mainly developed by Andrey
  Grozin (2012) and has hardly experienced any changes since then, speaking
  for its stability (yet, we will propose some improvements). In the second
  place we will present a FriCAS package (TexmacsSupport/TMSPT) that will
  allow to control many parts of the <TeXmacs> user interface from within
  Fricas itself, this means programatically (SPAD) or while in the
  interpreter (plugin session). The goal of this article is - besides
  describing new features - to give a comprehensive overview of how things
  work in order to provide a hook for future developers.

  <subsection|<TeXmacs> Installation & Startup>

  There are various ways how to install <TeXmacs> depending on your operating
  system. In the cases of <hlink|Debian|https://www.texmacs.org/tmweb/download/linux-repos.en.html#debian>
  and <hlink|Ubuntu|https://www.texmacs.org/tmweb/download/linux-repos.en.html#ubuntu>,
  therei is also a way to add a TeXmacs repository to the package manager
  (apt) which makes it easy to detect and install new versions. We refer to
  \ <cite|TeXmacs:website> (Topic: Download) and tacitly assume that
  <TeXmacs> is installed and working. The start options may be seen by
  entering the shell command:

  \ 

  <\verbatim>
    <\with|font-base-size|8>
      \ <with|color|dark red|texmacs --help>

      \;

      Options for TeXmacs:

      \;

      \ \ -b [file] \ Specify scheme buffers initialization file

      \ \ -C [i] [o] Convert file 'i' into file 'o'

      \ \ -d \ \ \ \ \ \ \ \ For debugging purposes

      \ \ -fn [font] Set the default TeX font

      \ \ -g [geom] \ Set geometry of window in pixels

      \ \ -h \ \ \ \ \ \ \ \ Display this help message

      \ \ -H \ \ \ \ \ \ \ \ Run TeXmacs in headless mode

      \ \ -i [file] \ Specify scheme initialization file

      \ \ -p \ \ \ \ \ \ \ \ Get the TeXmacs path

      \ \ -q \ \ \ \ \ \ \ \ Shortcut for -x "(quit-TeXmacs)"

      \ \ -r \ \ \ \ \ \ \ \ Reverse video mode

      \ \ -s \ \ \ \ \ \ \ \ Suppress information messages

      \ \ -S \ \ \ \ \ \ \ \ Rerun TeXmacs setup program before starting

      \ \ -v \ \ \ \ \ \ \ \ Display current TeXmacs version

      \ \ -V \ \ \ \ \ \ \ \ Show some informative messages

      \ \ -W [i] [o] Recursively convert directory into website

      \ \ -x [cmd] \ \ Execute scheme command

      \ \ -Oc \ \ \ \ \ \ \ TeX characters bitmap clipping off
    </with>

    <\with|font-base-size|8>
      \ \ +Oc \ \ \ \ \ \ \ TeX characters bitmap clipping on (default)

      Please report bugs to \<less\>bugs@texmacs.org\<gtr\>
    </with>

    \;
  </verbatim>

  The option <with|color|dark red|<verbatim|-x [cmd]>> will be particularly
  interesting for us. Furthermore it is good to know the path and version of
  the installed <TeXmacs>:

  <\verbatim>
    <\with|font-base-size|8>
      $ texmacs -p

      /usr/local/share/TeXmacs

      $ texmacs -v

      TeXmacs version 2.1.4

      SVN version Custom\ 

      (c) 1999-2020 by Joris van der Hoeven and others
    </with>

    \;
  </verbatim>

  The directory structure (<with|color|dark red|global>) is\ 

  <\verbatim-code>
    <\verbatim>
      $ ls $(texmacs -p)

      doc \ \ \ \ \ \ fonts \ LICENSE \ packages \ progs \ \ texts

      examples \ langs \ misc \ \ \ \ plugins \ \ styles

      \;
    </verbatim>
  </verbatim-code>

  more or less the same as the <with|color|dark red|local> one:

  <\verbatim-code>
    $ ls $HOME/.TeXmacs/

    bin \ fonts \ misc \ \ \ \ \ plugins \ server \ system \ users

    doc \ langs \ packages \ progs \ \ \ styles \ texts

    \;
  </verbatim-code>

  \;

  While <with|color|dark red|<verbatim| ls $(texmacs -p)/plugins>> shows a
  lot of plugins, there are (usually) none in the local directory
  <verbatim|<with|color|dark red|ls $HOME/.TeXmacs/plugins>.> Notice that the
  local directory has preference for plugins and initialization scripts, that
  is when we install a new plugin for FriCAS in the folder<with|color|dark
  red| <verbatim|$ ls $HOME/.TeXmacs/plugins/fricas/>>, this new one will be
  loaded instead of the pre-installed plugin. \ 

  The plugin system and basic communication method (interfaces) to many
  computer algebra and other systems is fairly described in the user manual
  <cite|TeXmacs:manual>:\ 

  <\samp>
    13. The TEXMACS plug-in system

    Appendix D. Interfacing TEXMACS with other programs
  </samp>

  <subsection|> \ \ \ \ \ \ 

  <\bibliography|bib|tm-plain|>
    <\bib-list|3>
      <bibitem*|1><label|bib-TeXmacs:manual>J.<nbsp>van<nbsp>der Hoeven.
      <newblock><with|font-shape|italic|GNU TeXmacs User Manual>.
      <newblock>1998. <newblock>Available from
      <slink|https://www.texmacs.org>.<newblock>

      <bibitem*|2><label|bib-TeXmacs:website>.<nbsp>van<nbsp>der Hoeven
      et<nbsp>al. <newblock>GNU TeXmacs. <newblock><slink|https://www.texmacs.org>,
      1998.<newblock>

      <bibitem*|3><label|bib-FriCAS:website>FriCAS.
      <newblock><slink|https://www.fricas.org>.
    </bib-list>

    \;
  </bibliography>

  \;
</body>

<\initial>
  <\collection>
    <associate|page-medium|paper>
  </collection>
</initial>
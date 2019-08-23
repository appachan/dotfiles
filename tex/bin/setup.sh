#!/bin/sh

sudo tlmgr update --self --all
sudo tlmgr install collection-langjapanese

curl -fsSL 'https://osdn.net/frs/redir.php?m=jaist&f=mytexpert%2F26068%2Fjlisting.sty.bz2' | bzip2 -d > $ROOT/tex/jlisting.sty
echo please cp $ROOT/tex/jlisting.sty to /usr/local/texlive/201\*basic/texmf-dist/tex/latex/listings/jlisting.sty .

ghc dl.hs main.hs $HX && ./main "salvador-dali"
ghc dl.hs main.hs  $HX && ./main "michelangelo"


stack install http-conduit conduit resourcet async regex-posix

stack ghc colors.hs dl.hs main.hs && rm -f *.hi && rm -f *.o && ./main $1 -RTS 8 -rtsopts +RTS -s -ol main.eventlog


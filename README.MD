
./run.sh "salvador-dali"
./run.sh "michelangelo"
./run.sh "m-c-escher"

stack install http-conduit conduit resourcet async regex-posix

stack ghc colors.hs dl.hs main.hs && rm -f *.hi && rm -f *.o && ./main $1 -RTS 8 -rtsopts +RTS -s -ol main.eventlog


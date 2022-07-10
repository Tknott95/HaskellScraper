#!/bin/bash

# stack will not allow for some ghc flags, or idk the work around
 stack ghc colors.hs dl.hs main.hs  --rts-options -threaded  && rm -f *.hi && rm -f *.o && rm -f hreaded && ./main $1 -RTS -N4 +RTS -s 

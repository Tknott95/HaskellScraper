Concurrent art scraper for archiving purposes or data collection - this was just a quick project to extend on top of an ai

-- STATIC BATCHING AND CORES - UGLY REGEX - NEEDS A TINY REFACTOR - WAS QUICK AND DIRTY FOR SCRAPING
-- This needs to check how many cores then batch dynamically instead of using static batching as well as mapConcurrently. This was a aquick and dirty build and def needs a refactor. 

The website I am scraping for art, as this was a quick project for art data collection, throws some links up as (1). It is faster to concurrently scrape (1) rather than to run conditions. 

This can handle HTTPS as well.

I went with nested conc and such at first but found that concurrently did the job perfect.

I can utilize query params, in the future, on each pull to grab diff resolutions if you want to on this part of the pipeline as it would increase speed and have to be done for the AI. 

This needs to check how many cores then batch dynamically instead of using static batching as well as mapConcurrently. This was a aquick and dirty build and def needs a refactor. 


@TODO
 - use mapConcurrently to batch dynamically and use what cores allow instead of static batching and threading
 
**CABAL**
 
`cabal run hScrape "salvador-dali"`

`cabal run hScrape "michelangelo"`

`cabal run hScrape "m-c-escher"`



**STACK**
 
 `./install.sh`

`./run.sh "salvador-dali"`

`./run.sh "michelangelo"`

`./run.sh "m-c-escher"`


``` install packages with stack.
  stack install http-conduit conduit resourcet async regex-posix
```
``` just use the ./run.sh <artist-name> script
  stack ghc colors.hs dl.hs main.hs && rm -f *.hi && rm -f *.o && ./main $1 -RTS 8 -rtsopts +RTS -s -ol main.eventlog
```

##### CODE WILL BE CLEANED AT A LATER DATE - THIS WASNT GOING TO BE OPEN SOURCED

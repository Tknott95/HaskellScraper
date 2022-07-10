Concurrent art scraper for archiving purposes or data collection - this was just a quick project to extend on top of an ai


The website I am scraping for art, as this was a quick project for art data collection, throws some links up as (1). It is faster to concurrently scrape (1) rather than to run conditions. 


I went with nested conc and such at first but found that concurrently did the job perfect.

I can utilize query params, in the future, on each pull to grab diff resolutions if you want to on this part of the pipeline as it would increase speed and have to be done for the AI. 

`./run.sh "salvador-dali"`

`./run.sh "michelangelo"`

`./run.sh "m-c-escher"`

``` install packages with stack.
  stack install http-conduit conduit resourcet async regex-posix
```
``` just use the ./run.sh <artist-name> script
  stack ghc colors.hs dl.hs main.hs && rm -f *.hi && rm -f *.o && ./main $1 -RTS 8 -rtsopts +RTS -s -ol main.eventlog
```

Concurrent art scraper for archiving purposes or data collection - this was just a quick project to extend on top of an ai


The website I am scraping for art, as this was a quick project for art data collection, throws some links up as (1). It is faster to concurrently scrape (1) rather than to run conditions. 


I went with nested conc and such at first but found that concurrently did the job perfect.


./run.sh "salvador-dali"

./run.sh "michelangelo"

./run.sh "m-c-escher"

stack install http-conduit conduit resourcet async regex-posix

stack ghc colors.hs dl.hs main.hs && rm -f *.hi && rm -f *.o && ./main $1 -RTS 8 -rtsopts +RTS -s -ol main.eventlog


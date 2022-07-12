module Main where

-- import Control.Parallel.Strategies
import Control.Concurrent.Async (concurrently)

import Colors as C

import Control.Monad (forM_)
import Control.Monad.IO.Class
import DL (dlFile)
import System.Environment (getArgs)
import System.Directory (createDirectoryIfMissing)

import Network.HTTP.Conduit (simpleHttp)
import qualified Data.ByteString.Lazy as LB
import qualified Data.ByteString as B
import qualified Data.ByteString.Char8 as BC
import Text.Regex.Posix

openURL :: String -> IO LB.ByteString
openURL x = simpleHttp x

rgxTitle :: String -> String -> [String]
rgxTitle _a _artist = getAllTextMatches $ _a =~ rgx
  where rgx = "(\\/en\\/"++_artist++"\\/[a-z1-9-]*)"


rgxTitle2 :: String -> String -> [String]
rgxTitle2 _a _artist = getAllTextMatches $ _a =~ rgxTwo
  where rgxTwo = "([^\\/]*)"

jankySplit :: [a] -> ([a], [a])
jankySplit _xs = splitAt (ijk `div` 2) _xs 
  where
     ijk = (length _xs) + 1

main :: IO ()
main = do
  argVs <- getArgs
  let artist = head argVs
  let dirForSaving = "./hsData/"++artist

  createDirectoryIfMissing True dirForSaving
 
  src <- openURL ("https://www.wikiart.org/en/"++artist++"/all-works/text-list")

  let strictBs = LB.toStrict src
  let stringBS = BC.unpack strictBs
  let rgxTitles = rgxTitle stringBS artist

  print $ rgxTitles

  {- @NOTE
    Avoid lambda using `infix`
    Found:
      (\ x -> rgxTitle2 x artist)
    Why not:
      (`rgxTitle2` artist)

    Avoid lambda using `infix`
    Found:
      (\ x -> x !! 5)
    Why not:
      (!! 5)
  -}
  -- ugly but it works, lol @TODO fix this later
  let rg2 = map(`rgxTitle2` artist) rgxTitles
  let rg3 = map(!! 5) rg2
  
  -- print $ rg2
  print $ rg3

  let rg3Batched = jankySplit rg3
  let batchOne = fst rg3Batched 
  let batchTwo = snd rg3Batched
  -- print $ fst rg3Batched 
  -- print $ snd rg3Batched

  concurrently (
    concurrently (forM_ batchOne $ \x -> dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++".jpg") dirForSaving x ".jpg") (forM_ batchOne $ \x -> dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++"(1).jpg") dirForSaving x "(1).jpg")) (
    concurrently (forM_ batchTwo $ \x -> dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++".jpg") dirForSaving x ".jpg") (forM_ batchTwo $ \x -> dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++"(1).jpg") dirForSaving x "(1).jpg"))

  -- -- forM_ batchOne $ \x ->  async( dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++".jpg") dirForSaving x ".jpg" )
  -- -- forM_ batchOne $ \x ->  async( dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++"(1).jpg") dirForSaving x "(1).jpg" )
  -- -- forM_ batchTwo $ \x ->  async( dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++".jpg") dirForSaving x ".jpg" )
  -- -- forM_ batchTwo $ \x ->  async( dlFile ("https://uploads4.wikiart.org/images/"++artist++"/"++x++"(1).jpg") dirForSaving x "(1).jpg" )

  putStrLn (C.alt2++"\n\n\n SCRIPT COMPLETE \n"++C.clr)

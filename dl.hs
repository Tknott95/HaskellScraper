module DL (dlFile) where

import Colors as C

import           Control.Monad.Trans.Resource (runResourceT)
import           Data.Conduit.Combinators     (sinkFile)
import           Network.HTTP.Conduit         (parseRequest, responseStatus, responseStatus)
import           Network.HTTP.Simple          (httpSink, getResponseStatusCode, httpLBS)

-- @NOTES
--  get req body headers =   'content-type'
--- this checks if media at location
-- nil data is still saving as an image and it is shit
-- this will fk up batches and why filter l8r when I can fix it on fetch
-- some images are under (1)
dlFile :: String -> String -> String -> String -> IO ()
dlFile _url _filePath _fileName _fileType = do
  request <- parseRequest _url
  resp2 <- httpLBS request

  let status = getResponseStatusCode resp2
  putStrLn $ "\nThe status code was: " ++ C.bYlw ++ show status ++ C.clr

  if status == 200 then do
    putStrLn (C.bCyan++"   DOWNLOADING: "++C.clr ++ _url ++ "\n      to: " ++  (_filePath++"/"++_fileName++_fileType) ++ "\n")
    runResourceT $ httpSink request $ \_ -> sinkFile (_filePath++"/"++_fileName++_fileType)
  else putStrLn (C.bRed++"   FAILED DOWNLOADING: "++C.clr ++ _url ++ "\n      FAILED to: " ++  (_filePath++"/"++_fileName++_fileType) ++ "\n")

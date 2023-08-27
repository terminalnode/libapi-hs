{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module LibraryApi
  ( runLibApi,
  )
where

import Api.Hello
import Api.Bye
import Network.Wai.Handler.Warp (run)
import Servant

type LibApi =
  Hello
    :<|> Bye

server :: Server LibApi
server =
  helloHandler
    :<|> byeHandler

libApi :: Proxy LibApi
libApi = Proxy

app :: Application
app = serve libApi server

runLibApi :: IO ()
runLibApi = run 8080 app

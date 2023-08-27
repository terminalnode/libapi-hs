{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module LibraryApi
  ( runLibApi,
  )
where

import Api.GetAuthorById
import Api.GetAllAuthors
import Api.Hello
import Api.Bye
import Network.Wai.Handler.Warp (run)
import Servant
import Database.Persist.Sql (ConnectionPool)

type LibApi =
  Hello
    :<|> Bye
    :<|> GetAuthorById
    :<|> GetAllAuthors

serverWithPool :: ConnectionPool -> Server LibApi
serverWithPool pool =
  helloHandler
    :<|> byeHandler
    :<|> getAuthorByIdHandler pool
    :<|> getAllAuthorsHandler pool

libApi :: Proxy LibApi
libApi = Proxy

appWithPool :: ConnectionPool -> Application
appWithPool pool = serve libApi (serverWithPool pool)

runLibApi :: ConnectionPool -> IO ()
runLibApi pool = run 8080 (appWithPool pool)

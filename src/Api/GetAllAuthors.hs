{-# LANGUAGE DataKinds #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE TypeOperators #-}

module Api.GetAllAuthors
  ( GetAllAuthors,
    getAllAuthorsHandler,
  )
where

import Control.Monad.IO.Class (liftIO)
import Database.Persist.Sql (ConnectionPool, Entity (..), runSqlPool, selectList)
import Dto.AuthorDto (AuthorDtoWrapper (..), fromAuthor)
import Persistence.Models (Author)
import Servant

type GetAllAuthors =
  "author"
    :> "all"
    :> Get '[JSON] AuthorDtoWrapper

getAllAuthorsHandler :: ConnectionPool -> Handler AuthorDtoWrapper
getAllAuthorsHandler pool = do
  dbAuthors :: [Entity Author] <-
    liftIO $ flip runSqlPool pool $ selectList [] []
  return $ AuthorDtoWrapper {authors = map fromAuthor dbAuthors}

{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.GetAuthorById
  ( GetAuthorById,
    getAuthorByIdHandler,
  )
where

import Control.Monad.IO.Class (liftIO)
import Database.Persist.Sql (ConnectionPool, getEntity, runSqlPool, toSqlKey)
import Dto.AuthorDto (AuthorDto, fromAuthor)
import Persistence.Models (AuthorId)
import Servant

type GetAuthorById =
  "author"
    :> Capture "authorId" Int
    :> Get '[JSON] AuthorDto

getAuthorByIdHandler :: ConnectionPool -> Int -> Handler AuthorDto
getAuthorByIdHandler pool authorId = do
  maybeAuthor <- liftIO $
    flip runSqlPool pool $ do
      getEntity (toSqlKey $ fromIntegral authorId :: AuthorId)

  case maybeAuthor of
    Nothing -> throwError err404
    Just author -> return $ fromAuthor author

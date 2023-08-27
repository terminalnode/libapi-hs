{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.GetAuthorById
  ( GetAuthorById,
    getAuthorByIdHandler,
  )
where

import Control.Monad.IO.Class (liftIO)
import Database.Persist.Sql (ConnectionPool, Entity (..), getEntity, runSqlPool, toSqlKey)
import Dto.AuthorDto (AuthorDto, toDto)
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
    Just (Entity key author) -> return $ toDto key author

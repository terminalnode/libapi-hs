{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.GetAuthorById
  ( GetAuthorById,
    getAuthorByIdHandler,
  )
where

import Control.Monad.IO.Class (liftIO)
import qualified Data.Text as T
import Data.Time (getCurrentTime)
import Database.Persist.Sql (ConnectionPool)
import qualified Dto.Author as Dto
import Servant

type GetAuthorById =
  "author"
    :> Capture "authorId" Int
    :> Get '[JSON] Dto.Author

getAuthorByIdHandler :: ConnectionPool -> Int -> Handler Dto.Author
getAuthorByIdHandler pool authorId = do
  currentTime <- liftIO getCurrentTime
  return
    Dto.Author
      { Dto.id = authorId,
        Dto.firstName = T.pack "John",
        Dto.lastName = T.pack "Doe",
        Dto.createdAt = currentTime,
        Dto.updatedAt = currentTime
      }

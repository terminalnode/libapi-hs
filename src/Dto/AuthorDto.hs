{-# LANGUAGE DeriveGeneric #-}

module Dto.AuthorDto
  ( AuthorDto (..),
    toDto,
  )
where

import Data.Aeson
import Data.Text (Text)
import Data.Time (UTCTime)
import Database.Persist.Sql (fromSqlKey)
import GHC.Generics (Generic)
import qualified Persistence.Models as Db
import Prelude hiding (id)

data AuthorDto = AuthorDto
  { id :: Int,
    firstName :: Text,
    lastName :: Text,
    createdAt :: UTCTime,
    updatedAt :: UTCTime
  }
  deriving (Generic, Show)

instance ToJSON AuthorDto

toDto :: Db.AuthorId -> Db.Author -> AuthorDto
toDto key author = do
  AuthorDto
    { id = fromIntegral $ fromSqlKey key,
      firstName = Db.authorFirstName author,
      lastName = Db.authorLastName author,
      createdAt = Db.authorCreatedAt author,
      updatedAt = Db.authorUpdatedAt author
    }

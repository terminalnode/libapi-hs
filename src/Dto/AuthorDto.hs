{-# LANGUAGE DeriveGeneric #-}

module Dto.AuthorDto
  ( AuthorDto (..),
    AuthorDtoWrapper (..),
    fromAuthorWithKey,
    fromAuthorWithEntityKey,
    fromAuthor,
  )
where

import Data.Aeson
import Data.Text (Text)
import Data.Time (UTCTime)
import Database.Persist.Sql (Entity (..), fromSqlKey)
import GHC.Generics (Generic)
import qualified Persistence.Models as Db
import Prelude hiding (id)

newtype AuthorDtoWrapper = AuthorDtoWrapper
  {authors :: [AuthorDto]}
  deriving (Generic, Show)

instance ToJSON AuthorDtoWrapper

data AuthorDto = AuthorDto
  { id :: Int,
    firstName :: Text,
    lastName :: Text,
    createdAt :: UTCTime,
    updatedAt :: UTCTime
  }
  deriving (Generic, Show)

instance ToJSON AuthorDto

fromAuthorWithKey :: Int -> Db.Author -> AuthorDto
fromAuthorWithKey key author =
  AuthorDto
    { id = key,
      firstName = Db.authorFirstName author,
      lastName = Db.authorLastName author,
      createdAt = Db.authorCreatedAt author,
      updatedAt = Db.authorUpdatedAt author
    }

fromAuthorWithEntityKey :: Db.AuthorId -> Db.Author -> AuthorDto
fromAuthorWithEntityKey key = fromAuthorWithKey (fromIntegral $ fromSqlKey key)

fromAuthor :: Entity Db.Author -> AuthorDto
fromAuthor (Entity key author) = fromAuthorWithEntityKey key author

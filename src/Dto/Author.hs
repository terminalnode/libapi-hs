{-# LANGUAGE DeriveGeneric #-}

module Dto.Author
  ( Author (..),
  )
where

import Data.Text (Text)
import Data.Time (UTCTime)
import GHC.Generics (Generic)
import Data.Aeson

data Author = Author
  { id :: Int,
    firstName :: Text,
    lastName :: Text,
    createdAt :: UTCTime,
    updatedAt :: UTCTime
  } deriving (Generic, Show)

instance ToJSON Author
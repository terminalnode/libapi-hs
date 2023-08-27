{-# LANGUAGE DataKinds #-}
{-# LANGUAGE DerivingStrategies #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE UndecidableInstances #-}

module Persistence.Models
  ( migrateAll,
    UserId,
    User,
    BookId,
    Book,
    AuthorId,
    Author,
  )
where

import Data.Text (Text)
import Data.Time (UTCTime)
import Database.Persist.TH

share
  [mkPersist sqlSettings, mkMigrate "migrateAll"]
  [persistLowerCase|
User
  username Text
  password Text
  firstName Text
  lastName Text
  createdAt UTCTime
  updatedAt UTCTime
  deriving Show
Author
  firstName Text
  lastName Text
  createdAt UTCTime
  updatedAt UTCTime
  deriving Show
Book
  title Text
  authorId AuthorId
  year Int
  createdAt UTCTime
  updatedAt UTCTime
  deriving Show
|]

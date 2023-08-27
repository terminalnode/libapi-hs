{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import LibraryApi (runLibApi)
import Persistence.Models (migrateAll)
import Database.Persist.Postgresql (ConnectionString, withPostgresqlPool, runMigration, runSqlPool)
import Control.Monad.Logger (runStderrLoggingT)
import Control.Monad.IO.Class (liftIO)

-- These should obviously be read from a config file, but since they're only the local develop DB credentials
-- there's no rush to get that done. If I can migrate and fetch stuff from the DB I'm happy. :D
connStr :: ConnectionString
connStr = "host=localhost dbname=libapihs user=libapihs_user password=libapihs_pass port=5432"

main :: IO ()
main = runStderrLoggingT $ do
  withPostgresqlPool connStr 10 $ \pool -> do
    runSqlPool (runMigration migrateAll) pool
    liftIO (runLibApi pool)

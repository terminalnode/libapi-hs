{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Hello
  ( Hello,
    helloHandler,
  )
where

import Servant

type Hello = "hello" :> Get '[JSON] String

helloHandler :: Handler String
helloHandler = return "Hello, world!"

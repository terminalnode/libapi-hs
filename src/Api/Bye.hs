{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}

module Api.Bye
  ( Bye,
    byeHandler,
  )
where

import Servant

type Bye = "bye" :> Get '[JSON] String

byeHandler :: Handler String
byeHandler = return "Goodbye, cruel world!"


-- | Helpers for starting a Disciplina node

module Disciplina.Launcher.Runner
       ( runBasicRealMode
       ) where

import Universum

import Mockable (Production)

import Disciplina.Launcher.Mode (BasicRealContext (..), BasicRealMode)
import Disciplina.Launcher.Resource (BasicNodeResources (..))

-- | Given allocated node resources, construct node context and run `WorkMode` monad.
runBasicRealMode ::
       BasicNodeResources
    -> BasicRealMode a
    -> Production a
runBasicRealMode BasicNodeResources {..} action =
    runReaderT action context
  where
    context = BasicRealContext
        { _brcLoggerName = bnrLoggerName
        }

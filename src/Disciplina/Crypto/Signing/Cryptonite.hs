
-- | Signature scheme implementations provided by `crytonite` package.

module Disciplina.Crypto.Signing.Cryptonite
       ( CryptoEd25519 (..)
       ) where

import Universum

import qualified Crypto.PubKey.Ed25519 as Ed25519

import Disciplina.Crypto.Signing.Class (AbstractPK (..), AbstractSK (..), AbstractSig (..),
                                        SignatureScheme (..))

-- | Tag for 'Ed25519' signature scheme implementation from `crytonite`.
data CryptoEd25519 = CryptoEd25519

instance SignatureScheme CryptoEd25519 where
    type PK CryptoEd25519  = Ed25519.PublicKey
    type SK CryptoEd25519  = Ed25519.SecretKey
    type Sig CryptoEd25519 = Ed25519.Signature

    -- TODO: 'toPublic' isn't free in terms of performance; consider
    -- storing secret key as actual keypair.
    unsafeAbstractSign (AbstractSK sk) =
        AbstractSig . Ed25519.sign sk (Ed25519.toPublic sk)

    unsafeAbstractVerify (AbstractPK pk) a (AbstractSig sig) =
        Ed25519.verify pk a sig

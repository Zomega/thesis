module Plot.VectorField where

import System.Process
import Data.Matrix

import Utils.MatrixIO

raw_streamplot :: Matrix Float -> Matrix Float -> Matrix Float -> Matrix Float -> IO ()
raw_streamplot x y u v
    = do
        store "X.matrix#" x
        store "Y.matrix#" y
        store "U.matrix#" u
        store "V.matrix#" v
        pHandle <- runCommand "plot -X X.matrix# -Y Y.matrix# -U U.matrix# -V V.matrix# streamplot"
        return ()

raw_quiverplot :: Matrix Float -> Matrix Float -> Matrix Float -> Matrix Float -> IO ()
raw_quiverplot x y u v
    = do
        store "X.matrix#" x
        store "Y.matrix#" y
        store "U.matrix#" u
        store "V.matrix#" v
        pHandle <- runCommand "plot -X X.matrix# -Y Y.matrix# -U U.matrix# -V V.matrix# quiverplot"
        return ()

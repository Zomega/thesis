module Utils.MatrixIO where

import Data.Matrix
import Data.Spreadsheet

import Control.Monad.Exception.Asynchronous.Lazy


load :: Read a => FilePath -> IO (Matrix a)
load f_name
    = do
        f_contents <- readFile f_name
        let parse_result = fromString '"' ',' f_contents
        let csv = result parse_result
        let matrix = fromLists $ map (map read) csv
        return matrix

store :: Show a => FilePath -> Matrix a -> IO ()
store f_name matrix
    = do 
        let csv = map (map show) $ toLists matrix
        let string = toString '"' ',' csv
        writeFile f_name string

-- TODO: Listings, use Map.Map
--loadListing :: FilePath -> IO [String, Matrix Float]

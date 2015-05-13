{-# LANGUAGE BangPatterns #-}
import qualified Data.Vector as V
import qualified Data.Vector.Unboxed as UV
import qualified Data.ByteString.Char8 as C

data LabelPixel = LabelPixel {_label :: !Int, _pixels :: !(UV.Vector Int)}

trim :: C.ByteString -> C.ByteString
trim = C.reverse . C.dropWhile (`elem` " \t") . C.reverse . C.dropWhile (`elem` " \t")

slurpFile :: FilePath -> IO (V.Vector LabelPixel)
slurpFile = fmap (V.fromList . map make . tail . C.lines) . C.readFile where
  readInt' !bs = let Just (i, _) = C.readInt bs in i
  labelPixel (lbl:pxls) = LabelPixel (readInt' lbl) (UV.fromList $ map readInt' pxls)
  make = labelPixel . C.split ',' . trim

classify :: V.Vector LabelPixel -> UV.Vector Int -> Int
classify !training !pixels = _label mini where
  dist !x !y = UV.sum . UV.map (^2) $ UV.zipWith (-) x y
  comp !p1 !p2 = dist (_pixels p1) pixels `compare` dist (_pixels p2) pixels
  mini = V.minimumBy comp training

main :: IO ()
main = do
  trainingSet <- slurpFile "trainingsample.csv"
  validationSample <- slurpFile "validationsample.csv"
  let isCorrect x = classify trainingSet (_pixels x) == _label x
      numCorrect = V.length $ V.filter isCorrect validationSample
      flt = fromIntegral
      percentCorrect = flt numCorrect / flt (V.length validationSample) * 100.0
  putStrLn $ "Percentage correct: " ++ show percentCorrect

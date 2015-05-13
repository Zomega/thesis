g :: Double
g = 9.8

alpha :: Double
alpha = pi / 8.0

gamma :: Double
gamma = 0.08

rollSpeed :: Double
rollSpeed = 4.0

postImpactRollSpeed :: Double -> Double
postImpactRollSpeed l = let y = 2 * g * x / l
                            x = 1 - ( cos $ alpha - gamma )
		        in sqrt $ (rollSpeed ^ 2) - y

lengthGivenPostImpactRollSpeed :: Double -> Double
lengthGivenPostImpactRollSpeed speed


returnMap :: Double -> Double
returnMap l = lengthGivenPostImpactRollSpeed $ postImpactRollSpeed l

main = putStrLn $ show $ ( returnMap 1.0, returnMap 2.0, returnMap 3.0 )

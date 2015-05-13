import BinSearch

g :: Double
g = 9.8

data RimlessWheel = RimlessWheel {
			gamma :: Double,
			alpha :: Double,
			len :: Double,
			mass :: Double
			}

canRollForward :: RimlessWheel -> Double -> Bool
canRollForward wheel postImpactW = let w0 = sqrt x
                                       x = ( 2 * g / len wheel ) * y
                                       y = 1 - cos ( (gamma wheel) - (alpha wheel) )
				   in postImpactW > w0

smoothDynamics :: RimlessWheel -> Double -> Double
smoothDynamics wheel postImpactW = sqrt ( ( 4 * g / len wheel ) * ( sin (alpha wheel) * sin (gamma wheel) ) + postImpactW * postImpactW )

impactDynamics :: RimlessWheel -> Double -> Double
impactDynamics wheel preImpactW = preImpactW * cos (2 * (alpha wheel))

returnMap :: RimlessWheel -> Double -> Double
returnMap wheel postImpactW = impactDynamics wheel $ smoothDynamics wheel postImpactW

steadyPostImpactSpeed :: RimlessWheel -> Double
steadyPostImpactSpeed wheel = approxFixedPoint (returnMap wheel) 0 100

steadySpeed :: RimlessWheel -> Double
steadySpeed wheel = let z = steadyPostImpactSpeed wheel
			x = 1 - cos ((alpha wheel) - (gamma wheel))
			y = (z ^ 2) - ( 2 * g * x / (len wheel) )
		    in sqrt y

ansC = approxZeroPoint (\l -> 4 - steadySpeed (RimlessWheel 0.08 (pi / 8) l 1.0)) 0 100

data Steepness = S1 | S2 | S3

wheelInPhase :: Steepness -> RimlessWheel
wheelInPhase s = let gamma = case s of
				S1 -> 0.16
				S2 -> 0.02
				S3 -> 0.08
		 in (RimlessWheel gamma (pi / 8) 1.0 1.0)

ramp :: [Steepness]
ramp = [S1, S1, S2, S2, S3, S3, S3]

runStep :: wheel -> Maybe (

partDPostImpactSpeed = steadyPostImpactSpeed (RimlessWheel 0.16 (pi / 8) 1.0 1.0)
main = putStrLn $ show $ steadyPostImpactSpeed (RimlessWheel 0.16 (pi / 8) 1.0 1.0)

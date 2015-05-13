
-- | Solve the continous lyaponov
solveContinous :: Field t => Matrix t -> Matrix t -> Matrix t
solveContinous A Q =
    if not (isHermitian Q)
    then error $ "Attempted to solve a CLE with non-hermitian-Q " ++ show Q
    else if not (isStable A)
         then error $ "Attempted to solve a CLE with non stable-A " ++ show A
         else solveContinous' A Q

-- | Version of solveContinous that does not perform safety prechecks.
-- | It also takes in a factor dt that controls the integration.
solveContinous' :: Field t => Matrix t -> Matrix t -> Float -> Matrix t
solveContinous' A Q dt = expm A
		 

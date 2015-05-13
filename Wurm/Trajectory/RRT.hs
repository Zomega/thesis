import System.Random

-- ||GOAL:
-- || import qualified RapidlyExploringRandomTree as RRT
-- || f = Dynamics {{Function StatePoint ControlInput}}
-- || system = ControlledSystem f
-- ||
-- || random = {{Make a Random instance}}
-- || RRT.build random 10**3 system

-- | Rapidly-Exploring Random Tree Framework

-- Multiple Instances required?
class RRTFramework a where
    sampleState :: Random rand => rand -> ( StatePoint a, rand )
    sampleControl :: Random rand => rand -> StatePoint a -> ( ControlInput a, rand )
    nearestState :: [StatePoint a] -> StatePoint a -> StatePoint a
    approxControlInput :: StatePoint a -> StatePoint a -> ControlInput a
    forwardSimulate :: StatePoint a -> ControlInput a -> StatePoint a

type StatePoint a = (Float, Float, Float)
    
type ControlInput a = Float

type RRT a = Tree (StatePoint a) (ControlInput a)

type Tree a b = [(a, b, a)]

nodes :: Tree a b -> [a]
nodes [] = []
nodes ((x, u, x'):rest) = [x, x'] ++ nodes rest 

empty :: Tree a b
empty = []

addLeaf :: Tree a b -> (a, b, a) -> Tree a b
addLeaf t e = t ++ [e]

-- | Build an RRT without a goal.
build :: RRTFramework a => Random rand => rand -> Int -> RRT a
build _ 0 = empty::RRT a
build rand iters
    = let (x_rand::StatePoint a, rand') = sampleState rand
          x_near = nearestState (nodes tree) x_rand
          u_new = approxControlInput x_near x_rand
          x_new = forwardSimulate x_near u_new
          tree = build rand' $ iters - 1
      in addLeaf tree (x_near, u_new, x_new)
      
-- | TODO: Let us expand the old trees....
-- | Just build rand iters = build' rand iters empty
--build' :: Random -> Int -> RRT a -> RRT a
      
-- | Build an RRT with a goal, but only in the forward direction...

-- | Build an RRT with a goal in both directions at once...

-- | Build an RRT where we forward bias the results buy adding extra nodes for randomly sampled controls.
-- | TODO: Is this better than just warping the voroni sets?

import Data.IORef

data State = State
    { stateCounter :: Int
    , stateComplete :: Bool
    }
    deriving Show
    
data Action
    = Increment Int
    | Decrement Int
    | Toggle
    
reducer :: Action -> State -> State
reducer (Increment x) state = state { stateCounter = stateCounter state + x }
reducer (Decrement x) state = state { stateCounter = stateCounter state - x }
reducer Toggle state = state { stateComplete = not (stateComplete state) }

createStore :: State -> IO (IORef State)
createStore = newIORef

dispatch :: IORef State -> Action -> IO ()
dispatch store action = do
    state <- readIORef store
    let newState = reducer action state 
    writeIORef store newState
    printState store
    
getState :: IORef State -> IO State
getState = readIORef

printState :: IORef State -> IO ()
printState ref = getState ref >>= print

main :: IO ()
main = do
    store <- createStore (State 0 False)
    dispatch store (Increment 23)
    dispatch store (Increment 2)
    dispatch store (Decrement 9)
    dispatch store Toggle
    dispatch store Toggle

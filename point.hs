data Point a = Point
    { x :: a
    , y :: a
    }
    
    
sum_point :: Num a => Point a -> a
sum_point point = x' + y'
    where
        x' = x point
        y' = y point


points :: [Point Int]
points =
    [ Point 1 2
    , Point 1 8
    ]


pointsFloat :: [Point Float]
pointsFloat = 
    [ Point 1 2
    , Point 1 8
    ]


print_point :: String -> String
print_point result =
    "|" ++ result ++ "|"


main :: IO ()
main = do
    mapM_ (putStrLn . print_point . show . sum_point) points
    mapM_ (putStrLn . print_point . show . round . sum_point) pointsFloat


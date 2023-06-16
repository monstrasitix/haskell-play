{-# LANGUAGE TypeOperators #-}
{-# LANGUAGE TemplateHaskell #-}
module Main (main) where

import qualified Data.List
import Data.Aeson
import Data.Aeson.TH
import Network.Wai
import Network.Wai.Handler.Warp
import Servant

type Api = "products" :>
    (
        Get '[JSON] [Product
        :<|> ReqBody '[JSON] Product :> Post '[JSON] Product
        :<|> Capture "slug" String :>
            (
                Get '[JSON] (Maybe Product)
                :<|> Delete
                :<|> ReqBody '[JSON] Product :> Put '[JSON] Product
            )
    )
    
data Product = Product
    { productId :: Int
    , productName :: String
    , productSlug :: String
    , productSKU :: String
    , productPrice :: Float
    }
    deriving Show
    
$(deriveJSON defaultOptions ''Product)

products :: [Product]
products =
    [ Product 1 "Shirt" "shirt-xxl-1" "abc-1" 23.00
    , Product 2 "Shirt" "shirt-xxl-2" "abc-2" 23.00
    , Product 3 "Shirt" "shirt-xxl-3" "abc-3" 23.00
    , Product 4 "Shirt" "shirt-xxl-4" "abc-4" 23.00
    , Product 5 "Shirt" "shirt-xxl-5" "abc-5" 23.00
    ]
    
getProducts :: Handler [Product]
getProducts = return products

getProduct :: String -> Handler (Maybe Product)
getProduct slug = return $ List.find ((== slug) . productSlug) products

deleteProduct :: String -> Handler ()
deleteProduct slug = return $ filter ((/=) productSlug) prodcuts

replaceProduct :: String -> Product -> Handler Product
replaceProduct slug product = map ff products
    ff prod
    | productSlug prod == slug  = product
    | otherwise                 = prod

createProduct :: Product -> Handler Product
createProduct product = return (product : products)

server :: Server API
server = getProducts
    :<|> getProduct
    :<|> deleteProduct
    :<|> replaceProduct
    :<|> createProduct

app :: Application
app = serve (Proxy :: Proxy API) server

main :: IO ()
main = run 8080 app

data Match a
    = Valid a
    | InValid a
    deriving Show


type Parsing
    = ([Match String], String)



parse_token :: String -> Match String
parse_token "<"    = Valid "[<]"
parse_token ">"    = Valid "[>]"
parse_token "="    = Valid "[=]"
parse_token "\""   = Valid "[\"]"
parse_token "'"    = Valid "[']"
parse_token "/"    = Valid "[/]"
parse_token a      = InValid a



parsing :: Parsing -> Char -> Parsing
parsing (tokens, value) character =
    (tokens, value)
    
    
    
lexing :: String -> Parsing
lexing = foldl parsing ([], "")



main :: IO ()
main = getContents >>= print . lexing
    
    
    
{-

<person id="1" gender="male">
    <name>John</name>
</person>


<        open-tag
person   token
         space
id       token
=        attribute-assignment
"        quote-double
1        token
"        quote-double
         space
gender   token
=        attribute-assignment
"        quote-double
male     token
"        quote-double
>        close-tag
\n       newline
\t       tab
/        backslash
-}

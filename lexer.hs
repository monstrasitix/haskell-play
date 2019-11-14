data Match a
    = Valid a
    | InValid a
    deriving Show


type Parsing
    = ([String], String, String)



parse_token :: String -> Match String
parse_token "<"    = Valid "[<]"
parse_token ">"    = Valid "[>]"
parse_token "="    = Valid "[=]"
parse_token "\""   = Valid "[\"]"
parse_token "'"    = Valid "[']"
parse_token " "    = Valid " "
parse_token "\n"   = Valid "\n"
parse_token "\t"   = Valid "[tab]"
parse_token "/"    = Valid "[/]"
parse_token a      = InValid a


parse_value :: String -> String
parse_value "" = ""
parse_value value = "[" ++ value ++ "]"


parsing :: Parsing -> Char -> Parsing
parsing (tokens, acc, value) character =
    case parse_token [character] of
        Valid parse ->
            (tokens ++ [parse_value acc, parse], "",  "")
            
        InValid parse ->
            (tokens, acc ++ parse, parse)
    where
        test = value ++ [character]
    
    
    
lexing :: String -> Parsing
lexing = foldl parsing ([], "", "")


printer :: Parsing -> IO ()
printer (a, _, _)=
    putStrLn $ concat a


main :: IO ()
main = getContents >>= printer . lexing
    
    
    
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


[<][person] [id][=]["][1]["] [gender][=]["][male]["][>]
    [<][name][>][John][<][/][name][>]
[<][/][person][>]
-}

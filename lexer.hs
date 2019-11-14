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
    
    
    
lexing :: String -> Parsing
lexing = foldl parsing ([], "", "")


printer :: Parsing -> IO ()
printer (a, _, _)=
    putStrLn $ concat a


main :: IO ()
main = getContents >>= printer . lexing
    
    
    
{-

<bookstore>
    <book ISBN="10-000000-001">
        <title>The Iliad and The Odyssey</title>
        <price>12.95</price>
        <comments>
            <userComment rating="4"> Best translation I've read. </userComment>
            <userComment rating="2"> I like other versions better. </userComment>
        </comments>
    </book>
    <book ISBN="10-000000-999">
        <title>Anthology of World Literature</title>
        <price>24.95</price>
        <comments>
            <userComment rating="3"> Needs more modern literature. </userComment>
            <userComment rating="4"> Excellent overview of world literature. </userComment>
        </comments>
    </book>
</bookstore>


[<][bookstore][>]
    [<][book] [ISBN][=]["][10-000000-001]["][>]
        [<][title][>][The] [Iliad] [and] [The] [Odyssey][<][/][title][>]
        [<][price][>][12.95][<][/][price][>]
        [<][comments][>]
            [<][userComment] [rating][=]["][4]["][>] [Best] [translation] [I]['][ve] [read.] [<][/][userComment][>]
            [<][userComment] [rating][=]["][2]["][>] [I] [like] [other] [versions] [better.] [<][/][userComment][>]
        [<][/][comments][>]
    [<][/][book][>]
    [<][book] [ISBN][=]["][10-000000-999]["][>]
        [<][title][>][Anthology] [of] [World] [Literature][<][/][title][>]
        [<][price][>][24.95][<][/][price][>]
        [<][comments][>]
            [<][userComment] [rating][=]["][3]["][>] [Needs] [more] [modern] [literature.] [<][/][userComment][>]
            [<][userComment] [rating][=]["][4]["][>] [Excellent] [overview] [of] [world] [literature.] [<][/][userComment][>]
        [<][/][comments][>]
    [<][/][book][>]
[<][/][bookstore][>]


-}

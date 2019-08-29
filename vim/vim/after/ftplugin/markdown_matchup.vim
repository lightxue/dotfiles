" call matchup#util#patch_match_words('startuml', 'enduml')
" echo "call matchup#util#patch_match_words('startuml', 'enduml')"
let b:match_words .= ',^@startuml\>:^@enduml\>'
let b:match_words .= ',^```[a-z]\+\>:^```$'
echo b:match_words

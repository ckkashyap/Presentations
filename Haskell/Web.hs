--{-# OPTIONS_GHC -Wall #-} 
import Control.Monad.State

data Screen = Screen String [HTMLControl] 
     deriving (Show, Eq)

data HTMLText   = HTMLText {htmlTextIdentifier     :: String, htmlTextLabel    :: String} deriving (Show, Eq)
data HTMLRadio  = HTMLRadio {htmlRadioIdentifier   :: String, htmlRadioAction  :: Action} deriving (Show, Eq)
data HTMLButton = HTMLButton {htmlButtonIdentifier :: String, htmlButtonText   :: String, htmlButtonAction :: Action} deriving (Show, Eq)


data HTMLControl = C1 HTMLText | C2 HTMLRadio | C3 HTMLButton
     deriving (Show, Eq)

data Action = 
       None 
     | UpdateText HTMLText String
     | Goto Screen
     | ToggleRadio HTMLRadio
     deriving (Show, Eq)

type HTML = String

screen2HTML :: Screen -> HTML
screen2HTML (Screen identifier' []) = ""
screen2HTML (Screen identifier' cs) = pre ++ body ++ post where
            body = concat $ map control2html cs
            pre = "<html>\n"
            post = "</html>\n"

action2js :: String -> Action -> HTML
action2js _ None = "<!--HELLO-->"
action2js identifier (UpdateText (HTMLText i l) str) = "<script>function function_" ++ identifier ++ "(obj){document.all['div_1'].innerHTML='aaa';alert('"++ (show i) ++ "')}</script>\n"



identifiableDiv :: String -> String -> String
identifiableDiv i str =  "<div id=\"div_" ++ i ++ "\">" ++ str ++ "</div>\n"

generateControlTag :: String -> [(String, String)] -> String
generateControlTag tag kv = "<" ++ tag ++ " " ++ generateControlTag' kv where
                   generateControlTag' [] = "/>"
                   generateControlTag' ((k,v):r)  = " " ++ k ++ "=\"" ++ v ++ "\"" ++ (generateControlTag' r)

control2html :: HTMLControl -> HTML
control2html (C1 (HTMLText i l)) = identifiableDiv i l
control2html (C2 (HTMLRadio i a)) = (identifiableDiv i (generateControlTag "input" [("id", "input_" ++ i), ("type", "radio")])) ++ (action2js i a)
control2html (C3 (HTMLButton i l a)) = (identifiableDiv i (generateControlTag "input" [("id", "button_" ++ i), ("type", "button"), ("value",l), ("onclick", "javascript:function_"++i++"(this);")])) ++ (action2js i a)

data TotalState = TotalState {counter :: Int, workFlow :: [Screen]}
     deriving Show


type MyState = State TotalState Int

incrementCounter :: MyState
incrementCounter = do
                   c@(TotalState a b) <- get
                   put (c{counter = a + 1})
                   return a

newHTMLTextControl :: String -> State TotalState HTMLText
newHTMLTextControl str = do
                   ctr <- incrementCounter
                   return (HTMLText (show ctr) str)

newHTMLRadioControl :: State TotalState HTMLRadio
newHTMLRadioControl  = do
                   ctr <- incrementCounter
                   return (HTMLRadio (show ctr) None)

newHTMLButtonControl :: Action -> String -> State TotalState HTMLButton 
newHTMLButtonControl a str = do
                   ctr <- incrementCounter
                   return (HTMLButton (show ctr) str a)

newScreen :: State TotalState Screen
newScreen = do
          ctr <- incrementCounter
          return (Screen (show ctr) [])

add2screen :: Screen -> HTMLControl -> State TotalState Screen
add2screen (Screen i cs) c = do
           if (elem c cs) then return (Screen i cs)
            else return (Screen i (cs ++ [c]))

add2workflow :: Screen -> MyState
add2workflow s = do
             (TotalState c ss) <- get
             put (TotalState c (s:ss))
             return 0

someFun :: MyState
someFun = do
        t <- newHTMLTextControl "12345"
        t1 <- newHTMLTextControl "Hello World 123"
        b <- newHTMLButtonControl (UpdateText t1 "DINGO") "Click Me"
        s <- newScreen
        s <- add2screen s (C1 t)
        s <- add2screen s (C1 t)
        s <- add2screen s (C1 t1)
        s <- add2screen s (C3 b)
        add2workflow s
        return 0

initialState = TotalState {counter = 0, workFlow = []}

(a, s)    = runState someFun initialState

wf = workFlow s

html = screen2HTML (wf !! 0)


main = do
--     x <- readLn :: IO Int
--     x <- readLn :: IO Int
--     putStrLn (show x)
--     return ()
     writeFile "out.html" html
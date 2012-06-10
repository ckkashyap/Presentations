import Control.Monad.State

data Screen = Screen String [HTMLControl] 
     deriving Show

data HTMLText   = HTMLText {htmlTextIdentifier     :: String, htmlTextLabel    :: String} deriving Show
data HTMLRadio  = HTMLRadio {htmlRadioIdentifier   :: String, htmlRadioAction  :: Action} deriving Show
data HTMLButton = HTMLButton {htmlButtonIdentifier :: String, htmlButtonText   :: String, htmlButtonAction :: Action} deriving Show


data HTMLControl = C1 HTMLText | C2 HTMLRadio | C3 HTMLButton
     deriving Show



data Action = 
       None 
     | UpdateText HTMLText String
     | Goto Screen
     | ToggleRadio HTMLRadio
     deriving Show      

type HTML = String

screen2HTML :: String -> Screen -> HTML
screen2HTML  _ (Screen identifier' []) = ""
screen2HTML identifier (Screen identifier' cs) = pre ++ body ++ post where
            body = concat $ map (control2html identifier) cs
            pre = "<html>\n"
            post = "</html>\n"

action2js :: String -> Action -> HTML
action2js _ None = ""
action2js identifier (UpdateText ht str) = "<script>function f_" ++ identifier ++ "(obj){obj.innerHTML=\"" ++ str ++ "\"}"



identifiableDiv :: String -> String -> String
identifiableDiv i str =  "<div id=\"div_" ++ i ++ "\">" ++ str ++ "</div>\n"

control2html :: String -> HTMLControl -> HTML
control2html identifier (C1 (HTMLText i l)) = identifiableDiv identifier l
control2html identifier (C2 (HTMLRadio i a)) = (identifiableDiv identifier  "<input id=\"input_" ++ identifier ++ "type=\"radio\"/>") ++ (action2js identifier a)
control2html identifier (C3 (HTMLButton i l a)) = identifiableDiv identifier ("<input id=\"button_" ++ identifier ++ "type=\"button\"/>")

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

newHTMLButtonControl :: String -> State TotalState HTMLButton 
newHTMLButtonControl str = do
                   ctr <- incrementCounter
                   return (HTMLButton (show ctr) str None)

newScreen :: State TotalState Screen
newScreen = do
          ctr <- incrementCounter
          return (Screen (show ctr) [])

add2screen :: Screen -> HTMLControl -> State TotalState Screen
add2screen (Screen i cs) c = do
           return (Screen i (cs ++ [c]))
           

someFun :: MyState
someFun = do
        x <- newHTMLTextControl "Hello World"
        x <- newHTMLTextControl "Hello World"
        return 0

initialState = TotalState {counter = 0, workFlow = []}

(a, s)    = runState someFun initialState
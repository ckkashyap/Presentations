# What I am going to cover

* What is functional programming

* Why it matters

* Haskell

# This is not a tutorial on Haskell

* I am merely going to attempt to get you excited about FP in geneal and Haskell in particular!

* Evolution of my position about programming languages
    * BASIC
    * C, x86 ASM, C++
    * Java
    * Smalltalk
    * Perl - got me thinking
    * Monolithic x86 kernel in C -> Minix -> EDSL
    * vim -> emacs
    * 64 bit ISA is very different
    * Perl -> Ruby -> Haskell

# What is Functional Programming?

   * It is a programming paradigm where functions are first class values

   * Functions are data!!!
     * In mathematics, functions essentially map values from a domain to a range!     

   * Functions vs Procedures

    ~~~~ {.haskell}
    f1 :: Int -> Int
    f1 x = x + x

    f2 :: Int -> Int
    f2 x = 2 * x
    ~~~~

    Are f1 and f2 the same function?

# What is Functional Programming (contd)?

   * Return values depend only on the input

   * What about IO?

# Lineages

   * Procedural languages have their roots in Turing Machine (Von Neuman Architecture)

    ~~~~
    Every program could be be expressed in terms of 3 classes of instructions
    1. Instructions that move data - MOV, IN, OUT
    2. Instructions that alter Control Flow - CMP, JMP, JE
    3. Instructions that do arithmatic/logic - ADD, SUB, AND 
    ~~~~   

   * FP on the other hand has its root in lambda calculus

    ~~~~
    <expr>   ::=  <var>
                 | <func> <arg>              # This is an application.
                 | lambda <var> . <expr>     # This is an abstraction. 
    <func>   ::=  <var>
                 | (lambda <var> . <expr>)    
                 | <func> <arg>
    <arg>    ::=  <var>
                 | (lambda <var> . <expr>) 
                 | (<func> <arg>) 
    <var>    ::= a| b| .... | Z
    ~~~~

# Mental model differences

   * In procedural programs one has this notion of a program counter progressing in time

   * In functional programming however, one thinks in terms of expression reduction by substitution
     * Excel without VBA for example

   * What vs How - Function vs Procedure

   * The "What" approach gives more freedom to the compiler

# Why should I learn functional programming?

   * To make the world a happier place

# Seriously - Why?

  * I have a lot of reasons not to!!!
     * I am very comfortable with X which allows me to do everything
   
     * X is industry standard
      
     * X has a lot of support - IDE, debugger etc
  
     * And come on - I have not seen any job posting for Haskell!!!

  * Besides languages dont matter - it's the algorithms that do
      * Well not according to Paul Graham
      * Also not according to Eric Raymond 

            Lisp is worth learning for the profound enlightenment experience you will have when you finally get it; 
            that experience will make you a better programmer for the rest of your days, 
            even if you never actually use Lisp itself a lot.
      * Languages vary in power!!!

# Languages vary in power

   * Beating the averages by Paul Graham
   * High level languages are more powerful than machine language
   * But are all high level languages equal?
     * Remember! COBOL is a high level language
   * Blub paradox!
   * "that if you have a choice of several languages, it is, all other things being equal, a mistake to program in anything but the most powerful one. [3]"

# So which is the most powerful language?

   * Cant answer that without establishing the parameters to measure the power of a language
   * 1990 - Why Functional Programming Matters - John Huges

# Modularity is the key

   * Modular design brings with it great productivity improvements
     * Small modules can be coded correctly, quickly and easily
     * General purpose modules could be reused for subsequent programs
     * Modules could be tested independently
     * Conceptual modularity vs Clerical modularity

# Some literature that talks about the importance of FP

* 1977 - Can Programming Be Liberated from the Von Neumann Style? A Functional Style and Its Algebra of Programs - John Backus, IBM
* 1990 - Why Functional Programming Matters - John Huges
* 2001 - Beating the Averages - Paul Graham, Yahoo! Y Combinator 
* 2011 - http://www.infoq.com/presentations/Thinking-Parallel-Programming (49:36 - 49:50) - Guy Steele
   "If I had known 7 years ago what I know now, I would have started with Haskell"


# So which is the most powerful language?

   * Higher order functions
   * Lazy Evaluation
   * Static typing - (Compile time)
   * Strong typing - (No arbitrary implicit typecasts)

        |         | weak | strong  |
        |---------+------+---------|
        | dynamic | perl | Ruby    |
        | static  | C    | Haskell |
        |---------+------+---------|

# A quick primer on Haskell syntax - functions

   * Function application

    ~~~~{.haskell}
    f :: Int -> Int
    f x = 2 * x
    
    g = f 10 -- => g = 2 * 10 => g = 20
    ~~~~

   * Partial application / closure

    ~~~~{.haskell}
    f :: Int -> Int -> Int
    f x y = x + y
    
    g = f 10 -- => g is a closure with 10 bound to it

    g 20 -- => 30!!!
    ~~~~

# A quick primer on Haskell syntax - data

   * List data type

    ~~~~{.haskell}
    {-
    data keyword is used to introduce new data types
    -}
    
    data Color = Red | Green | Blue
    
    data Person = Person String Int

    data List a = Nil | Cons a (List a)
    ~~~~

# A quick primer on Haskell syntax - data

   * Functions on the List data type

    ~~~~{.haskell}
     
    list2string :: (Show a) => List a -> String
    list2string Nil           = ""
    list2string (Cons n rest) = (show n) ++ " " ++ (list2string rest)

    listLength :: List a -> Int
    listLength Nil         = 0
    listLength (Cons n ns) = 1 + listLength ns 
    ~~~~

# A quick primer on Haskell syntax - data

   * See it in action

    ~~~~{.haskell}

    l1 = Nil
    l2 = Cons 10 l1
    l3 = Cons 20 l2
    l4 = Cons 10 (Cons 20 (Cons 30 Nil))
    
    GHCI (REPL):
    *Main> list2string l1
    ""
    *Main> list2string l2
    "10 "
    *Main> list2string l3
    "20 10 "
    *Main> list2string l4
    "10 20 30 "
    *Main> listLength l1
    0
    *Main> listLength l4
    3
    ~~~~


# What are higher order functions?

   * Functions that take functions as arguments or return functions
   
    ~~~~{.haskell}
    
    sum []	= 0
    sum (x:xs)	= x + sum xs

    prod []	= 1
    prod (x:xs)	= x + prod xs

    sum		= foldr (+) 0
    prod	= foldr (*) 1
    allTrue	= foldr (&&) True
    anyTrue	= foldr (||) False

    ~~~~

# What is lazy evaluation?

   * Evaluate only if and when needed

   * Newton-Raphson Square Roots => a<sub>i+1</sub> = (a<sub>i</sub> + n/a<sub>i</sub>)/2

    ~~~~{.basic}
        X = A0
        Y = A0 + 2. * EPS

    100 IF ABS(X-Y).LE.EPS GOTO 200
        Y = X
        X = (X + N/X) / 2.
        GOTO 100
    200 PRINT X
    ~~~~

# Newton-Raphson Square Roots with Lazy Evaluation

   * We can define a function *next* as follows

    ~~~~{.haskell}
    next n x = (x + n / x) / 2
    ~~~~
            
   * So (*next n*) is the function that maps one approximation to the next

   * Calling this function f, the sequence of approximations would be 

    ~~~~{.haskell}
    [a0, f a0, f (f a0), f (f (f a0)), ...] 
    ~~~~
        
   * We can define a function that computes this sequence

    ~~~~{.haskell}
    repeat f a = a : (repeat f (f a))
    ~~~~




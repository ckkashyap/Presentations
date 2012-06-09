# What I am going to cover

* What is functional programming

* Why it matters

* Haskell

# This is not a tutorial on Haskell

* I am merely going to attempt to get you excited about FP in geneal and Haskell in particular!

# What is Functional Programming?

   * It is a programming paradigm where functions are first class values

   * Functions are data!!!
     * In maths, functions are essentially maps that map values from a domain to a range!     

   * Functions vs Procedures

    ~~~~ {.haskell}
    f1 :: Int -> Int
    f1 x = x + x

    f2 :: Int -> Int
    f2 x = 2 * x
    ~~~~

    Are f1 and f2 the same function?

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


# 


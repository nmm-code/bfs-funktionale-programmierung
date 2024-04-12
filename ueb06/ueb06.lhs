Aufgabe 6
=========

> import Prelude hiding (drop)
> import qualified Prelude

> import Test.HUnit

Wenn der Import von HUnit nicht funktioniert, siehe die Hinweise auf der Moodle-Seite "Verwendete Werkzeuge".


I: Testen mit HUnit
-------------------

1)

a)  Implementiert die in Haskell vordefinierte Funktion "drop :: Int -> [a] -> [a]".

> drop :: Int -> [a] -> [a]
> drop _    []  = []
> drop n (x:xs) | n <= 0  = x:xs
>               | n >  0  = drop (n-1) xs

b)  Mit der Testumgebung HUnit können Tests erstellt werden, um automatisiert
    prüfen zu können, ob sich eine Funktion wie geplant verhält.

    Die folgenden Zeilen definieren eine Liste mit Testfällen, die bei einem
    Aufruf von "runTestsForDrop" ausgeführt werden.
    Ein Testfall besteht dabei jeweils aus einer kurzen Beschreibung sowie zwei
    Ausdrücken, die ausgewertet und miteinander verglichen werden:
     Testbeschreibung  ~:  zu_testender_Ausdruck  ~?=  erwarteter_Ausdruck

    Die Operatoren ~: und ~?= sind in HUnit definiert und dienen der einfacheren
    Erzeugung von Testfällen. Es gibt auch noch weitere Möglichkeiten, schaut
    hierfür bei Interesse in die Dokumentation von HUnit:
     https://wiki.haskell.org/HUnit_1.0_User's_Guide

> runTestsForDrop = runTestTT (test testList)
>   where testList =
>           [
>             "drop mit  0 und leerer Liste"                ~:  drop 0 ""                ~?=  ""
>           , "drop mit  0 und nicht-leerer Liste"          ~:  drop 0 "123"             ~?=  "123"
>           , "drop mit  1 und leerer Liste"                ~:  drop 1 ""                ~?=  ""
>           , "drop mit  1 und nicht-leerer Liste"          ~:  drop 1 "123"             ~?=  "23"
>           , "drop mit  -1 und nicht-leerer Liste"         ~:  drop (-1) "123"          ~?=  "123" 
>           , "drop mit  -1 und leerer Liste"               ~:  drop (-1) ""             ~?=  "" 
>           , "drop mit großen Indizes nicht-leerer Liste"  ~:  drop 10 ""               ~?=  "" 

>           ]
>           where leereIntListe :: [Int]
>                 leereIntListe = []

    Alternativ kann man die Testfälle auch mittels einer Listcomprehension definieren
    und die Ergebnisse mit Aufrufen der in Haskell vordefinierten Funktion vergleichen:

> runTestsForDrop' = runTestTT (test testList)
>   where testList = [ drop n xs  ~?=  Prelude.drop n xs
>                     | n  <- [-1..4]
>                     , xs <- ["", "1", "123"]
>                     ]

    Überlegt euch weitere Testfälle für "drop" und erweitert die Liste unter "runTestsForDrop"
    entsprechend. Achtet dabei auch auf Sonderfälle wie leere Listen, negativen Indizes usw.
    Korrigiert eure Implementierung, falls sich diese nicht immer wie erwartet verhält.

    Implementiert die folgenden Funktionen jeweils einmal mittels Patternmatching (Muster) und einmal
    mittels Verzweigung (if-then-else). Fügt den Funktionsnamen dazu einmal eine 1 und einmal eine 2
    hinzu, z.B. reverse1 und reverse2.
    Die Funktionen dürfen sich dabei nicht gegenseitig aufrufen.

    Schreibt zudem für jede der Funktionen HUnit-Tests.

2)  Implementiert die Funktion "reverse :: [Int] -> [Int]", welche die übergebene Liste in umgekehrter
    Reihenfolge zurückgibt.

    Beispiel:
    reverse [1, 2, 3]  -- Ergebnis: [3, 2, 1]

> reverse1 :: [Int] -> [Int]
> reverse1 [] = []
> reverse1 (x:xs) = reverse1 xs ++ [x]

> reverse2 :: [Int] -> [Int]
> reverse2 xs = if null xs then [] else reverse2 (tail xs) ++ [head xs]

> runTestsForReverse = runTestTT (test testList)
>   where testList =
>           [
>              "reverse mit length = 0"  ~:  reverse1 []  ~?=  [ ]
>             ,"reverse mit length = 1"  ~:  reverse1 [1] ~?=  [1]
>             ,"reverse mit length = 2"  ~:  reverse1 [1,2] ~?=  [2,1]
>             ,"reverse mit length = 10"  ~:  reverse1 [1,2,3,4,5,6,7,8,9,0] ~?=  [0,9,8,7,6,5,4,3,2,1]
>           ]

> runTestsForReverse' = runTestTT (test testList)
>   where testList = [ reverse1 xs    ~?=  reverse2 xs
>                     |  xs <- [[],[1],[1,2],[1,2,3,4,5,6,7,8,9,0]]
>                     ]


3)  Implementiert die Funktion "last :: [Int] -> Int", welche das letzte Element der übergebenen Liste
    zurückgibt. Ihr könnt davon ausgehen, dass die Funktion nicht mit der leeren Liste aufgerufen wird.

    Beispiel:
    last [1, 2, 3]  -- Ergebnis: 3

> last1 :: [Int] -> Int
> last1 [x] = x
> last1 (x:xs) = last1 xs

> last2 :: [Int] -> Int
> last2 xs = if length xs == 1 then head xs else last2 (tail xs)

> runTestsForLast = runTestTT (test testList)
>   where testList = [ last1 xs    ~?=  last xs
>                     |  xs <- [[1],[1,2],[1,2,3,4,5,6,7,8,9,0]]
>                     ]

> runTestsForLast' = runTestTT (test testList)
>   where testList = [ last2 xs    ~?=  last xs
>                     |  xs <- [[1],[1,2],[1,2,3,4,5,6,7,8,9,0]]
>                     ]


4)  Implementiert die Funktion "isPrefix :: [Int] -> [Int] -> Bool", welche zurückgibt, ob die
    übergebene erste Liste ein Präfix der übergebenen zweiten Liste ist, also alle ihre Elemente am Anfang
    der zweiten Liste stehen.

    Beispiele:
    isPrefix [1, 2] [1, 2, 3]  -- Ergebnis: True
    isPrefix [2, 3] [1, 2, 3]  -- Ergebnis: False
    isPrefix [] [1, 2, 3]      -- Ergebnis: True

> isPrefix1 :: [Int] -> [Int] -> Bool
> isPrefix1 [] _ = True
> isPrefix1 _ [] = False
> isPrefix1 (x:xs) (y:ys) = x == y && isPrefix1 xs ys

> isPrefix2 :: [Int] -> [Int] -> Bool
> isPrefix2 xs ys = if null xs then
>                     True 
>                     else if null ys then
>                       False
>                       else 
>                          head xs == head ys && isPrefix2 (tail xs) (tail ys)

> runTestsForIsPrefix = runTestTT (test testList)
>   where testList =
>           [
>              "Leere Liste ist in jede Liste"                 ~:  isPrefix1 [] [1,2,3]          ~?=  True
>              ,"jeder liste ist leer"                         ~:  isPrefix1 [] []               ~?=  True
>              ,"erste liste ist länger als die zweite list"   ~:  isPrefix1 [1,2,3] []          ~?=  False
>              ,"gleich lange"                                 ~:  isPrefix1 [1,2,3] [1,2,3]     ~?=  True
>              ,"eine Zahl ist anders"                         ~:  isPrefix1 [1,2,3] [1,2,4,3]   ~?=  False
>              ,"eine Zahl ist anders und gleich lang"         ~:  isPrefix1 [1,2,3] [1,3,2]     ~?=  False
>              ,"prefix liste kürzer als ganze Liste"          ~:  isPrefix1 [1,2,3] [1,2,3,4,5] ~?=  True
>              ,"zweite liste kleiner als erste liste"         ~:  isPrefix1 [1,2,3] [2,3]       ~?=  False
>          ]


> runTestsForIsPrefix' = runTestTT (test testList)
>   where testList = [ isPrefix1 xs ys  ~?=  isPrefix2 xs ys
>                     |  xs <- [[],[1,2,3]]
>                     ,  ys <- [[],[1,2,3],[1,2,4,3],[1,3,2],[1,2,3,4,5],[2,3]   ]
>                     ]

II. Listcomprehension

1) a) Definiert mit Hilfe einer Listcomprehension eine Funktion
      pairLstGen :: Int -> [(Int,Int)], die eine Liste mit allen Kombinationen
      der Zahlen 1 bis n erzeugt, wobei n als Argument übergeben wird.
      Beispielresultat für n = 5:
        pairLstGen 5 = [(1,1),(1,2),(1,3),(1,4),(1,5),(2,1),(2,2),...,(5,5)]

> pairLstGen :: Int -> [(Int, Int)]
> pairLstGen n = [(x, y) | x <- [1..n], y <- [1..n]]

> runTestsForPairLstGen = runTestTT (test testList)
>   where testList = [
>                     pairLstGen 1  ~?= [(1,1)],
>                     pairLstGen 2  ~?= [(1,1),(1,2),(2,1),(2,2)],
>                     pairLstGen 3  ~?= [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3),(3,1),(3,2),(3,3)]
>                    ]

   b) Erweitert die Listcomprehension nun so, dass nur noch die Zahlenpaare
      generiert werden, bei denen die Summe gerade ist.
      Nennt diese Funktion pairLstGenEven.
      Zur Bestimmung, ob eine Zahl gerade ist, könnt ihr die Funktion even
      verwenden.

> pairLstGenEven :: Int -> [(Int, Int)]
> pairLstGenEven n = [(x, y) | x <- [1..n], y <- [1..n], even (x + y)]

> runTestsForPairLstGenEven = runTestTT (test testList)
>   where testList = [
>                     pairLstGenEven 1  ~?= [(1,1)],
>                     pairLstGenEven 2  ~?= [(1,1),(2,2)],
>                     pairLstGenEven 3  ~?= [(1,1),(1,3),(2,2),(3,1),(3,3)]
>                     ]

   c) In einer Listcomprehension erzeugen Generator-Regeln Werte und
      Wächter bzw. Guards schließen erzeugte Werte aus der Liste aus.
      Wieviele Generator-Regeln und wieviele Wächter bzw. Guards habt
      ihr in 1a und 1b jeweils verwendet?

In 1a 2 Generator Regel , keine Guards
In 1b 2 Generator Regel , eine Guards

2) Schreibt die folgende Funktion zur Verarbeitung von Int-Listen so um,
   dass sie nicht mehr rekursiv, sondern mit einer Listcomprehension arbeitet:

> squareLst    :: [Int] -> [Int]
> squareLst []     = []
> squareLst (x:xs) = x * x : squareLst xs

   Nennt diese Funktion squareLst'.

> squareLst'    :: [Int] -> [Int]
> squareLst' xs = [x * x | x <- xs]

> runTestsForSquareLst = runTestTT (test testList)
>   where testList = [
>                     squareLst' []       ~?= [],
>                     squareLst' [1]      ~?= [1],
>                     squareLst' [1, 2]   ~?= [1, 4],
>                     squareLst' [1..5]   ~?= [1, 4, 9, 16, 25]
>                    ]

3) Schreibt (ähnlich zu Teilaufgabe 1a) eine Funktion tripleLstGen, die mittels 
   Listcomprehension Tripel von Zahlen erzeugt, bei denen allerdings das zweite
   Element nicht kleiner sein darf als das erste Element und das dritte Element
   darf nicht kleiner sein als das zweite Element.
   Verwendet hierfür _keine_ Wächter bzw. Guards.
   Beispielresultat für n = 5:
     tripleLstGen 5 = [(1,1,1),(1,1,2),(1,1,3),(1,1,4),(1,1,5),(1,2,2),...]

> tripleLstGen :: Int -> [(Int, Int, Int)]
> tripleLstGen n = [(x, y, z) | x <- [1..n], y <- [x..n], z <- [y..n]]


> runTestsForTripleLstGen = runTestTT (test testList)
>   where testList = [
>                     tripleLstGen 1  ~?= [(1,1,1)],
>                     tripleLstGen 2  ~?= [(1,1,1),(1,1,2),(1,2,2),(2,2,2)],
>                     tripleLstGen 3  ~?= [(1,1,1),(1,1,2),(1,1,3),(1,2,2),(1,2,3),(1,3,3),(2,2,2),(2,2,3),(2,3,3),(3,3,3)]
>                     ]

4) Mit der Funktionen "words :: String -> [String]" kann eine Zeichenkette in
   eine Liste von Wörtern, die durch Leerzeichen getrennt sind, aufgeteilt
   werden. Die Funktion "unwords :: [String] -> String" erzeugt aus einer
   solchen Liste wieder eine einfache Zeichenkette.
   Beispiel: words "Hallo Welt 123"           = ["Hallo", "Welt", "123"]
             unwords ["Hallo", "Welt", "123"] = "Hallo Welt 123"
   Beide Funktionen sind bereits im Modul Prelude definiert.

   a) Entwickelt eine Funktion "yoda :: String -> String", die eine Zeichenkette
      zunächst in eine Liste von Wörtern aufteilt, diese umsortiert und
      anschließend wieder eine Zeichenkette daraus macht.
      Die Umsortierung soll mit Hilfe der Funktion splitHalf
      erfolgen, wobei hier die beiden Hälften einfach vertauscht werden.
      Eine Listcomprehension muss in dieser Teilaufgabe nicht verwendet werden.

> splitHalf    :: [a] -> ([a], [a])
> splitHalf xs = splitAt (length xs `div` 2) xs

> yoda :: String -> String
> yoda str = unwords (second ++ first)
>   where
>    (first, second) = splitHalf (words str)

> runTestsForYoda = runTestTT (test testList)
>   where testList = [
>                       yoda "du hast noch viel zu lernen"  ~?= "viel zu lernen du hast noch",
>                       yoda "ich werde die Klausur bestehen"  ~?= "die Klausur bestehen ich werde"
>                     ]


   b) Schreibt eine eigene Funktion "myUnwords :: [String] -> String",
      die wie unwords aus einer Liste von Wörtern einen Satz erzeugt.
      Verwendet hierfür eine Listcomprehension und keine Rekursion.

> myUnwords :: [String] -> String
> myUnwords wordsList = drop 1 (concat [" " ++ word  | word <- wordsList])

> runTestsForUnwords = runTestTT (test testList)
>   where testList = [
>                     myUnwords ["Hallo", "Welt", "123"]  ~?= "Hallo Welt 123",
>                     myUnwords []  ~?= "",
>                     myUnwords ["du", "hast", "noch", "viel", "zu", "lernen"]  ~?= "du hast noch viel zu lernen"
>                    ]

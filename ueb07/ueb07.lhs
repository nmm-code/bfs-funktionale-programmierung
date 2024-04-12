Aufgabe 7
=========

> import Prelude hiding (curry, all, any, last, unzip, concatMap)
> import qualified Prelude

> import Data.Char (toLower)

> import Test.HUnit


I. Lambda-Ausdrücke
-------------------

Gegeben sind zwei Listen pairLst und tripleLst mit Zahlentupeln:

> pairLst :: [(Int, Int)]
> pairLst = [(3,1), (74,75), (17,4), (08,15)]

> tripleLst :: [(Int, Int, Int)]
> tripleLst = [(1,2,3), (99,99,0), (79,61,83), (4,8,16)]

und eine Funktion sumLst, die eine Liste von Paaren verarbeitet:

> sumLst    :: [(Int, Int)] -> [Int]
> sumLst xs = map f xs
>             where f (x,y) = x + y

1) a) Die Funktion sumLst ist auf eine der beiden Listen anwendbar,
      welche ist dies und wie sieht das Resultat aus?

> -- es ist auf pairlst anwendbar :: [4,149,21,23]

   b) Wie funktioniert die Funktion sumLst?

> -- es wird über die Liste gemappt und dabei wird eine weitere funktion aufgerufen die jeden Index also tupel miteinander addiert

2) Welchen Typ besitzt die Funktion f, die auf jedes Element der Liste xs
   angewendet wird?

> -- wegen pattern :: where f (x,y) = x + y
> -- f :: (Int, Int) -> Int

3) In welchem Bereich (im Code) ist f sichtbar?
   Kann f beispielsweise in einer komplett anderen Funktion verwendet werden?

> -- f ist eine lokale definition und kann nur im block aufgerufen werden

4) Schreibt die Funktion sumLst so um, dass die Funktion f, die auf jedes
   Listenelement angewendet werden soll, nicht extra mit 'where' definiert werden
   muss, sondern direkt als Lambda-Ausdruck an map übergeben wird.
   (Nennt diese neue Funktion dann z.B. sumLst')

> sumLst'    :: [(Int, Int)] -> [Int]
> sumLst' = map (\ (x, y) -> x + y)       

   Probiert aus, ob die neue Funktion das selbe Ergebnis liefert, wie sumLst.

> runTestsForSumLst = runTestTT (test testList)
>   where testList = [ 
>                      sumLst' pairLst ~?= sumLst pairLst,
>                      sumLst' [(-1,5),(2,4),(7,5)] ~?= sumLst [(-1,5),(2,4),(7,5)]
>                    ]

II. Undendliche Listen
----------------------

1) Schreibt eine Funktion "collatz :: Integer -> [Integer]", welcher die Collatz-Folge ab der
übergebenen Zahl zurückliefert. Die jeweils nächste Zahl der Collatz-Folge ergibt sich bezogen
auf die aktuelle Zahl n aus folgenden Regeln:
 - Wenn n gerade ist, so wird n halbiert und
 - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

Beispielaufruf:
take 10 (collatz 5)  -- Ergebnis: [5, 16, 8, 4, 2, 1, 4, 2, 1, 4]

> collatz :: Integer -> [Integer]
> collatz x | even x    = x : collatz (x `div` 2)
>           | otherwise = x : collatz (x * 3 + 1)

2) Schreibt eine Funktion "collatzEnds :: Integer -> Bool", welche für die übergebene Zahl n überprüft,
ob die Collatz-Folge ab n irgendwo die Zahl 4 enthält, also in der Folge 4, 2, 1, 4, 2, 1, ... mündet.

> collatzEnds :: Integer -> Bool
> collatzEnds x =  4 `elem` collatz x 

3) Schreibt eine Funktion "collatzTest :: Integer -> Bool", welche für die übergeben Zahl n überprüft,
ob collatzEnds für die ersten n positiven Ganzzahlen immer "True" zurückliefert.

Beispielaufruf:
collatzTest 10000  -- Ergenis: True

> collatzTest :: Integer -> Bool
> collatzTest n = all collatzEnds [1..n]

> runTestsForCollatzTest = runTestTT (test testList)
>   where testList = [ 
>                     collatzTest 10000  ~?= True
>                    ]


III. Funktionen höherer Ordnung
-------------------------------

1) Gegeben seien die Funktionen add und add':

> add :: (Int, Int) -> Int
> add (x, y) = x + y

> add' :: Int -> Int -> Int
> add' x y   = x + y

Definiert die funktionsverarbeitende Funktion "curry",
welche aus der Funktion "add" die Funktion "add'" machen kann.
Es muss dann also möglich sein, add' wie folgt zu definieren:

add' :: Int -> Int -> Int
add' = curry add

> curry :: ((a, b) -> c) -> a -> b -> c
> curry f x y = f (x, y)


2) Implementiert eine Funktion "insertOrdered :: (a -> a -> Ordering) -> a -> [a] -> [a]",
   welche die übergebene Ordnungsfunktion nutzt, um das übergebene Element sortiert
   in die übergebene sortierte Liste einzufügen.

   Die Ordnungsfunktion vergleicht die zwei übergebenen Elemente und gibt je nach Ergebnis
   den Wert LT (erstes Element ist kleiner als das zweite), EQ (beide Elemente sind gleich)
   oder GT (erstes Element ist größer als das zweite) zurück.

   Im ghci steht hierfür die Funktion "compare" zur Verfügung, welche zwei miteinander
   vergleichbare Werte (z.B. Int, Char oder String) anhand ihrer natürlichen Ordnung vergleicht.
   Da bei einem Vergleich von Strings anhand ihrer natürlichen Ordnung alle Großbuchstaben
   kleiner als alle Kleinbuchstaben sind, haben wir folgende Funktion zum Vergleich
   zweier Strings ohne Beachtung der Groß- und Kleinschreibung vorgegeben. Zum Testen
   könnt ihr weitere Vergleichsfunktionen definieren (z.B. um zwei Listen bzw. Strings
   anhand ihrer Länge zu vergleichen oder um das Ergebnis von insertOrdered umzudrehen).

> compareIgnoreCase    :: String -> String -> Ordering
> compareIgnoreCase l r = compare (map toLower l) (map toLower r)

   Ihr könnt davon ausgehen, dass die übergebenen Listen genau so
   geordnet sind wie die Ergebnisse der Aufrufe von insertOrdered.
   Denkt bei eurer Implementierung jedoch an Randfälle wie leere Listen.

   Beispielaufrufe:
   insertOrdered compare 5 [1,3,7,9]  -- Ergebnis: [1,3,5,7,9]
   insertOrdered compare 'C' "AB"     -- Ergebnis: "ABC"
   insertOrdered compare 'A' "AB"     -- Ergebnis: "AAB"
   insertOrdered compare "Haus" ["Baum", "Wald"]      -- Ergebnis: ["Baum","Haus","Wald"]
   insertOrdered compare           "etwas" ["Tolles"] -- Ergebnis: ["Tolles","etwas"]
   insertOrdered compareIgnoreCase "etwas" ["Tolles"] -- Ergebnis: ["etwas","Tolles"]

> insertOrdered :: (a -> a -> Ordering) -> a -> [a] -> [a]
> insertOrdered _ x [] = [x]
> insertOrdered cmpF x (y:ys) | cmpF x y == GT  = y : insertOrdered cmpF x ys
>                             | otherwise       = x : y : ys 


> runTestsForInsertOrdered = runTestTT (test testList)
>   where testList = [ 
>                     insertOrdered compare 5 [1,3,7,9]                   ~?= [1,3,5,7,9],
>                     insertOrdered compare 'C' "AB"                      ~?= "ABC",
>                     insertOrdered compare 'A' "AB"                      ~?= "AAB",
>                     insertOrdered compare "Haus" ["Baum", "Wald"]       ~?= ["Baum","Haus","Wald"],                                      
>                     insertOrdered compare "etwas" ["Tolles"]            ~?= ["Tolles","etwas"],                                    
>                     insertOrdered compareIgnoreCase "etwas" ["Tolles"]  ~?= ["etwas","Tolles"]                                     
>                    ]                                                                                               

   Implementiert außerdem eine Funktion "allOrdered :: (a -> a -> Ordering) -> [a] -> Bool",
   welche zurückgibt, ob alle Elemente der übergebenen Liste anhand der übergebenen
   Ordnungsfunktion sortiert sind. Denkt auch hier an mögliche Randfälle.
   Ihr könnt diese Funktion dann zum Testen von insertOrdered nutzen.
   
   Beispielaufrufe:
   allOrdered compare ["Tolles","etwas"]  -- Ergebnis: True
   allOrdered compare ["etwas","Tolles"]  -- Ergebnis: False
   allOrdered compareIgnoreCase ["etwas","Tolles"]  -- Ergebnis: True

> allOrdered :: (a -> a -> Ordering) -> [a] -> Bool
> allOrdered _ [] = True
> allOrdered _ [x] = True
> allOrdered cmpF (x:y:xs) | cmpF x y == GT  = False
>                          | otherwise       = allOrdered cmpF (y : xs)

> runTestsForAllOrdered = runTestTT (test testList)
>   where testList = [ 
>                     allOrdered compare ["Tolles","etwas"]             ~?= True,
>                     allOrdered compare ["etwas","Tolles"]             ~?= False,
>                     allOrdered compareIgnoreCase ["etwas","Tolles"]   ~?= True,    
>                     allOrdered compare [1,3,5,7,9]                    ~?= True,
>                     allOrdered compare "ABC"                          ~?= True,
>                     allOrdered compare "AAB"                          ~?= True,
>                     allOrdered compare ["Baum","Haus","Wald"]         ~?= True
>                    ]  

3) Implementiert die beiden in Haskell vordefinierten Funktionen "all" und "any" ohne Rekursion.
   Probiert ggfs. vorher aus, wie diese sich genau verhalten.
   Verwendet in eurer Implementierung eine Funktionskomposition (.) sowie bei Bedarf weitere
   vordefinierte Funktionen.
   Entwickelt zudem für beide Funktionen eigene Testfälle. Bei Funktionen mit mehreren
   Argumenten bietet es sich wie in der letzten Aufgabe gezeigt an, mit Hilfe einer
   Listcomprehension sämtliche Kombinationen der Testwerte zu erzeugen, indem für jedes
   Argument der Funktionen eine Generatorregel definiert wird.

   a) all :: (a -> Bool) -> [a] -> Bool

      Beispiel:
      all even [2,4,6]  -- Ergebnis: True

> all :: (a -> Bool) -> [a] -> Bool
> all f = and . map f

> runTestsForAll = runTestTT (test testList)
>   where testList = [ 
>                    all even [1..10]        ~?=  Prelude.all even [1..10],
>                    all even [2,4,6,8,10]   ~?=  Prelude.all even [2,4,6,8,10],
>                    all even [1,3,5]   ~?=  Prelude.all even [1,3,5],
>                    all even []        ~?=  Prelude.all even []
>                    ]

   b) any :: (a -> Bool) -> [a] -> Bool

      Beispiel:
      any even [1,3,5]  -- Ergebnis: False

> any :: (a -> Bool) -> [a] -> Bool
> any f = or . map f

> runTestsForAny = runTestTT (test testList)
>   where testList = [ 
>                    any even [1..10]        ~?=  Prelude.any even [1..10],
>                    any even [2,4,6,8,10]   ~?=  Prelude.any even [2,4,6,8,10],
>                    any even [1,3,5]   ~?=  Prelude.any even [1,3,5],
>                    any even []        ~?=  Prelude.any even []
>                    ]

4) Die rekursive Funktion "and" bestimmt zu einer Liste mit boolschen Werten, ob diese alle wahr sind:

and        :: [Bool] -> Bool
and []     =  True
and (x:xs) =  x && and xs

Beispiel:
and [True,True,False]  -- Ergebnis: False

   Definiert diese Funktion punktfrei und mit Hilfe der Funktion "foldr", ohne einen direkten
   rekursiven Aufruf zu verwenden. Hängt dem Funktionsnamen ein "F" an, um Namenskonflikte zu vermeiden.

> andF :: [Bool] -> Bool
> andF = foldr (&&) True

5) Implementiert die Funktionen "map" und "filter" mit foldr.
   Hängt den beiden Funktionsnamen ein "F" an, um Namenskonflikte zu vermeiden.

   a) mapF :: (a -> b) -> [a] -> [b]

> mapF :: (a -> b) -> [a] -> [b]
> mapF f = foldr ((:) . f) []

   b) filterF :: (a -> Bool) -> [a] -> [a]

> filterF :: (a -> Bool) -> [a] -> [a]
> filterF f = foldr (\ x acc -> if f x then x : acc else acc) []

Hinweis: Inhalte der Teile 6) bis 9) werden in der Vorlesung am 2.1. behandelt.

6) Implementiert die in Haskell vordefinierte Funktion "last :: [a] -> a"
   mit foldl oder foldr und schreibt Tests hierfür.

> last :: [a] -> a
> last xs = foldl (\acc x -> x) (head xs) xs 

> runTestsForLast = runTestTT (test testList)
>   where testList = [ last xs    ~?=  Prelude.last xs
>                     |  xs <- [[1,2],[1,2,5],[5,3,2],[1,2,3,4]]
>                    ]                  

7) Implementiert die in Haskell vordefinierte Funktion "unzip :: [(a, b)] -> ([a], [b])"
   mit foldl oder foldr und schreibt Tests hierfür.

> unzip :: [(a, b)] -> ([a], [b])
> unzip = foldl (\acc x -> (fst acc ++ [fst x],snd acc ++ [snd x]) ) ([],[]) 

> runTestsForUnzip = runTestTT (test testList)
>   where testList = [ unzip xs    ~?=  Prelude.unzip xs
>                     |  xs <- [[],[(1,2)],[(1,2),(3,4),(5,6),(7,8),(9,10),(11,12)]]
>                    ]

8) Manchmal kommt es vor, dass man mit einem map-Aufruf die Elemente einer Liste
   verarbeiten will, aber dabei jeweils wieder Listen erzeugt werden
   (map f mit f :: a -> [a]), welche dann mit "concat" zu einer Liste zusammengefügt
   werden sollen. Damit diese Liste nun nicht zweimal durchlaufen wird, gibt
   es eine eigene Funktion "concatMap", die effizienter ist als "(concat . map f) xs".

   Implementiert die Funktion "concatMap :: (a -> [b]) -> [a] -> [b]" mit foldl
   oder foldr und mit einer Funktionskomposition. Überlegt euch dazu, welche
   fold-Funktion besser geeignet ist, und definiert auch für concatMap geeignete
   Testfälle.
   Hinweis: Eine Funktion mit dem Typ "a -> [a]" ist beispielsweise "replicate 3".

> concatMap :: (a -> [b]) -> [a] -> [b]
> concatMap f = foldr ((++) . f) []

> runTestsForConcatMap = runTestTT (test testList)
>   where testList = [ concatMap (replicate 3) xs ~?= Prelude.concatMap (replicate 3) xs
>                     | xs <- [ [],[ 1, 2 ],[ 1..12 ] ]
>                    ] 

9) Entwickelt mit foldl oder foldr und mit einer Funktionskomposition eine Funktion
   "dec2int :: [Int] -> Int", die aus einer Liste von Ziffern eine Dezimalzahl macht.
   Ihr könnt davon ausgehen, dass die Funktion nur mit Listen aufgerufen wird, deren
   Elemente zwischen 0 und 9 liegen.

   Beispiel:
   dec2int [2,3,4,5]  -- Ergebnis: 2345
   
   Definiert auch für dec2int geeignete Testfälle.

> dec2int :: [Int] -> Int
> dec2int = foldl ((+) . (*10)) 0

> runTestsForDec2int = runTestTT (test testList)
>  where testList = [ 
>                    dec2int []           ~?= 0,
>                    dec2int [1,0]        ~?= 10,
>                    dec2int [0,1,0]      ~?= 10,
>                    dec2int [2,4,6,8]    ~?= 2468,
>                    dec2int [2,3,4,5]    ~?= 2345,
>                    dec2int [2,0,4,8]    ~?= 2048
>                    ]
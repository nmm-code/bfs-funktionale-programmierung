Aufgabe 5
=========

> import Prelude hiding (sum, and, take, concat, elem, lookup, (!!))

1) Die Definition der Funktion sum, welche die Summe aller Listenelemente bestimmt,
   kann wie folgt definiert werden:

> sum        :: Num a => [a] -> a
> sum []     = 0
> sum (x:xs) = x + (sum xs)

   Über Äquivalenzumformungen lässt sich zeigen, dass "sum [1,2,3] = 6" gilt:

       sum [1,2,3]
   <=> sum (1:2:3:[])       Liste nur anders aufgeschrieben
   <=> 1 + sum (2:3:[])     Definition von 'sum' angewendet
   <=> 1 + 2 + sum (3:[])   Definition von 'sum' angewendet
   <=> 3 + sum (3:[])       Definition vom ersten '+' angewendet
   <=> 3 + 3 + sum []       Definition von 'sum' angewendet
   <=> 6 + sum []           Definition vom ersten '+' angewendet
   <=> 6 + 0                Definition von 'sum' angewendet
   <=> 6                    Definition von '+' angewendet

   q.e.d.

   a) Zeigt nun mithilfe von Äquivalenzumformungen, dass "sum [x] = x" (für
      alle Zahlen x) gilt. Dokumentiert dabei jeweils wie im Beispiel gezeigt,
      welche Umformungen ihr vorgenommen habt.

       sum [x]    
   <=> sum (x:[])          Liste nur anders aufgeschrieben
   <=> x + sum []          Definition von 'sum' angewendet
   <=> x + 0               Definition von 'sum' angewendet
   <=> x                   Definition von '+' angewendet

   q.e.d

   b) Entwickelt analog zu sum eine rekursive Funktion "and :: [Bool] -> Bool",
      die eine logische Und-Verknüfpung aller Werte einer Liste durchführt.
      Für leere Listen soll die Funktion true zurück geben.
      Beispiele:
        and [True, False, True]  =  False
        and [True, True]         =  True

> and :: [Bool] -> Bool
> and [] = True
> and (x:xs) = x && and xs

   c) Wie oft wird die Funktion aufgerufen, wenn "and [True, True]" ausgewertet
      werden soll?


   => and [True,True] 
   = 1
   => and [True]      -- > and (x:xs) = x && and xs
   = 2
   => and []          -- > and (x:xs) = x && and xs
   = 3
   => True

   d) Beweist mit Hilfe von Äquivalenzumformungen, dass
      "and [True, True, False] = False" gilt. Dokumentiert dabei wieder die
      einzelnen Umformungen.

   and [True, True, False]
   <=> and (True:True:False:[])                 Liste nur anders aufgeschrieben
   <=> True && and (True:False:[])              Definition von 'and' angewendet
   <=> True && (True && and (False:[]))         Definition von 'and' angewendet
   <=> True && (True && (False && and []))      Definition von 'and' angewendet
   <=> True && (True && (False && True))        Erste Klammer zusammengefasst
   <=> True && (False && False)                 Zweite Klammer zusammengefasst
   <=> True && False                            Als einen Ausdruck zusammengefasst
   <=> False                                 

2) Zur Erstellung rekursiver Funktionen kann eine Unterteilung nach
   folgendem Rezept genutzt werden, das hier exemplarisch anhand der Funktion
   "take" gezeigt wird:

(1) Definition des Typs

> take :: Int -> [a] -> [a]

(2) Aufzählen der Fallunterscheidungen

  take n []     | n <  0 =
                | n == 0 =
                | n >  0 =
  take n (x:xs) | n <  0 =
                | n == 0 =
                | n >  0 =

(3) Definition der einfachen Fälle

  take n []     | n <  0 = []
                | n == 0 = []
                | n >  0 = []
  take n (x:xs) | n <  0 = []
                | n == 0 = []
                | n >  0 =

(4) Definition der rekursiven Fälle

  take n []     | n <  0 = []
                | n == 0 = []
                | n >  0 = []
  take n (x:xs) | n <  0 = []
                | n == 0 = []
                | n >  0 = x : take (n-1) xs

(5) Zusammenfassen und verallgemeinern

> take _ []     = []
> take n (x:xs) | n > 0     = x : take (n-1) xs
>               | otherwise = []


Definiert nun die folgenden Funktionen nach dem gezeigten Rezept rekursiv,
wobei die einzelnen Schritte alle anzugeben sind (Schritte 2-4 als Kommentar,
da diese ja noch nicht vollständig sind, und Schritt 5 als Codeabschnitt).
Die Funktionen sollen sich genauso verhalten wie die aus der Prelude.
Probiert ggf. mit diesen ein wenig herum, um zu sehen wie sie sich in
Sonderfällen (wie etwa der leeren Liste oder bei negativen Indizes) verhalten.


a) concat :: [[a]] -> [a]

(1) Definition des Typs

> concat :: [[a]] -> [a]

(2) Aufzählen der Fallunterscheidungen

   concat [] =

   concat (xs:xss) =

(3) Definition der einfachen Fälle

   concat []  = []

(4) Definition der rekursiven Fälle

   concat (xs:xss) = xs ++ concat xss

(5) Zusammenfassen und verallgemeinern

> concat [] = []           
> concat (xs:xss) = xs ++ concat xss  





b) elem :: Eq a => a -> [a] -> Bool

(1) Definition des Typs

> elem :: Eq a => a -> [a] -> Bool

(2) Aufzählen der Fallunterscheidungen

   elem _ []     = 
   elem x (y:ys) =

(3) Definition der einfachen Fälle

   elem _ []     = False
   
(4) Definition der rekursiven Fälle

   elem x (y:ys) =  x == y || elem x ys

(5) Zusammenfassen und verallgemeinern

> elem _ []     = False 
> elem x (y:ys) = (x == y) || elem x ys  







c) (!!) :: [a] -> Int -> a

(1) Definition des Typs

> (!!) :: [a] -> Int -> a

(2) Aufzählen der Fallunterscheidungen

   (!!) [] _   = 

   (!!) (x:xs) i  | i <  0 =
                  | i == 0 = 
                  | i >  0 = 

(3) Definition der einfachen Fälle

   (!!) [] _   = error

   (!!) (x:xs) i  | i <  0 = error
                  | i == 0 = x
                  | i >  0 = 

(4) Definition der rekursiven Fälle´

   (!!) [] _   = error

   (!!) (x:xs) i  | i <  0 = error
                  | i == 0 = x
                  | i >  0 = (!!) xs (i-1)

(5) Zusammenfassen und verallgemeinern


> (!!) (x:xs) i  | i == 0 = x
>                | i >  0 = (!!) xs (i-1)





3) Die folgende Funktion "reduce" reduziert eine natürliche Zahl n nach den
   Regeln:
     - Wenn n gerade ist, so wird n halbiert und
     - wenn n ungerade ist, so wird n verdreifacht und um 1 erhöht.

> reduce :: Integer -> Integer
> reduce n | even n    = n `div` 2
>          | otherwise = n * 3 + 1

   Wendet man nun die Funktion wiederholt auf ihr Resultat an, erhält man bei
   einem Startwert von beispielsweise 5 die Folge:
     5, 16, 8, 4, 2, 1, 4, 2, 1, 4, 2, 1, ...

   Definiert nun eine rekursive Funktion "collatz :: Integer -> Integer", die
   zählt wieviele Schritte benötigt werden, um eine Zahl n mit der gegebenen
   Funktion "reduce" zum ersten Mal auf 1 zu reduzieren.
   Beispiele:
     collatz  5  =  5
     collatz 16  =  4
     collatz  8  =  3
     collatz  4  =  2

> collatz :: Integer -> Integer
> collatz n 
>     | n == 1  = 0
>     | otherwise = 1 + (collatz (reduce n))

4) Erstellt eine Funktion "isPrime :: Int -> Bool", die testet, ob eine gegebene
   Ganzzahl eine Primzahl ist, also ohne Rest nur durch 1 und sich selbst teilbar ist.
   Dazu wird versucht, die Zahl durch jede kleinere Zahl zu teilen, die größer als 1
   ist. Wenn der Rest der ganzzahligen Division 0 ist, dann handelt es sich nicht
   um eine Primzahl. Wenn kein echter Teiler gefunden wurde, dann ist die Zahl eine
   Primzahl.

   Ihr könnt davon ausgehen, dass die Funktion nur mit Zahlen größer 1 aufgerufen wird.

Beispielaufrufe:
isPrime 2  -- Ergebnis: True
isPrime 3  -- Ergebnis: True
isPrime 4  -- Ergebnis: False

Zur Bestimmung des Rests einer ganzzahligen Division kann die Funktion "mod :: Int -> Int -> Int"
genutzt werden.

Beispiele:
3 `mod` 2  -- Ergebnis: 1
4 `mod` 2  -- Ergebnis: 0


> isPrime :: Int -> Bool
> isPrime n = isPrimeDivisor 2
>  where
>     isPrimeDivisor divisor
>       | divisor * divisor > n   = True  
>       | n `mod` divisor == 0    = False 
>       | otherwise               = isPrimeDivisor (divisor + 1) 


5) Implementiert die Funktion "lookup :: Eq a => a -> [(a, b)] -> Maybe b", welche zu einem gegebenen
   Schlüssel in einer Liste von Schlüssel-Wert-Paaren den passenden Wert sucht und diesen zurückgibt.
   Der Rückgabewert ist vom Typ "Maybe a", wodurch bei einem nicht vorhandenen Schlüssel der Wert
   "Nothing" zurückgegeben werden kann. Wenn ein Schlüssel mehrmals in der Liste enthalten ist, wird
   der Wert des ersten Vorkommens zurückgegeben.

Beispiele:
lookup 2 [(1,"hallo"),(2,"welt"),(4,"abc")]  -- Ergebnis: Just "welt"
lookup 3 [(1,"hallo"),(2,"welt"),(4,"abc")]  -- Ergebnis: Nothing

Die lookup-Funktion ist in Haskell vordefiniert. Ihr könnt sie ausprobieren, wenn im ghci nicht
gerade diese Datei geladen ist.

> lookup :: Eq a => a -> [(a, b)] -> Maybe b
> lookup _ [] = Nothing
> lookup key ((k, value):xs)
>   | key == k  = Just value
>   | otherwise = lookup key xs

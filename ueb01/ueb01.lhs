> import Prelude hiding (splitAt, (||)) -- verhindert den import von || operator

Aufgabe 1
=========

Thema: Ausdrücke, Typen, Muster

Ein paar Literate-Haskell-Beispiele:
------------------------------------

> one :: Int
> one = 1

> two :: Int
> two = 2

> t1 :: (Int, Int)
> t1 = (one, two)


verdoppelt eine ganze Zahl:

> double :: Int -> Int
> double x = x * 2


prüft, ob ein Zeichen eine Ziffer ist:

> isDigit :: Char -> Bool
> isDigit x = '0' <= x && x <= '9'


prüft, ob eine Zahl eine gerade Zahl ist:

> even' :: Int -> Bool
> even' x = x `mod` 2 == 0


Achtet darauf, dass die Klammer ">" immer ganz am Anfang einer Zeile stehen muss
und Code-Zeilen immer durch mindestens eine Leerzeile von Kommentarzeilen getrennt
sein müssen.


Aufgabenstellung
----------------

In dieser ersten Aufgabe wollen wir uns mit einfachen Ausdrücken und deren Typen
beschäftigen.
Hierfür sind ein paar Werte vorgegeben, für die ihr die Typen bestimmen sollt.


I. Einfache Ausdrücke

Überlegt euch für die folgenden 15 Ausdrücke, welchen Typ sie jeweils besitzen.

Tipp: Zwei der Ausdrücke sind ungültig.
Welche sind das und wieso sind sie ungültig?

Beispiel:

   -  '7' :: Char

Aufgaben:

   1. True                       :: Bool
   2. (False, True)              :: (Bool, Bool)
   3. [False, True]              :: [Bool]
   4. "True"                     :: [Char]
   5. ['4', '2']                 :: [Char]
   6. ["4", "2"]                 :: [[Char]]
   7. ([True], "True")           :: ([Bool], [Char])
   8. [("a", 'b'), ("A", 'B')]   :: [([Char], Char)]
   9. [1, 2, 3]                  :: [Int]
  10. ['O', '0', 0]              :: ??? -- ungültig durch mehrere Datentypen in ein Array 
  11. [[], ['0'], ['1', '2']]    :: [[Char]]
  12. ["foo", ['b', 'a', 'r']]   :: [[Char]]
  13. ("head", head)             :: ([Char], [a] -> a)
  14. [head, length]             :: [[a] -> a]
  15. blub                       :: ??? -- ungültig, denn keine Funktion oder Variable

Kontrolliert anschließend eure Ergebnisse mit dem ghci.
Dies ist mit dem Befehl :type (oder :t) möglich.


II. Funktionen

Analog zur vorherigen Aufgabe sind nun die Typen einiger Funktionen zu bestimmen.

Beispiel:

    head :: [a] -> a
    head (x:xs) = x

Durch Eingabe eines "let"-Ausdrucks lassen sich Funktionen auch direkt im ghci definieren:

let head (x:xs) = x

Funktionsdefinitionen:

1. copyMe         :: [a] -> [a]
   copyMe xs       = xs ++ xs -- ++ -> zwei Listen hintereinander hängen

2. boxIt          :: (a, b) -> ([a], [b])
   boxIt (x, y)    = ([x], [y])

3. pair           :: a -> b -> (a, b)
   pair x y        = (x, y)

4. toList         :: (a, a) -> [a]
   toList (x, y)   = [x, y]

5. blp            :: Bool -> [Bool]
   blp x           = toList (pair x True)

6. apply          :: (a -> b) -> a -> b
   apply f x       = f x

7. plus1          :: Int -> Int
   plus1 n         = 1 + n


III. Syntaxfehler

Der folgende Ausschnitt enthält drei syntaktische Fehler.
Findet heraus, welche dies sind, und behebt sie.

N = a 'div' length xs
    where
      a = 10
      xs = [1..5]

-- verbesserung

n = a `div` length xs   -- variablen müssen klein geschrieben werden 
   where                -- div muss mit ` geschrieben werden
      a = 10            -- einrückung muss gleich sein
      xs = [1..5] 



IV. Verzweigungen und Muster

1) a) Disjunktion:
      Schreibt (analog zur Funktion (&&) aus der Vorlesung) mindestens 2
      Definitionen der Funktion für die Disjunktion:
      "(||) :: Bool -> Bool -> Bool"
      Nutzt hierfür bei einer Definition eine Verzweigung
      (if ... then ... else ...) und bei mindestens einer weiteren den
      Mustervergleich (Pattern matching).

      Da die Funktion (||) bereits im Prelude-Modul definiert ist, solltet ihr
      diese nicht mit importieren. Fügt hierzu einfach den Funktionsnamen oben
      beim Import von Prelude im "hiding"-Bereich mit an:

      > import Prelude hiding (splitAt, (||))

> (||) :: Bool -> Bool -> Bool
> (||) x y = if x then True else y
 
> (|||) :: Bool -> Bool -> Bool
> (|||) True _ = True 
> (|||) _ True = True
> (|||) _ _ = False

      Um keinen Namenskonflikt zu bekommen, wenn ihr die Funktion selbst
      mehrmals definieren wollt, könnt ihr die Funktionen einfach (||), (|||),
      usw. nennen.



   b) Definiert (ebenfalls mit Hilfe eines Mustervergleichs) eine Funktion
      "lst3", die nur 3-elementige Listen (mit beliebigem Elementtyp)
      verarbeiten kann und diese in ein Tupel mit den gleichen Elementen
      konvertiert.
      Beispiele:
        lst3 [1,2,3]   ergibt   (1,2,3)
        lst3 "abc"   ergibt   ('a','b','c')

      Überlegt euch hierfür zunächst den Typ dieser Funktion.

      Für Listen mit mehr oder weniger als drei Elementen muss die Funktion
      nicht definiert sein, sie ist also partiell.

> lst3 :: [a] -> (a, a, a)
> lst3 [x, y, z] = (x, y, z)


   c) Schreibt eine Funktion "sndLst :: [a] -> a", die mit Hilfe eines
      Mustervergleichs (analog zur Funktion "snd") das zweite Element einer
      beliebig langen Liste ausgibt.
      Beispiel:
        sndLst [1,2,3,4]   ergibt   2

      Für Listen mit weniger als zwei Elementen muss die Funktion nicht
      definiert sein.

> sndLst :: [a] -> a
> sndLst (_:x:_) = x

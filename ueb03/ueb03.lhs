Aufgabe 3
=========

Thema: Polymorphie und Typklassen

> import Data.Char (toLower)
> import Data.List (sort)

I.

Guckt euch die Haskell-Typhierarchie unter [1] an.
In welchen Fällen sollte man Typen (z.B. Int oder Char) nutzen und wo sollte man
lieber auf Typklassen (Eq, Ord etc.) zurückgreifen?

[1]: https://www.haskell.org/onlinereport/haskell2010/haskellch6.html#x13-1270006.3


II.

Gegeben sind die vier folgenden Funktionsdefinitionen (inkl. Typsignatur):

fstElems :: [Char] -> (Char, Char)
fstElems l = (head l, head (tail l))

monotonic :: Int -> Int -> Int -> Bool
monotonic x y z = (x <= y) && (y <= z)

unique :: Double -> Double -> Double -> Bool
unique x y z = (x /= y) && (y /= z) && (z /= x)

add3 :: Int -> Int -> Int -> Int
add3 x y z = x + y + z

1) a) Was macht die Funktion "fstElems"?
     
      -- gibt die ersten zwei Elmente aus

   b) Wie müsste der Typ definiert werden, damit sie dies nicht mehr ausschließlich
      für Listen mit Elementen vom Typ Char, sondern mit beliebigen Listen (also z.B.
      auch Listen mit Elementen vom Typ Int) berechnen kann?
      Probiert eure Lösung auch aus. Entfernt hierzu z.B. einfach oben die '> '
      vor der Definition und definiert die Funktion hier neu.

> fstElems :: [a] -> (a, a)
> fstElems l = (head l, head (tail l))   


2) Wie muss der Typ der Funktion "monotonic" aussehen, damit sie nicht nur mit Int,
   sondern mit allen Typen funktioniert, auf denen eine Ordnung definiert ist?
   Probiert eure Lösung mit Kommazahlen und mit Zeichen aus (auf beiden Typen
   ist eine Ordnung definiert.

> monotonic :: Ord a => a -> a -> a -> Bool
> monotonic x y z = (x <= y) && (y <= z)

3) Wie muss der Typ der Funktion "unique" aussehen, damit sie nicht nur mit
   Double, sondern mit allen Typen funktioniert, auf denen ein Vergleich möglich ist?

> unique :: Eq a => a -> a -> a -> Bool
> unique x y z = (x /= y) && (y /= z) && (z /= x)

4) Definiert den Typ der Funktion add3 so, dass sie alle Werte addieren kann, für
   welche die "+"-Funktion definiert ist. Testet die Funktion auch mit Gleitkommazahlen.

> add3 :: Num a => a -> a -> a -> a
> add3 x y z = x + y + z

III.

Analog zur ersten Aufgabe sind nun die Typen einiger Ausdrücke und Funktionen
zu bestimmen.

1.

[(+), (-), (*)] :: [Num -> Num]


2.

[(+), (-), (*), mod] :: [Integer -> Integer]


3.

present :: Show a => a -> a -> String

> present x y = show x ++ ", " ++ show y


4.

showAdd :: Num a => a -> a -> [Char]

> showAdd x y = [x, y] ++ [x + y]


IV.

Mit Hilfe der Funktion "sort :: Ord a => [a] -> [a]" (definiert in Data.List, s.o.) können Listen
von Elementen sortiert werden, deren Typ eine Ordnung aufweist.
Strings werden standardmäßig anhand der enthaltenen Zeichen sortiert, wobei Großbuchstaben vor
Kleinbuchstaben kommen:
sort ["essen", "schlafen", "Haus"]  ergibt  ["Haus","essen","schlafen"]

Um eine Sortierung unabhängig von Groß-/Kleinschreibung zu erreichen, kann ein eigener Datentyp
MyString und eine Hilfsfunktion toLowerString definiert werden (Die Funktion map kommt erst später
in der Vorlesung dran):

> data MyString = Str String
>   deriving Show

> toLowerString :: String -> String
> toLowerString s = map toLower s

Beispiel:
toLowerString "Haus"  ergibt  "haus"

Implementiert Instanzen der Typklassen Eq und Ord für MyString, sodass sort wie folgt funktioniert: 

sort [Str "essen", Str "schlafen", Str "Haus"]  ergibt  [Str "essen",Str "Haus",Str "schlafen"]


> instance Eq MyString where
>     (Str s1) == (Str s2) = toLowerString s1 == toLowerString s2

> instance Ord MyString where
>     compare (Str s1) (Str s2) = compare (toLowerString s1) (toLowerString s2)

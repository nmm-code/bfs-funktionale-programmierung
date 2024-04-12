Aufgabe 4
=========

I. Anonyme Funktionen

1. Die folgende Funktion multipliziert ihre drei Argumente miteinander:

> mult :: Int -> Int -> Int -> Int
> mult x y z = x * y * z

   Definiert `mult` pointfree mit Hilfe einer oder mehrerer anonyme Funktionen (Lambda-Ausdrücke).
   Es gibt verschiedene Möglichkeiten, dies zu tun, gebt mindestens 3 Varianten an.

> mult1 :: Int -> Int -> Int -> Int
> mult1 = \x y z -> x * y * z

> mult2 :: Int -> Int -> Int -> Int
> mult2 = \x -> \y z -> x * y * z

> mult3 :: Int -> Int -> Int -> Int
> mult3 = \x -> \y -> \z -> x * y * z

2. Definiert eine Funktion "at3 :: [a] -> a" pointfree als Lambda-Ausdruck, der immer das Element am Index 3 einer Liste zurückgibt.
   Der Fall, dass die Liste nicht lang genug ist, braucht nicht extra behandelt werden.

> at3 :: [a] -> a
> at3 = \xs -> head (drop 2 xs)  

II. Case-Ausdrücke

Implementiert folgende Funktionen sowohl mittels Pattern Matching als auch mittels Case-Ausdrücken.
Nennt die Variante mit Pattern Matching zum Beispiel "...1" und die mit Case-Ausdruck "...2".

1. "fromMaybe :: a -> Maybe a -> a", liefert im Fall von "Nothing" den übergebenen Wert und 
   im Fall von "Just" den darin enthaltenen Wert.

> fromMaybe1 :: a -> Maybe a -> a
> fromMaybe1 x (Nothing) = x
> fromMaybe1 x (Just y) = y


> fromMaybe2 :: a -> Maybe a -> a
> fromMaybe2 defaultValue maybeValue =
>   case maybeValue of
>     Nothing -> defaultValue
>     Just x  -> x


2. "maybeToList :: Maybe a -> [a]", liefert eine leere Liste bei Nothing oder eine Liste mit dem Element aus Just.

> maybeToList1 :: Maybe a -> [a]
> maybeToList1 (Nothing) = []
> maybeToList1 (Just a) = [a]

> maybeToList2 :: Maybe a -> [a]
> maybeToList2 maybeValue = 
>   case maybeValue of
>     Nothing -> []
>     Just a  -> [a]


3. "safeHead :: [a] -> Maybe a", arbeitet wie "head", liefert aber bei einer leeren Liste "Nothing" zurück.

> safeHead1 :: [a] -> Maybe a
> safeHead1 (x:_) = Just x
> safeHead1 [] = Nothing

> safeHead2 :: [a] -> Maybe a
> safeHead2 value = 
>   case value of
>     [] -> Nothing
>     (a:_) -> Just a


4. "either :: (a -> c) -> (b -> c) -> Either a b -> c", verarbeitet einen "Either"-Wert.
   Handelt es sich um einen "Left"-Wert, wird die erste Funktion angewendet, bei einem "Right"-Wert die zweite.

Beispiele:
"either1 signum abs (Left (-42))"  ergibt  "-1"
"either1 signum abs (Right (-42))"  ergibt  "42"

> either1 :: (a -> c) -> (b -> c) -> Either a b -> c
> either1 a b (Left c) = a c
> either1 a b (Right c) = b c

> either2 :: (a -> c) -> (b -> c) -> Either a b -> c
> either2 a b value = 
>   case value of
>     Left c -> a c
>     Right c -> b c

III. Partielle Funktionsapplikation

Implementiert folgende Funktionen ohne Angabe eines expliziten Parameters, also pointfree.
Eine Verwendung von anonymen Funktionen ist hierbei nicht notwendig und auch nicht erlaubt.

1. "inc :: Int -> Int", erhöht eine Zahl um eins.

> inc :: Int -> Int
> inc = (+1)

2. "half :: Int -> Int", halbiert eine Zahl.

> half :: Int -> Int
> half = (`div` 2);

3. "prefix :: String -> String", liefert die ersten 5 Zeichen des übergebenen Strings.

> prefix :: String -> String
> prefix = take 5

4. "fromMaybeInt :: Maybe Int -> Int", liefert den enthaltenen Int Wert oder bei Nothing einen beliebigen Standardwert.

> fromMaybeInt :: Maybe Int -> Int
> fromMaybeInt = fromMaybe1 0

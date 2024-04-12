> {-# LANGUAGE InstanceSigs #-}

Aufgabe 8
=========

> import Data.Char (ord, chr)


I.

Wir betrachten eine vereinfachte Variante des Kartenspiels Black Jack und implementieren diese in
Haskell. Gespielt wird Black Jack mit einem Deck französischer Spielkarten [1]. Ein solches Deck
besteht aus 52 Karten. Jede Karte hat einen Rang (Zahlenwerte von 2 bis 10, Bube, Dame, König und Ass)
und eine Farbe (Kreuz, Pik, Herz und Karo).

[1]: https://de.wikipedia.org/wiki/Spielkarte#Franz%C3%B6sisches_Blatt

Gegeben seien die Datentypen Suit und Rank zur Repräsentation der Farbe und des Rangs einer
Spielkarte vom Typ Card:

> data Suit = Clubs | Spades | Hearts | Diamonds
>   deriving (Show, Enum)

> data Rank = Two | Three | Four | Five | Six | Seven | Eight | Nine | Ten | Jack | Queen | King | Ace
>   deriving (Show, Enum)

> data Card = Card Suit Rank
>   deriving Show

Bei Bedarf dürft ihr weitere Typklassen bei den deriving-Angaben ergänzen.

  
1) Schreibt eine Funktion "getCardValue :: Card -> Int", die den Kartenwert einer Spielkarte beim
   Black Jack bestimmt. Der Kartenwert ergibt sich aus dem Rang einer Karte:
    - Bei Zahlenkarten gibt die Zahl direkt den Wert an
    - Bube, Dame und König haben einen Wert von 10
    - Asse haben einen Wert von 1 oder 11. Ihr tatsächlicher Wert wird erst am Ende einer Runde
      Black Jack festgelegt und zwar so, wie es für den Spieler am günstigsten ist. Für die
      Implementierung könnt ihr zunächst von einem Wert von 11 ausgehen.

> getCardValue :: Card -> Int
> getCardValue (Card _ rank) =
>  case rank of
>    Two -> 2
>    Three -> 3
>    Four -> 4
>    Five -> 5
>    Six -> 6
>    Seven -> 7
>    Eight -> 8
>    Nine -> 9
>    Ten -> 10
>    Jack -> 10
>    Queen -> 10
>    King -> 10
>    Ace -> 11

2) Definiert einen Typ "Hand", der eine Menge von Spielkarten repräsentiert. Eine Hand kann leer
   sein oder sie besteht aus einer Spielkarte und der Menge der restlichen Spielkarten (der
   restlichen Hand). Schreibt außerdem eine Funktion "(<+>) :: Hand -> Hand -> Hand", welche die
   Spielkarten zweier Hände zu einer neuen Hand kombiniert.

> data Hand = Empty | Hand Card Hand
>   deriving Show

> (<+>) :: Hand -> Hand -> Hand
> (<+>) Empty  hand  = hand
> (<+>) hand   Empty = hand
> (<+>) (Hand card rest1) hand2 = Hand card (rest1 <+> hand2)

3) Definiert einen Wert "fullDeck :: Hand" für ein Deck von 52 französischen Spielkarten.

> fullDeck :: Hand
> fullDeck = foldr (<+>) Empty [Hand (Card s r) Empty | s <- [Clubs .. Diamonds], r <- [Two .. Ace]]

4) Schreibt eine Funktion "numOfAces :: Hand -> Int", welche die Anzahl der Asse einer Hand
   zurückliefert.

> numOfAces :: Hand -> Int
> numOfAces Empty = 0
> numOfAces (Hand card hand) | getCardValue card == 11 = 1 + numOfAces hand
>                            | otherwise               =     numOfAces hand

5) Schreibt eine Funktion "getValue :: Hand -> Int", welche den Wert einer Hand berechnet.
   Dabei soll der für einen Black Jack Spieler günstigere Wert bestimmt werden. Das heißt,
   zunächst geht man davon aus, dass ein Ass einen Wert von 11 hat. Liegt der Gesamtwert
   der Hand über 21, so nimmt man hingegen für alle Asse auf der Hand einen Wert von 1 an.

   Beispielaufruf:
   getValue fullDeck  -- Ergebnis: 340

> getValue ::  Hand -> Int
> getValue hand 
>        | getValueWithAce hand > 21 = getValueWithAce hand - numOfAces hand * 10
>        | otherwise = getValueWithAce hand
>        where
>           getValueWithAce  Empty = 0
>           getValueWithAce  (Hand card hand) = getCardValue card + getValueWithAce  hand

II.

Definiert analog zu den Beispielen aus der Vorlesung Instanzen von Semigroup
und Monoid für die folgenden Datentypen. Achtet darauf, dass eure Funktionen
die entsprechenden Gesetze einhalten. 

1) Hier soll das Produkt der Elemente gebildet werden.

> newtype Product = Product {getProduct :: Int}
>   deriving Show

Beispiel:
mconcat [Product 2, Product 3]  -- Ergebnis: Product {getProduct = 6}

> instance Semigroup Product where
>  (<>) :: Product -> Product -> Product
>  (<>) (Product x) (Product y) = Product (x * y)

> instance Monoid Product where
>   mempty :: Product
>   mempty = Product 1

2) Hier soll bestimmt werden, ob die Elemente alle True sind.

> newtype All = All {getAll :: Bool}
>   deriving Show

Beispiel:
mconcat [All True, All True, All True]  -- Ergebnis: All {getAll = True}

> instance Semigroup All where
>  (<>) :: All -> All -> All
>  (<>) (All x) (All y) = All (x && y)

> instance Monoid All where
>   mempty :: All
>   mempty = All True

III.

Mit den Funktionen "ord :: Char -> Int" und "chr :: Int -> Char" aus dem
Modul "Char" kann ein Zeichen in die entsprechende Ordinalzahl und wieder
zurück in das Zeichen konvertiert werden.
Beispiele:
  ord 'a'  =  97
  ord 'b'  =  98
  ord 'A'  =  65
  ord '0'  =  48
  ord '1'  =  49
  ord '9'  =  57
  chr 98   =  'b'
  chr 99   =  'c'
  chr 48   =  '0'

Um eine gute Lesbarkeit des Programmcodes zu erreichen, sollte bei einem
Vergleich oder einer Rechnung mit Zeichen auf die Nutzung der Ordinalwerte im Code
(z.B. 97, 98 etc.) verzichtet werden. Stattdessen eignen sich hierfür die
oben genannten Funktionen in Verbindung mit den Zeichenkonstanten ('a', 'b' etc).
Beispiele:
  'a' < 'b'
  ord 'a' + 1

1) Entwickelt eine Funktion "chrIdx :: Char -> Int", die für einen Buchstaben
   (sowohl große als auch kleine Buchstaben) den Index / die Position im
   Alphabet bestimmt. Es soll eine Zahl zwischen 0 und 25 rauskommen.
   Für alle anderen Zeichen braucht die Funktion nicht definiert zu werden.
   Ihr könnt dann jedoch auch eine Fehlermeldung ausgeben.
   Beispiele:
     chrIdx 'a'  =  0
     chrIdx 'B'  =  1
     chrIdx 'z'  =  25

> chrIdx :: Char -> Int
> chrIdx c
>   | 'a' <= c && c <= 'z' = ord c - ord 'a'
>   | 'A' <= c && c <= 'Z' = ord c - ord 'A'
>   | otherwise = error "Invalid character"

2) Schreibt eine weitere kleine Funktion, die einen Buchstabenindex (Int
   zwischen 0 und 25) um einen angegebenen Wert verschiebt und anschließend
   wieder einen gültigen Buchstabenindex (also wieder ein Int zwischen 0 und 25)
   zurückgibt (also eine Rotation).
   Die Funktion soll "shiftIdx" heißen und zwei Parameter vom Typ Int bekommen.
   Der erste Parameter ist der Wert für die Verschiebung und der zweite
   Parameter ist der zu verschiebende Index.
   Beispiele:
     shiftIdx   1   0  =  1
     shiftIdx   2   4  =  6
     shiftIdx   2  25  =  1
     shiftIdx (-2)  0  =  24

> shiftIdx :: Int -> Int -> Int
> shiftIdx shift index = (index + shift) `mod` 26

3) Die folgende Funktion verschiebt den Wert eines Buchstaben c um einen
   angegebenen Wert n, unter Verwendung der Funktionen aus Teilaufgabe 1) und 2).
   Außerdem werden dabei kleine Buchstaben in Großbuchstaben ungewandelt.
   (Markiert diese Definition als Code (mit "> "), sobald ihr die benötigten
   Funktionen implementiert habt.)

> shiftChr'     :: Int -> Char -> Char
> shiftChr' n c = chr (shiftIdx n (chrIdx c) + ord 'A')

   a) Was passiert, wenn die Funktion mit einem Zeichen aufgerufen wird, welches
      kein Buchstabe ist? Und woran liegt das?

> -- chrIdx schlägt fehl wenn keine Buchstabe eingeben wird

   b) Implementiert eine Funktion "shiftChr", die sich für Buchstaben genauso wie
      die Hilfsfunktion shiftChr' verhält (sie kann diese einfach verwenden),
      aber für nicht-Buchstaben keine Verschiebung vornimmt.
      Beispiele:
        shiftChr 1 'a'  =  'B'
        shiftChr 1 'Z'  =  'A'
        shiftChr 1 '7'  =  '7'

> shiftChr :: Int -> Char -> Char
> shiftChr n c
>   | 'a' <= c && c <= 'z' = shiftChr' n c
>   | 'A' <= c && c <= 'Z' = shiftChr' n c
>   | otherwise = c

4) Implementiert nun mit Hilfe einer Listcomprehension eine Funktion
   "rot13 :: String -> String", welche die Werte aller Buchstaben in einer
   Zeichenkette um 13 Stellen verschiebt. Verwendet hierfür die Funktion
   "shiftChr" aus Aufgabe 3b), damit Zeichen, die keine Buchstaben sind,
   hierbei nicht verändert werden.
   Beispiele:
     rot13 "Hallo Welt"  =  "UNYYB JRYG"
     rot13 "UNYYB JRYG"  =  "HALLO WELT"
     rot13 "Test 123"    =  "GRFG 123"


> rot13 :: String -> String
> rot13 str = [shiftChr 13 c | c <- str]

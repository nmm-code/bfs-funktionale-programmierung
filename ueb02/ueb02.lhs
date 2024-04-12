Aufgabe 2
=========

Thema: Funktionen, Guards

Das Standard Modul Prelude importieren und dabei die bereits vordefinierte
Funktion splitAt verstecken, um sie selbst implementieren zu können:

> import Prelude hiding (splitAt)


I. Definition einfacher Funktionen
----------------------------------

Guckt euch im GHCi die Signaturen der Funktionen "take" und "drop" an und probiert
sie aus, z.B. mit:

take 2 [1,2,3,4,5]
drop 2 [1,2,3,4,5]


1) a) Was macht die Funktion "splitAt"?

> splitAt :: Int -> [a] -> ([a], [a])
> splitAt n xs  = (take n xs, drop n xs)

Teilt die Liste an der stelle n und
und gibt die erste hälfte und die zweite hälfte zurück als tupel


   b) Definiert eine Funktion "splitHalf", die eine Liste
      mit einer geraden Länge in ein Paar mit zwei gleichlangen Listen aufteilt.
      Bei einer Liste mit ungerader Länger soll die erste Ergebnisliste um ein
      Element kürzer sein als die zweite (siehe Beispiel).
      Nutzt für die Definition die Funktion "splitAt" und weitere passende
      Funktionen aus dem Prelude-Modul und keine Muster.
      Beispiele:
        splitHalf [1,2,3,4]   ergibt   ([1,2], [3,4])
        splitHalf [1,2,3]     ergibt   ([1],   [2,3])

> splitHalf :: [a] -> ([a], [a])
> splitHalf xs = splitAt (length xs `div` 2) xs


2) Gesucht ist eine Funktion "evenLength", die entscheiden soll ob die Länge
   einer Liste (mit beliebigem Elementtyp) gerade ist oder nicht.
   Beispiele:
     evenLength [1,2,3]   ergibt   False
     evenLength [True, False]   ergibt   True

   a) Überlegt euch zunächst einen Typ für diese Funktion

evenLength :: [a] -> Bool

   b) Definiert nun die Funktion "evenLength" unter Verwendung der Funktionen
      "length", "mod" und "(==)".
      Diese sind bereits im Standard Modul "Prelude" definiert und können daher
      einfach verwendet werden.
      (siehe auch https://hackage.haskell.org/package/base-4.8.1.0/docs/Prelude.html)

> evenLength :: [a] -> Bool
> evenLength xs = (length xs `mod` 2) == 0

3) a) Schreibt eine Funktion "sndSnd :: (a, (b, c)) -> c", die aus zwei
      geschachtelten Paaren die zweite Komponente der zweiten Komponente
      zurückgibt. Nutzt hierfür nur Funktionen aus der Prelude und keine Muster.
      Beispiele:
        sndSnd (1, (2, 3))   ergibt   3
        sndSnd ((3,4.5,6), ('x', [True]))   ergibt   [True]

> sndSnd :: (a, (b, c)) -> c
> sndSnd (a,(b,c)) = snd (b,c);


   b) Ist diese Funktion total oder partiell?
      Begründet eure Antwort.

-- total, da sie für alle möglichen eingaben funktioniert


4) Entwickelt eine Funktion "firstIndex", die das erste Element einer Liste
   nimmt und damit das n-te Element (bei 0 angefangen zu zählen) der selben
   Liste auswählt.
   Fehlerhafte Aufrufe (leere Listen) müssen (noch) nicht abgefangen werden.
   Beispiele:
     firstIndex [2,3,4,5,6]   ergibt   4
     firstIndex [0,3,4,5,6]   ergibt   0

   a) Welchen Elementtyp darf die Liste nur besitzen?

> firstIndex :: [Int] -> Int


   b) Definiert nun die Funktion firstIndex.
      Verwendet auch hier nur Funktionen aus der Prelude.

> firstIndex xs = head (drop (head xs) xs) -- drop gibt eine liste ohne die ersten n elemente zurück

   c) Was passiert, wenn firstIndex mit einer leeren Liste aufgerufen wird (und warum)?
      (Solltet ihr diesen Fall in eurer Implementierung schon berücksichtigt
      haben, beschreibt was passiert, wenn ihr dies nicht getan hättet.)

> -- es wird ein fehler geworfen, da head auf eine leere liste angewendet wird


   d) Was passiert, wenn firstIndex mit der Liste [1] aufgerufen wird (und warum)?

> -- drop 1 [1] == []
> -- head [] -- fehler

II. Guards (Wächter)
--------------------

Die Funktion "splitHalf" aus der ersten Aufgabe produziert bei Listen mit einer
ungerader Länge zwei unterschiedlich lange Teillisten.
Es kann hilfreich sein diesen Fall abzufangen:

 splitHalf'    :: [a] -> ([a], [a])
 splitHalf' xs = if even (length xs)
                    then splitHalf xs
                    else error "Listenlaenge ist ungerade!"

Markiert die Programmzeilen jeweils mit einem "> " und ruft die Funktion auf.

1) a) Schreibt die Funktion splitHalf' so um, dass sie mit Wächtern/Guards
      arbeitet und nicht mit einer Verzweigung (if ... then ... else)
      Ihr könnt diese neue Funktion splitHalf'' nennen.

> splitHalf'' :: [a] -> ([a], [a])
> splitHalf'' xs
>   | even (length xs) = splitHalf xs
>   | otherwise        = error "Listenlaenge ist ungerade!"

   b) Entwickelt eine weitere Funktion splitHalf2, die bei Listen mit ungerader
      Länge das mittlere Element in beide Teillisten packt.
      Ihr könnt diese Funktion entweder mit einer Verzweigung oder mit Guards
      implementieren.
      Beispiele:
        splitHalf2 [1,2,3,4]  ergibt  ([1,2],[3,4])
        splitHalf2 [1,2,3]    ergibt  ([1,2],[2,3])
        splitHalf2 "hallo"    ergibt  ("hal","llo")

> splitHalf2 :: [a] -> ([a], [a])
> splitHalf2 xs
>   | even (length xs) = splitHalf xs
>   | otherwise        = splitHalf (take (length xs `div` 2+1) xs ++ drop (length xs `div` 2) xs)

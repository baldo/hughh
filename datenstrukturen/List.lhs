Listen-Definition
=================

Spezielle Syntax für den Listen-Typ, daher hier nur als Kommentar:

> -- data [a] = [] | a : [a]


Funktionen auf Listen
=====================

* In der Prelude z.T. effizientere Implementierungen, jedoch mit gleicher
  Laufzeitkomplexität.
* Namen der Funktionen wegen Konflikten mit Prelude leicht angepasst.


-------------------------------------------------------------------------------
  

Zugriff via `head`, `tail` und Patternmatching
----------------------------------------------

> -- O(1)
> head' :: [a] -> a
> head' (x : _) = x
> head' []      = error "Empty list"

> -- O(1)
> tail' :: [a] -> [a]
> tail' (_ : xs) = xs
> tail' []       = error "Empty list"


-------------------------------------------------------------------------------
  
 
Teurer ist Zugriff am Ende
--------------------------

> -- O(n), n == length xs
> last' :: [a] -> a
> last' [x]      = x
> last' (_ : xs) = last' xs
> last' []       = error "Empty list"


-------------------------------------------------------------------------------
  

Auch Konkatenation ist potentiell teuer
---------------------------------------

> -- O(n), n == length xs
> (+++) :: [a] -> [a] -> [a]
> []       +++ ys = ys
> (x : xs) +++ ys = x : (xs +++ ys)


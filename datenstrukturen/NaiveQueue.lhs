Queues - naive Implementierung
==============================

> type Queue a = [a]

> empty :: Queue a
> empty = []


-------------------------------------------------------------------------------


Funktionen
----------

> -- O(1)
> isEmpty :: Queue a -> Bool
> isEmpty [] = True
> isEmpty _  = False

Es ist teuer einen Wert am Ende der Liste anzufügen:

> -- O(n), n == length xs
> put :: a -> Queue a -> Queue a
> put x xs = xs ++ [x]

> -- O(1)
> get :: Queue a -> (a, Queue a)
> get (x : xs) = (x, xs)
> get []       = error "Empty queue"

Hier ist es natürlich auch möglich den Rückgabewert von `get` mittels
`Maybe` zu kapseln, anstatt `error` zu verwenden.


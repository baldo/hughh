Queues - zweiter Versuch
========================

> data Queue a = Queue { qIn :: [a], qOut :: [a] }

> empty :: Queue a
> empty = Queue [] []


-------------------------------------------------------------------------------


Funktionen
----------

> -- O(1)
> isEmpty :: Queue a -> Bool
> isEmpty (Queue [] []) = True
> isEmpty _             = False

Das Einfügen ist hier billig:

> -- O(1)
> put :: a -> Queue a -> Queue a
> put x queue = queue { qIn = x : qIn queue }


-------------------------------------------------------------------------------


Wie ist hier die Laufzeitkomplexität?

> get :: Queue a -> (a, Queue a)
> get (Queue [] []) = error "Empty queue."

> -- konstant, falls qOut nicht leer
> get q@(Queue { qOut = x : xs }) = (x, q { qOut = xs })

> -- linear in n, n == length xs, falls qOut leer
> get q@(Queue { qIn = xs, qOut = [] }) = get q { qIn = [], qOut = reverse xs }


-------------------------------------------------------------------------------


Was haben wir gewonnen?

* `put` ist jetzt in O(1) statt in O(n)
* `take` ist im Normalfall immer noch konstant
* `take` ist nur im schlechtesten Fall linear in der Queue-Länge


-------------------------------------------------------------------------------


Aber:

* Je größer die Queue, desto seltener wird `reverse` aufgerufen.
* Die amortisierte Laufzeit ist somit konstant.
* Jedes Element wird drei mal anfasst. Jeweils einmal bei
  `put`, `reverse` und `get`.


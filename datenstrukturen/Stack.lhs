Stacks
======

In Haskell sind Listen Stacks:

> type Stack a = [a]

> -- O(1)
> push :: a -> Stack a -> Stack a
> push = (:)

> -- O(1)
> pop :: Stack a -> Stack a
> pop = tail

> -- O(1)
> top :: Stack a -> a
> top = head


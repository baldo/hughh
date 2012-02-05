Tries
=====

* Effiziente Key-Value-Maps


String-Tries
============

![](StringTrie.png)


-------------------------------------------------------------------------------


Implementierung greift für `CharTrie` auf `Data.Map` zurück.

> import Data.Map (Map)
> import qualified Data.Map as Map

Trie für Listen. Hinterlegt jeden Teil-Listen-Trie in `map`.

> data ListTrie map v =
>          ListTrie
>              (Maybe v)               -- []
>              (map (ListTrie map v))  -- (:)

Z.B. für Strings:

> type StringTrie v = ListTrie (Map Char) v


-------------------------------------------------------------------------------


> -- O(1)
> empty :: StringTrie v
> empty = ListTrie Nothing Map.empty

Diese Implementierung von `isEmpty` geht davon aus, dass der Trie minimiert
ist.

> -- O(1)
> isEmpty :: StringTrie v -> Bool
> isEmpty (ListTrie Nothing tc) = Map.null tc
> isEmpty _                     = False


-------------------------------------------------------------------------------


> -- O(n), n == length cs
> insert :: String -> v -> StringTrie v -> StringTrie v
> insert []       v (ListTrie _  tc) = ListTrie (Just v) tc
> insert (c : cs) v (ListTrie tn tc) = ListTrie tn       tc'
>   where
>     tc' = Map.insert c (insert cs v ts) tc
>     ts  = maybe empty id (Map.lookup c tc)

> -- O(n), n == length cs
> lookup' :: String -> StringTrie v -> Maybe v
> lookup' ""       (ListTrie tn _ ) = tn
> lookup' (c : cs) (ListTrie _  tc) = do
>     ts <- Map.lookup c tc
>     lookup' cs ts


-------------------------------------------------------------------------------


> -- O(n), n == length cs
> delete :: String -> StringTrie v -> StringTrie v
> delete ""       (ListTrie _  tc) = ListTrie Nothing tc

Wird beim Löschen ein Teil-Trie leer, so sollte dieser aus dem Trie entfernt
werden, damit dieser minimal wird.

> delete (c : cs) (ListTrie tn tc) = ListTrie tn      tc'
>   where
>     tc' = Map.update (\ ts -> cleanup $ delete cs ts) c tc
>     cleanup t
>       | isEmpty t = Nothing
>       | otherwise = Just t


Maybe-Bool-Listen-Tries
=======================

![](MaybeBoolListTrie.png)


-------------------------------------------------------------------------------


> data BoolTrie v =
>          BoolTrie
>              (Maybe v)  -- False
>              (Maybe v)  -- True

> data MaybeTrie map v =
>          MaybeTrie
>              (Maybe v)  -- Nothing
>              (map v)    -- Just

> type MaybeBoolListTrie v = ListTrie (MaybeTrie BoolTrie)


Fazit Tries
===========

* `lookup`, `insert` und `delete` in O(n) mit Schlüsselgröße n.
* Dank Sharing können sich verschiedene Versionen eines Tries große Teile des
  benötigten Speichers teilen.

Aber:

* Für jeden Schlüsseltyp wird ein neuer Trie-Typ inkl. zugehöriger Funktionen
  benötigt.
* Erzeugung mittels Template-Haskell möglich.


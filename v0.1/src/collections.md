##Collections
###Table of Contents

* [`each<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Elemaent -> Any)`]()
* `map` - <strong><small>Native Support</small></strong>
* `reduce` - <strong><small>Native Support</small></strong>
* [`reduceRight<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U`]()
* [`find<T : Sequence>(seq: T, condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element?`]()
* `filter` - <strong><small>Native Support</small></strong>
* [`where<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Array<Dictionary<K,V>>`]()
* [`findWhere<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Dictionary<K,V>?`]()
* [`reject<T : Sequence>(seq: T, _ condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[]`]()
* [`every<L: LogicValue>(list: L[]) -> Bool`]()
* [`every<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool ) -> Bool`]()
* [`some<L: LogicValue>(list: L[]) -> Bool`]()
* [`some<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool`]()
* `contains` - <strong><small>Native Support</small></strong>
* `invoke` - <strong><small>Not sure if it's implementable.</small></strong>
* [`pluck<K, V>(list: Array<Dictionary<K, V>>, key: K) -> V[]`]()
* [`max<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element`]()
* [`max<C: Comparable>(list: C...) -> C`]()
* [`min<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element`]()
* [`min<C: Comparable>(list: C...) -> C`]()
* [`sortBy<T : Sequence, C: Comparable>(seq: T, transform: T.GeneratorType.Element -> C) -> T.GeneratorType.Element[]`]()
* [`groupBy<K, V>(list: V[], transform: V -> K) -> Dictionary<K, V[]>`]()
* [`indexBy<K, V>(list: Array< Dictionary<K, V> >, key: K) -> Dictionary<V, Dictionary<K,V>>`]()
* [`countBy<T, U>(list: T[], transform: T -> U) -> Dictionary<U, Int>`]()
* [`shuffle<T>(list: T[]) -> T[]`]()
* [`sample<T>(list: T[]) -> T`]()
* [`sample<T>(list: T[], _ n:Int) -> T[]`]()
* [`size<T : Sequence>(seq: T) -> Int `]()

<small>This index has the same order as [Underscore.js](http://underscorejs.org/#collections)</small>

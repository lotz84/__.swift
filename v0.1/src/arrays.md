##Arrays
###Table of Contents

* [`first<T>(array:T[]) -> T!`]()
* [`first<T>(array:T[], _ n:Int) -> T[]!`]()
* [`initial<T>(array:T[], _ n: Int = 1) -> T[]`]()
* [`last<T>(array: T[]) -> T`]()
* [`last<T>(array: T[], _ n: Int) -> T[]`]()
* [`rest<T>(array: T[], _ n: Int = 1) -> T[]`]()
* [`compact<T : LogicValue>(array: T[]) -> T[]`]()
* [`flatten<T>(array: T[][]) -> T[]`]()
* [`without<T: Equatable>(array: T[], values: T...) -> T[]`]()
* [`partition<T>(array: T[], condition: T -> Bool ) -> (T[], T[])`]()
* `union` - <strong><small>Incomplete</small></strong>
* `intersection` - <strong><small>Incomplete</small></strong>
* `difference` - <strong><small>Incomplete</small></strong>
* `uniq` - <strong><small>Incomplete</small></strong>
* [`zip<T, U>(array0: T[], _ array1: U[]) -> (T, U)[]`]()
* [`object<K : Hashable, V>(#keys: K[], values:V[] ) -> Dictionary<K, V>`]()
* [`object<K : Hashable, V>(keyAndValues: Array<(K, V)>) -> Dictionary<K, V>`]()
* [`indexOf<T: Equatable>(array: T[], value:T) -> Int?`]()
* [`indexOf<T: Comparable>(array: T[], value:T, isSorted: Bool) -> Int?`]()
* [`lastIndexOf<T : Equatable>(array : T[], value: T) -> Int?`]()
* [`lastIndexOf<T : Equatable>(array : T[], value: T, from: Int) -> Int?`]()
* [`sortedIndex<T, U : Comparable>(array : T[], value : T, transform: T -> U ) -> Int?`]()
* [`range(stop: Int) -> Int[]`]()
* [`range(#start: Int, stop: Int) -> Int[]`]()
* [`range(#start: Int, stop: Int, step: Int) -> Int[]`]()

<small>This index has the same order as [Underscore.js](http://underscorejs.org/#arrays)</small>

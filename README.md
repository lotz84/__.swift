__.swift
========

__.swift aim to be an utility belt for [Swift Language](https://developer.apple.com/swift/).So we first make it be a clone of [Underscore.js](http://underscorejs.org/), which is utility belt for JavaScript.

Although this library is **under developping** (this has not been v0.1.0 yet), We make it public. That is because Swift Language is new language and We think it is useful to everyone to show how to develop by trial and error.

##Example

    __.map([11,22,33], { x in x * x })
    // [121, 484, 1089]

    __.reduce(["H", "e", "l", "l", "o", " ", "S", "w", "i", "f", "t", " ", "!", "!"], memo: "", iterator: + )
    // Hello Swift !!

    func isPrime(n: Int) -> Bool {
      if n < 2 { return false }
      let max = Int(sqrt(Double(n)))
      for i in 2...max {
        if n % i == 0 { return false }
      }
      return true
    }
    __.find([1,33,173,46], filter: isPrime)
    // 173

    __.filter(Array(2..100) , filter: isPrime)
    // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]

    let data = [
      ["plan": "walking", "time": "8 a.m."],
      ["plan": "work",    "time": "10 a.m."],
      ["plan": "lunch",   "time": "12 a.m."]
    ]
    __.pluck(data, key: "plan")
    // [walking, work, lunch]

##Progress
###Collections

|Underscore.js|__.swift|
|:---|:---|
|`_.each(list, iterator, [context])`|`__.each<T>(list: T[], iterator: T -> Any)`|
|`_.map(list, iterator, [context])`|`__.map<T, U>(list: T[], iterator: T -> U) -> U[]`|
|`_.reduce(list, iterator, memo, [context])`|`__.reduce<T, U>(list: T[], memo: U, iterator: (first:U, second:T) -> U) -> U`|
|`_.reduceRight(list, iterator, memo, [context])`|Incomplete|
|`_.find(list, predicate, [context])`|`__.find<T>(list: T[], filter: T -> Bool) -> T?`|
|`_.filter(list, predicate, [context])`|`__.filter<T>(list: T[], filter: T -> Bool) -> T[]`|
|`_.where(list, properties)`|Incomplete|
|`_.findWhere(list, properties)`|Incomplete|
|`_.reject(list, predicate, [context])`|`__.reject<T>(list: T[], filter: T -> Bool) -> T[]`|
|`_.every(list, [predicate], [context])`|`__.every<L: LogicValue>(list: L[]) -> Bool`|
|`_.some(list, [predicate], [context])`|`__.some<L: LogicValue>(list: L[]) -> Bool`|
|`_.contains(list, value)`|`__.contains<E: Equatable>(list: E[], value: E) -> Bool`|
|`_.invoke(list, methodName, *arguments)`|I have not decided whether implement.|
|`_.pluck(list, propertyName)`|`__.pluck<K, V>(list: Array<Dictionary<K, V>>, key: K) -> V[]`|
|`_.max(list, [iterator], [context])`|`__.max<C: Comparable>(list: C[]) -> C!`|
|`_.min(list, [iterator], [context])`|`__.min<C: Comparable>(list: C[]) -> C!`|
|`_.sortBy(list, iterator, [context])`|`__.sortBy<T, C: Comparable>(list: T[], iterator: T -> C) -> T[]`|
|`_.groupBy(list, iterator, [context])`|`__.groupBy<K, V>(list: V[], iterator: V -> K) -> Dictionary<K, V[]>`|
|`_.indexBy(list, iterator, [context])`|`__.indexBy<K, V>(list: Array< Dictionary<K, V> >, key: K) -> Dictionary<V, Dictionary<K,V> >`|
|`_.countBy(list, iterator, [context])`|`__.countBy<T, U>(list: T[], iterator: T -> U) -> Dictionary<U, Int>`|
|`_.shuffle(list)`|`__.shuffle<T>(list: T[]) -> T[]`|
|`_.sample(list, [n])`|`__.sample<T>(list: T[]) -> T`<br>`__.sample<T>(list: T[], n:Int) -> T[]`|
|`_.size(list)`|`__.size<T>(list: T[]) -> Int`<br>`__.size<K, V>(dict: Dictionary<K, V>) -> Int`|

###Arrays

|Underscore.js|__.swift|
|:---|:---|
|`_.first(array, [n])`|`__.first<T>(list:T[]) -> T!`<br>`__.first<T>(list:T[], n:Int) -> T[]!`|
|`_.initial(array, [n])`|`__.initial<T>(list:T[], n: Int = 1) -> T[]`|
|`_.last(array, [n])`|`__.last<T>(list: T[]) -> T`<br>`__.last<T>(list: T[], n: Int) -> T[]`|
###Functions
###Objects
###Utility
###Chaining

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
Progression table has moved to [wiki](https://github.com/lotz84/__.swift/wiki).

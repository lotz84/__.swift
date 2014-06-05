__.swift
========

__.swift aim to be a useful utility belt for [Swift Language](https://developer.apple.com/swift/).
So we first make it be a clone of [Underscore.js](http://underscorejs.org/), which is utility belt for JavaScript.

##Example

    __.each(["Hello", "Swift", "!!"], { x in println(x) })
    // Hello
    // Swift
    // !!

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

    __.reject(Array(2..30) , filter: isPrime)
    // [4, 6, 8, 9, 10, 12, 14, 15, 16, 18, 20, 21, 22, 24, 25, 26, 27, 28]

    let data = [
      ["plan": "walking", "time": "8 a.m."],
      ["plan": "work",    "time": "10 a.m."],
      ["plan": "lunch",   "time": "12 a.m."]
    ]
    __.pluck(data, key: "plan")
    // [walking, work, lunch]

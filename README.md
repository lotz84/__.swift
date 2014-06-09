__.swift
========
__.swift aims to be an utility belt for a new programming language by Apple Inc., [Swift](https://developer.apple.com/swift/). And we decided  __.swift to be a clone of [Underscore.js](http://underscorejs.org/), which is an utility belt for JavaScript.

Although __.swift library is still **under development** (This has not been even v0.1.0 yet), We made it public. This is because Swift is totally new language for everyone around the world, and we thought it is useful for everyone to learn how to code Swift by trial and error.

##Example

    __.map([11,22,33]) { x in x * x }
    // [121, 484, 1089]

    __.reduce(["H", "e", "l", "l", "o", " ", "S", "w", "i", "f", "t", " ", "!", "!"], "", + )
    // Hello Swift !!

    func isPrime(n: Int) -> Bool {
      if n < 2 { return false }
      let max = Int(sqrt(Double(n)))
      for i in 2...max {
        if n % i == 0 { return false }
      }
      return true
    }
    __.find([1,33,173,46], isPrime)
    // 173

    __.filter(Array(2..100) , isPrime)
    // [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]

    let data = [
      ["plan": "walking", "time": "8 a.m."],
      ["plan": "work",    "time": "10 a.m."],
      ["plan": "lunch",   "time": "12 a.m."]
    ]
    __.pluck(data, "plan")
    // [walking, work, lunch]

##Progress
Progression table is available at [wiki](https://github.com/lotz84/__.swift/wiki).

##__.swift
###Index

* [Home](index.html)
* **__.swift**
  * [Collections](collections.html)
  * [Arrays](arrays.html)
  * [Dictionaries](dictionaries.html)
  * [Functions](functions.html)
  * [Utility](utility.html)
  * [Chaining](chaining.html)
* [Change Log](changelog.html)

###Tutorial

####Example

<pre class="prettyprint">
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
</pre>

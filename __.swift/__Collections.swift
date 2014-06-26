//
//  __Collections.swift
//  __.swift
//
//  Copyright (c) 2014 Tatsuya Hirose
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

import Foundation

extension __ {
    
    /**
    * Collection Functions (Arrays or Dictionaries)
    */
    
    class func each<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        var gen = seq.generate()
        while let elem = gen.next() {
            iterator(elem)
        }
    }
    
    // alias for each
    class func forEach<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        __.each(seq, iterator)
    }
    
    class func reduceRight<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        var array : Array<T.GeneratorType.Element> = []
        var gen = seq.generate()
        while let elem = gen.next() {
            array += elem
        }
        return array.reverse().reduce(initial, combine: { combine($1,$0) } )
    }
    
    class func foldr<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        return __.reduceRight(seq, initial: initial, combine: combine)
    }
    
    class func find<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        var gen = seq.generate()
        while let elem = gen.next() {
            if predicate(elem) {
                return elem
            }
        }
        return nil
    }
    
    // alias for find
    class func detect<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        return __.find(seq, predicate)
    }
 
    class func `where`<K,V: Equatable>(array: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Array<Dictionary<K,V>> {
        var result : Array<Dictionary<K,V>> = []
        for dict in array {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                result += dict
            }
        }
        return result
    }
    
    class func findWhere<K,V: Equatable>(array: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Dictionary<K,V>? {
        for dict in array {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                return dict
            }
        }
        return nil
    }
    
    class func reject<T : Sequence>(seq: T, _ condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[] {
        return Array(filter(seq, { !condition($0) }))
    }
    
    class func every<L: LogicValue>(array: L[]) -> Bool {
        return __.every(array, predicate: { $0.getLogicValue() })
    }
    
    class func every<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool ) -> Bool {
        return __.find(seq, { !predicate($0) }) ? false : true
    }
    
    // alias for every
    class func all<L: LogicValue>(array: L[]) -> Bool {
        return __.every(array)
    }
    
    // alias for every
    class func all<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.every(seq, predicate: predicate)
    }
    
    class func some<L: LogicValue>(array: L[]) -> Bool {
        return __.some(array, predicate: { $0.getLogicValue() })
    }
    
    class func some<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.find(seq, predicate ) ? true : false
    }
    
    // alias for some
    class func any<L: LogicValue>(array: L[]) -> Bool {
        return __.some(array)
    }
    
    // alias for some
    class func any<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.some(seq, predicate: predicate)
    }
    
    class func pluck<K, V>(array: Array<Dictionary<K, V>>, key: K) -> V[] {
        var result : V[] = []
        for item in array {
            if let value = item[key] {
                result += value
            }
        }
        return result
    }
    
    // quick sort
    class func sortBy<T : Sequence, C: Comparable>(seq: T, transform: T.GeneratorType.Element -> C) -> T.GeneratorType.Element[] {
        
        var gen = seq.generate()
        
        if let first = gen.next() {
            
            var smaller : Array<T.GeneratorType.Element> = []
            var bigger  : Array<T.GeneratorType.Element> = []
            
            while let elem = gen.next() {
                if transform(first) < transform(elem) {
                    bigger += elem
                } else {
                    smaller += elem
                }
            }
            
            var result = sortBy(smaller, transform: transform)
            result += first
            result += sortBy(bigger, transform: transform)
            
            return result
        } else {
            return []
        }
    }
    
    class func groupBy<K, V>(array: V[], transform: V -> K) -> Dictionary<K, V[]> {
        var result : Dictionary<K, V[]> = [:]
        
        for item in array {
            let key = transform(item)
            if let array = result[key] {
                result[key] = array + [item]
            } else {
                result[key] = [item]
            }
        }
        
        return result
    }
    
    class func indexBy<K, V>(array: Array< Dictionary<K, V> >, key: K) -> Dictionary<V, Dictionary<K,V>> {
        var result = Dictionary<V, Dictionary<K,V>>()
        for item in array {
            result[item[key]!] = item
        }
        return result
    }
    
    class func countBy<T, U>(array: T[], transform: T -> U) -> Dictionary<U, Int> {
        var result : Dictionary<U, Int> = [:]
        for item in array {
            if let count = result[transform(item)] {
                result[transform(item)] = count + 1
            } else {
                result[transform(item)] = 1
            }
        }
        return result
    }
    
    class func shuffle<T>(array: T[]) -> T[] {
        let length = array.count
        var random = Array(0..length)
        for i in 1..length {
            let j = __.random(min: 0, max: i)
            swap(&random[i], &random[j])
        }
        return random.map { array[$0] }
    }
    
    class func sample<T>(array: T[]) -> T {
        let index = __.random(array.count-1)
        return array[index]
    }
    
    class func sample<T>(array: T[], _ n:Int) -> T[] {
        var result : T[] = []
        let random = __.shuffle(Array(0..array.count))
        for i in 0..n {
            result += array[random[i]]
        }
        return result
    }
    
    class func size<T : Sequence>(seq: T) -> Int {
        var count = 0
        var gen = seq.generate()
        while gen.next() {
            count += 1
        }
        return count
    }
    
}

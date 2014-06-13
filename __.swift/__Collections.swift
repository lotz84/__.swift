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
    
    class func foldl1<T : Sequence>(seq: T, combine: (T.GeneratorType.Element, T.GeneratorType.Element) -> T.GeneratorType.Element) -> T.GeneratorType.Element {
        var accum : T.GeneratorType.Element?
        var gen = seq.generate()
        while let elem = gen.next() {
            accum = accum ? combine(accum!, elem) : elem
        }
        return accum!
    }
    
    class func reduceRight<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        var array = Array<T.GeneratorType.Element>()
        var gen = seq.generate()
        while let elem = gen.next() {
            array += elem
        }
        return array.reverse().reduce(initial, combine: { combine($1,$0) } )
    }
    
    class func find<T : Sequence>(seq: T, condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        var gen = seq.generate()
        while let elem = gen.next() {
            if condition(elem) {
                return elem
            }
        }
        return nil
    }
    
    // alias for find
    class func detect<T : Sequence>(seq: T, _ filter: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        return __.find(seq, filter)
    }
 
    class func `where`<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Array<Dictionary<K,V>> {
        var result = Array<Dictionary<K,V>>()
        for dict in list {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                result += dict
            }
        }
        return result
    }
    
    class func findWhere<K,V: Equatable>(list: Array<Dictionary<K,V>>, _ properties: Dictionary<K,V>) -> Dictionary<K,V>? {
        for dict in list {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                return dict
            }
        }
        return nil
    }
    
    class func reject<T : Sequence>(seq: T, _ condition: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element[] {
        return Array(filter(seq, { !condition($0) }))
    }
    
    class func every<L: LogicValue>(list: L[]) -> Bool {
        return __.find(list, { !$0 }) ? false : true
    }
    
    class func every<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool ) -> Bool {
        return __.find(seq, { !predicate($0) }) ? false : true
    }
    
    // alias for every
    class func all<L: LogicValue>(list: L[]) -> Bool {
        return __.every(list)
    }
    
    class func all<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.every(seq, predicate: predicate)
    }
    
    class func some<L: LogicValue>(list: L[]) -> Bool {
        return __.find(list, { $0.getLogicValue() }) ? true : false
    }
    
    class func some<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.find(seq, predicate ) ? true : false
    }
    
    // alias for any
    class func any<L: LogicValue>(list: L[]) -> Bool {
        return __.some(list)
    }
    
    class func any<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.some(seq, predicate: predicate)
    }
    
    class func pluck<K, V>(list: Array<Dictionary<K, V>>, key: K) -> V[] {
        var result = V[]()
        for item in list {
            if let value = item[key] {
                result += value
            }
        }
        return result
    }
    
    class func max<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element {
        return __.foldl1(seq, combine: { $1 > $0 ? $1 : $0 })
    }
    
    class func max<C: Comparable>(list: C...) -> C {
        return __.max(list)
    }
    
    class func min<T : Sequence where T.GeneratorType.Element : Comparable>(seq: T) -> T.GeneratorType.Element {
        return __.foldl1(seq, combine: { $0 < $1 ? $0 : $1 })
    }

    class func min<C: Comparable>(list: C...) -> C {
        return __.min(list)
    }
    
    // quick sort
    class func sortBy<T : Sequence, C: Comparable>(seq: T, transform: T.GeneratorType.Element -> C) -> T.GeneratorType.Element[] {
        
        var gen = seq.generate()
        
        if let first = gen.next() {
            
            var smaller = Array<T.GeneratorType.Element>()
            var bigger = Array<T.GeneratorType.Element>()
            
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
    
    class func groupBy<K, V>(list: V[], _ iterator: V -> K) -> Dictionary<K, V[]> {
        var result = Dictionary<K, V[]>()
        
        for item in list {
            let key = iterator(item)
            if let array = result[key] {
                result[key] = array + [item]
            } else {
                result[key] = [item]
            }
        }
        
        return result
    }
    
    class func indexBy<K, V>(list: Array< Dictionary<K, V> >, _ key: K) -> Dictionary<V, Dictionary<K,V> > {
        var result = Dictionary<V, Dictionary<K,V> >()
        for item in list {
            result[item[key]!] = item
        }
        return result
    }
    
    class func countBy<T, U>(list: T[], _ iterator: T -> U) -> Dictionary<U, Int> {
        var result = Dictionary<U, Int>()
        for item in list {
            if let count = result[iterator(item)] {
                result[iterator(item)] = count + 1
            } else {
                result[iterator(item)] = 1
            }
        }
        return result
    }
    
    class func shuffle<T>(list: T[]) -> T[] {
        let length = list.count
        var random = Int[]()
        while random.count < length {
            let index = __.random(length-1)
            if !contains(random, index) {
                random += index
            }
        }
        return random.map { list[$0] }
    }
    
    class func sample<T>(list: T[]) -> T {
        let index = __.random(list.count-1)
        return list[index]
    }
    
    class func sample<T>(list: T[], _ n:Int) -> T[] {
        var result = T[]()
        let random = __.shuffle(Array(0..list.count))
        for i in 0..n {
            result += list[random[i]]
        }
        return result
    }
    
    class func size<T>(list: T[]) -> Int {
        return list.count
    }
    
    class func size<K, V>(dict: Dictionary<K, V>) -> Int {
        return Array(dict.keys).count
    }
    
}

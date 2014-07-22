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

public extension __ {
    
    /**
    * Collection Functions (Arrays or Dictionaries)
    */
    
    public class func each<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        var gen = seq.generate()
        while let elem = gen.next() {
            iterator(elem)
        }
    }
    
    // alias for each
    public class func forEach<T : Sequence>(seq: T, _ iterator: T.GeneratorType.Element -> Any){
        __.each(seq, iterator)
    }
    
    public class func reduceRight<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        var array : [T.GeneratorType.Element] = []
        var gen = seq.generate()
        while let elem = gen.next() {
            array += elem
        }
        return array.reverse().reduce(initial, combine: { combine($1,$0) } )
    }
    
    public class func foldr<T : Sequence, U>(seq: T, initial: U, combine: (T.GeneratorType.Element, U) -> U) -> U {
        return __.reduceRight(seq, initial: initial, combine: combine)
    }
    
    public class func find<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        var gen = seq.generate()
        while let elem = gen.next() {
            if predicate(elem) {
                return elem
            }
        }
        return nil
    }
    
    // alias for find
    public class func detect<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> T.GeneratorType.Element? {
        return __.find(seq, predicate)
    }
 
    public class func `where`<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> [[K:V]] {
        var result : [[K:V]] = []
        for dict in array {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                result += dict
            }
        }
        return result
    }
    
    public class func findWhere<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> [K:V]? {
        for dict in array {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                return dict
            }
        }
        return nil
    }
    
    public class func reject<T : Sequence>(seq: T, _ condition: T.GeneratorType.Element -> Bool) -> [T.GeneratorType.Element] {
        return Array(filter(seq, { !condition($0) }))
    }
    
    public class func every<L: LogicValue>(array: [L]) -> Bool {
        return __.every(array, predicate: { $0.getLogicValue() })
    }
    
    public class func every<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool ) -> Bool {
        return __.find(seq, { !predicate($0) }) ? false : true
    }
    
    // alias for every
    public class func all<L: LogicValue>(array: [L]) -> Bool {
        return __.every(array)
    }
    
    // alias for every
    public class func all<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.every(seq, predicate: predicate)
    }
    
    public class func some<L: LogicValue>(array: [L]) -> Bool {
        return __.some(array, predicate: { $0.getLogicValue() })
    }
    
    public class func some<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.find(seq, predicate ) ? true : false
    }
    
    // alias for some
    public class func any<L: LogicValue>(array: [L]) -> Bool {
        return __.some(array)
    }
    
    // alias for some
    public class func any<T : Sequence>(seq: T, predicate: T.GeneratorType.Element -> Bool) -> Bool {
        return __.some(seq, predicate: predicate)
    }
    
    public class func pluck<K, V>(array: [[K:V]], key: K) -> [V] {
        var result : [V] = []
        for item in array {
            if let value = item[key] {
                result += value
            }
        }
        return result
    }
    
    // quick sort
    public class func sortBy<T : Sequence, C: Comparable>(seq: T, transform: T.GeneratorType.Element -> C) -> [T.GeneratorType.Element] {
        
        var gen = seq.generate()
        
        if let first = gen.next() {
            
            var smaller : [T.GeneratorType.Element] = []
            var bigger  : [T.GeneratorType.Element] = []
            
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
    
    public class func groupBy<K, V>(array: [V], transform: V -> K) -> [K:[V]] {
        var result : [K:[V]] = [:]
        
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
    
    public class func indexBy<K, V>(array: [[K:V]], key: K) -> [V:[K:V]] {
        var result = [V:[K:V]]()
        for item in array {
            result[item[key]!] = item
        }
        return result
    }
    
    public class func countBy<T, U>(array: [T], transform: T -> U) -> [U:Int] {
        var result : [U:Int] = [:]
        for item in array {
            if let count = result[transform(item)] {
                result[transform(item)] = count + 1
            } else {
                result[transform(item)] = 1
            }
        }
        return result
    }
    
    public class func shuffle<T>(array: [T]) -> [T] {
        let length = array.count
        var random = Array(0..<length)
        for i in 1..<length {
            let j = Int(arc4random() % UInt32(i+1))
            swap(&random[i], &random[j])
        }
        return random.map { array[$0] }
    }
    
    public class func sample<T>(array: [T]) -> T {
        let index = Int(arc4random() % UInt32(array.count))
        return array[index]
    }
    
    public class func sample<T>(array: [T], _ n:Int) -> [T] {
        var result : [T] = []
        let random = __.shuffle(Array(0..<array.count))
        for i in 0..<n {
            result += array[random[i]]
        }
        return result
    }
    
    public class func size<T : Sequence>(seq: T) -> Int {
        var count = 0
        var gen = seq.generate()
        while gen.next() {
            count += 1
        }
        return count
    }
    
    private class func hasSubDictionary<K, V: Equatable>(dict:[K:V], subDictionary: [K:V]) -> Bool {
        let eqList = map(subDictionary) { (key: K, value: V) -> Bool in
            if let v = dict[key] {
                return v == value
            } else {
                return false
            }
        }
        
        return Array(eqList).reduce(true) { $0 && $1 }
    }
}

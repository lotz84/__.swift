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
    
    public class func each<T : SequenceType>(seq: T, _ iterator: T.Generator.Element -> Any){
        var gen = seq.generate()
        while let elem = gen.next() {
            iterator(elem)
        }
    }
    
    // alias for each
    public class func forEach<T : SequenceType>(seq: T, _ iterator: T.Generator.Element -> Any){
        __.each(seq, iterator)
    }
    
    public class func reduceRight<T : SequenceType, U>(seq: T, initial: U, combine: (T.Generator.Element, U) -> U) -> U {
        var array : [T.Generator.Element] = []
        var gen = seq.generate()
        while let elem = gen.next() {
            array.append(elem)
        }
        return array.reverse().reduce(initial, combine: { combine($1,$0) } )
    }
    
    public class func foldr<T : SequenceType, U>(seq: T, initial: U, combine: (T.Generator.Element, U) -> U) -> U {
        return __.reduceRight(seq, initial: initial, combine: combine)
    }
    
    public class func find<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool) -> T.Generator.Element? {
        var gen = seq.generate()
        while let elem = gen.next() {
            if predicate(elem) {
                return elem
            }
        }
        return nil
    }
    
    // alias for find
    public class func detect<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool) -> T.Generator.Element? {
        return __.find(seq, predicate: predicate)
    }
 
    public class func `where`<K,V: Equatable>(array: [[K:V]], _ properties: [K:V]) -> [[K:V]] {
        var result : [[K:V]] = []
        for dict in array {
            if __.hasSubDictionary(dict, subDictionary: properties) {
                result.append(dict)
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
    
    public class func reject<T : SequenceType>(seq: T, _ condition: T.Generator.Element -> Bool) -> [T.Generator.Element] {
        return Array(filter(seq, { !condition($0) }))
    }
    
    public class func every<L: BooleanType>(array: [L]) -> Bool {
        return __.every(array, predicate: { $0.boolValue })
    }
    
    public class func every<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool ) -> Bool {
        return __.find(seq, predicate: { !predicate($0) }) == nil ? true : false
    }
    
    // alias for every
    public class func all<L: BooleanType>(array: [L]) -> Bool {
        return __.every(array)
    }
    
    // alias for every
    public class func all<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool) -> Bool {
        return __.every(seq, predicate: predicate)
    }
    
    public class func some<L: BooleanType>(array: [L]) -> Bool {
        return __.some(array, predicate: { $0.boolValue })
    }
    
    public class func some<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool) -> Bool {
        return __.find(seq, predicate: predicate) == nil ? false : true
    }
    
    // alias for some
    public class func any<L: BooleanType>(array: [L]) -> Bool {
        return __.some(array)
    }
    
    // alias for some
    public class func any<T : SequenceType>(seq: T, predicate: T.Generator.Element -> Bool) -> Bool {
        return __.some(seq, predicate: predicate)
    }
    
    public class func pluck<K, V>(array: [[K:V]], key: K) -> [V] {
        var result : [V] = []
        for item in array {
            if let value = item[key] {
                result.append(value)
            }
        }
        return result
    }
    
    // quick sort
    public class func sortBy<T : SequenceType, C: Comparable>(seq: T, transform: T.Generator.Element -> C) -> [T.Generator.Element] {
        
        var gen = seq.generate()
        
        if let first = gen.next() {
            
            var smaller : [T.Generator.Element] = []
            var bigger  : [T.Generator.Element] = []
            
            while let elem = gen.next() {
                if transform(first) < transform(elem) {
                    bigger.append(elem)
                } else {
                    smaller.append(elem)
                }
            }
            
            var result = sortBy(smaller, transform: transform)
            result.append(first)
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
            result.append(array[random[i]])
        }
        return result
    }
    
    public class func size<T : SequenceType>(seq: T) -> Int {
        var count = 0
        var gen = seq.generate()
        while gen.next() != nil {
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

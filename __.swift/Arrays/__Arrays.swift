//
//  __Arrays.swift
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
    * Array Functions
    */
    
    public class func first<T>(array:[T], _ n:Int = 1) -> [T]! {
        let (first, _) = __.separate(array, array.count - n)
        return first
    }
    
    // alias for first
    public class func head<T>(array:[T], _ n:Int = 1) -> [T]! {
        return __.first(array, n)
    }
    
    // alias for first
    public class func take<T>(array:[T], _ n:Int = 1) -> [T]! {
        return __.first(array, n)
    }
    
    // Abount initial and last functions
    // when n > 1
    // array == __.initial(array, n) + __.last(array, n)
    
    public class func initial<T>(array:[T], _ n: Int = 1) -> [T] {
        let (initial, _) = __.separate(array, n)
        return initial
    }
    
    public class func last<T>(array: [T], _ n: Int = 1) -> [T] {
        let (_, last) = __.separate(array, n)
        return last
    }
    
    public class func rest<T>(array: [T], _ n: Int = 1) -> [T] {
        let (_, rest) = __.separate(array, array.count - n)
        return rest
    }
    
    // alias for rest method
    public class func tail<T>(array: [T], _ n: Int = 1) -> [T] {
        return __.rest(array, n)
    }
    
    // alias for rest method
    public class func drop<T>(array: [T], _ n: Int = 1) -> [T] {
        return __.rest(array, n)
    }
    
    private class func separate<T>(array: [T], _ n: Int) -> ([T], [T]) {
        if n < 1 { return (array, []) }
        
        let length = array.count
        if length < 2 { return (array, []) }
        if n >= length { return ([], array) }
        
        var initial : [T] = []
        var last    : [T] = []
        for i in 0..<length {
            if i < length-n {
                initial.append(array[i])
            } else {
                last.append(array[i])
            }
        }
        return (initial, last)
    }
    
    public class func compact<T : BooleanType>(array: [T]) -> [T] {
        let validator = array.map {
            $0.boolValue
        }
        var result : [T] = []
        for (index, item) in enumerate(array) {
            if validator[index] {
                result.append(item)
            }
        }
        return result
    }
    
    public class func flatten<T>(array: [[T]]) -> [T] {
        var result : [T] = []
        for item in array {
            result += item
        }
        return result
    }
    
    public class func without<T: Equatable>(array: [T], values: T...) -> [T] {
        return array.filter {
            !contains(values, $0)
        }
    }
    
    public class func partition<T>(array: [T], predicate: T -> Bool ) -> ([T], [T]) {
        var result = (filtered: [T](), rejected: [T]())
        for item in array {
            if predicate(item) {
                result.filtered.append(item)
            } else {
                result.rejected.append(item)
            }
        }
        return result
    }
    
    public class func union<T : Equatable>(arrays: [T]...) -> [T] {
        return __.uniq(__.flatten(arrays))
    }
    
    public class func intersection<T : Equatable>(arrays: [T]...) -> [T] {
        if arrays.isEmpty { return [] }
        
        var sorted = arrays
        sorted.sort { $0.count < $1.count }
        
        let length = sorted.count
        
        var result = arrays[0]
        
        for index in 1..<length {
            var removeList : [Int] = []
            for (index,item) in enumerate(result) {
                if !contains(sorted[index], item){
                    removeList.append(index)
                }
            }
            let reversedRemoveList = removeList.reverse()
            for index in reversedRemoveList {
                result.removeAtIndex(index)
            }
        }
        return result
    }
    
    public class func difference<T: Equatable>(array: [T], others: [T]...) -> [T] {
        var result = array
        
        for other in others {
            var removeList : [Int] = []
            for (index,item) in enumerate(result) {
                if contains(other, item) {
                    removeList.append(index)
                }
            }
            let reversedRemoveList = removeList.reverse()
            for index in reversedRemoveList {
                result.removeAtIndex(index)
            }
        }
        
        return result
    }
    
    public class func uniq<T : Equatable>(array: [T], isSorted: Bool = false) -> [T] {
        return __.uniq(array, isSorted: isSorted) { $0 }
    }
    
    public class func uniq<T, U : Equatable>(array: [T], isSorted: Bool, transform: T -> U) -> [T] {
        if array.isEmpty { return [] }
        
        var result : [T] = []
        if isSorted {
            result.append(array.first!)
            for item in array {
                if transform(result.last!) != transform(item) {
                    result.append(item)
                }
            }
        } else {
            var seen : [U] = []
            for item in array {
                let transformed = transform(item)
                if !contains(seen, transformed) {
                    result.append(item)
                    seen.append(transformed)
                }
            }
        }
        return result
    }
    
    public class func zip<T, U>(array0: [T], _ array1: [U]) -> [(T, U)] {
        let length: Int = min(array0.count, array1.count)
        
        var result : [(T, U)] = []

        for i in 0..<length {
            result.append(array0[i], array1[i])
        }
        
        return result
    }
    
    public class func object<K : Hashable, V>(#keys: [K], values:[V] ) -> [K:V] {
        var result : [K:V] = [:]
        let length: Int = min(keys.count, values.count)
        for i in 0..<length {
            result[keys[i]] = values[i]
        }
        return result
    }
    
    public class func object<K : Hashable, V>(keyAndValues: [(K, V)]) -> [K:V] {
        var result : [K:V] = [:]
        for item in keyAndValues {
            result[item.0] = item.1
        }
        return result
    }
    
    public class func indexOf<T: Equatable>(array: [T], value:T) -> Int? {
        for (index, item) in enumerate(array) {
            if item == value { return index }
        }
        return nil
    }
    
    public class func indexOf<T: Comparable>(array: [T], value:T, isSorted: Bool) -> Int? {
        if isSorted {
            return __.sortedIndex(array, value: value) { $0 }
        } else {
            for (index, item) in enumerate(array) {
                if item == value { return index }
            }
        }
        return nil
    }
    
    public class func lastIndexOf<T : Equatable>(array : [T], value: T) -> Int? {
        let length = array.count - 1
        return __.lastIndexOf(array, value: value, from: length)
    }
    
    public class func lastIndexOf<T : Equatable>(array : [T], value: T, from: Int) -> Int? {
        for index in stride(from: from, through: 0, by: -1) {
            if array[index] == value {
                return index
            }
        }
        return nil
    }
    
    public class func sortedIndex<T, U : Comparable>(array : [T], value : T, transform: T -> U ) -> Int? {
        let target = transform(value)
        var low  = 0
        var high = array.count-1
        while low < high {
            let mid = (low + high) / 2
            if target > transform(array[mid]) {
                low = mid + 1
            } else {
                high = mid
            }
        }
        if target == transform(array[low]) {
            return low
        }
        return nil
    }
    
    public class func range(stop: Int) -> [Int] {
        return Array(0..<stop)
    }
}
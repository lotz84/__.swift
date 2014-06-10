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

extension __ {
    
    /**
    * Array Functions
    */
    
    class func first<T>(list:T[]) -> T! {
        if list.isEmpty { return nil }
        return list[0]
    }
    
    // alias for first
    class func head<T>(list:T[]) -> T! {
        return __.first(list)
    }
    
    // alias for first
    class func take<T>(list:T[]) -> T! {
        return __.first(list)
    }
    
    class func first<T>(list:T[], _ n:Int) -> T[]! {
        let (first, _) = __.separate(list, list.count - n)
        return first
    }
    
    // alias for first
    class func head<T>(list:T[], _ n:Int) -> T[]! {
        return __.first(list, n)
    }
    
    // alias for first
    class func take<T>(list:T[], _ n:Int) -> T[]! {
        return __.first(list, n)
    }
    
    // Abount initial and last functions
    // when n > 1
    // list == __.initial(list, n) + __.last(list, n)
    
    class func initial<T>(list:T[], _ n: Int = 1) -> T[] {
        let (initial, _) = __.separate(list, n)
        return initial
    }
    
    class func last<T>(list: T[]) -> T {
        return __.last(list, 1)[0]
    }
    
    class func last<T>(list: T[], _ n: Int) -> T[] {
        let (_, last) = __.separate(list, n)
        return last
    }
    
    class func rest<T>(list: T[], _ n: Int = 1) -> T[] {
        let (_, rest) = __.separate(list, list.count - n)
        return rest
    }
    
    // alias for rest method
    class func tail<T>(list: T[], _ n: Int = 1) -> T[] {
        return __.rest(list, n)
    }
    
    // alias for rest method
    class func drop<T>(list: T[], _ n: Int = 1) -> T[] {
        return __.rest(list, n)
    }
    
    class func separate<T>(list: T[], _ n: Int) -> (T[], T[]) {
        if n < 1 { return (list, []) }
        
        let length = list.count
        if length < 2 { return (list, []) }
        if n >= length { return ([], list) }
        
        var initial = T[]()
        var last    = T[]()
        for i in 0..length {
            if i < length-n {
                initial += list[i]
            } else {
                last    += list[i]
            }
        }
        return (initial, last)
    }
    
    class func compact<T : LogicValue>(list: Array<T>) -> Array<T> {
        let validator = __.map(list){
            $0.getLogicValue()
        }
        var result = Array<T>()
        for (index, item) in enumerate(list) {
            if validator[index] {
                result += item
            }
        }
        return result
    }
    
    class func flatten<T>(list: Array<Array<T>>) -> Array<T> {
        var result = Array<T>()
        for item in list {
            result += item
        }
        return result
    }
    
    class func without<T: Equatable>(list: Array<T>, values: T...) -> Array<T> {
        return list.filter {
            !__.contains(values, value: $0)
        }
    }
    
    class func partition<T>(list: Array<T>, condition: T -> Bool ) -> (Array<T>, Array<T>) {
        var result = (filtered: Array<T>(), rejected: Array<T>())
        for item in list {
            if condition(item) {
                result.filtered += item
            } else {
                result.rejected += item
            }
        }
        return result
    }
    
    class func zip<T, U>(list0: T[], _ list1: U[]) -> (T, U)[] {
        let length: Int = __.min(list0.count, list1.count)
        
        var result = Array<(T, U)>()

        for i in 0..length {
            result += (list0[i], list1[i])
        }
        
        return result
    }
    
    class func object<K : Hashable, V>(#keys: Array<K>, values:Array<V> ) -> Dictionary<K, V> {
        var result = Dictionary<K,V>()
        let length: Int = __.min(keys.count, values.count)
        for i in 0..length {
            result[keys[i]] = values[i]
        }
        return result
    }
    
    class func object<K : Hashable, V>(keyAndValues: Array<(K, V)>) -> Dictionary<K, V> {
        var result = Dictionary<K,V>()
        for item in keyAndValues {
            result[item.0] = item.1
        }
        return result
    }
    
    class func indexOf<T: Equatable>(array: Array<T>, value:T) -> Int? {
        for (index, item) in enumerate(array) {
            if item == value { return index }
        }
        return nil
    }
    
    class func indexOf<T: Comparable>(array: Array<T>, value:T, isSorted: Bool) -> Int? {
        if isSorted {
            return __.sortedIndex(array, value: value, transform: __.identity)
        } else {
            for (index, item) in enumerate(array) {
                if item == value { return index }
            }
        }
        return nil
    }
    
    class func lastIndexOf<T : Equatable>(array : Array<T>, value: T) -> Int? {
        let length = array.count - 1
        return __.lastIndexOf(array, value: value, from: length)
    }
    
    class func lastIndexOf<T : Equatable>(array : Array<T>, value: T, from: Int) -> Int? {
        for index in __.range(start:from, stop: 0, step: -1) {
            if array[index] == value {
                return index
            }
        }
        return nil
    }
    
    class func sortedIndex<T, U : Comparable>(array : Array<T>, value : T, transform: T -> U ) -> Int? {
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
    
    class func range(stop: Int) -> Array<Int> {
        return Array(0..stop)
    }
    
    class func range(#start: Int, stop: Int) -> Array<Int> {
        if start > stop {
            return __.range(start: start, stop: stop, step: -1)
        }
        return Array(start..stop)
    }
    
    class func range(#start: Int, stop: Int, step: Int) -> Array<Int> {
        if step > 0 ? start > stop : start < stop { return [] }
        var result = Array<Int>()
        var temp = start
        while step < 0 ? temp > stop : temp < stop {
            result += temp
            temp += step
        }
        return result
    }
}
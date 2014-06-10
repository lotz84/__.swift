//
//  __Arrays.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/07.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
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
        return self.first(list)
    }
    
    // alias for first
    class func take<T>(list:T[]) -> T! {
        return self.first(list)
    }
    
    class func first<T>(list:T[], _ n:Int) -> T[]! {
        if list.isEmpty { return nil }
        var result = T[]()
        for i in 0..n {
            result += list[i]
        }
        return result
    }
    
    // alias for first
    class func head<T>(list:T[], _ n:Int) -> T[]! {
        return self.first(list, n)
    }
    
    // alias for first
    class func take<T>(list:T[], _ n:Int) -> T[]! {
        return self.first(list, n)
    }
    
    // Abount initial and last functions
    // when n > 1
    // list == __.initial(list, n) + __.last(list, n)
    
    class func initial<T>(list:T[], _ n: Int = 1) -> T[] {
        let (initial, last) = __.separate(list, n)
        return initial
    }
    
    class func last<T>(list: T[]) -> T {
        return __.last(list, 1)[0]
    }
    
    class func last<T>(list: T[], _ n: Int) -> T[] {
        let (initial, last) = __.separate(list, n)
        return last
    }
    
    class func rest<T>(list: T[], _ n: Int = 1) -> T[] {
        let length = list.count
        let (initial, rest) = __.separate(list, length-n)
        return rest
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
    
    class func zip<T, U>(list0: T[], _ list1: U[]) -> (T, U)[] {
        let length: Int = __.min(list0.count, list1.count)
        
        var result = Array<(T, U)>()

        for i in 0..length {
            result += (list0[i], list1[i])
        }
        
        return result
    }
    
}
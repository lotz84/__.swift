//
//  __.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/03.
//  Copyright (c) 2014 tatsuya hirose. All rights reserved.
//

import Foundation

class __ {

    class func each <ItemType>(list: ItemType[], iterator: ItemType -> Any)  {
        list.map { iterator($0) }
    }
    
    // alias for each
    class func forEach <ItemType>(list: ItemType[], iterator: ItemType -> Any) {
        self.each(list, iterator: iterator)
    }
    
    class func map <ItemType, resultType>(list: ItemType[], iterator: ItemType -> resultType) -> resultType[] {
        return list.map { iterator($0) }
    }
    
    // alias for map
    class func collect <ItemType, resultType>(list: ItemType[], iterator: ItemType -> resultType) -> resultType[] {
        return self.map(list, iterator: iterator)
    }
    
    class func reduce <ItemType, ResultType>(list: ItemType[], memo: ResultType, iterator: (first:ResultType, second:ItemType) -> ResultType) -> ResultType {
        
        var result = memo
        
        self.each(list) {
            result = iterator(first: result, second: $0)
        }
        
        return result
    }
    
    // alias for reduce
    class func inject <ItemType, ResultType>(list: ItemType[], memo: ResultType, iterator: (first:ResultType, second:ItemType) -> ResultType) -> ResultType {
        return self.reduce(list, memo: memo, iterator: iterator)
    }
    
    // alias for reduce
    class func foldl <ItemType, ResultType>(list: ItemType[], memo: ResultType, iterator: (first:ResultType, second:ItemType) -> ResultType) -> ResultType {
        return self.reduce(list, memo: memo, iterator: iterator)
    }
    
    class func find <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType? {
        for item in list {
            if filter(item) {
                return item
            }
        }
        return nil
    }
    
    // alias for find
    class func detect <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType? {
        return self.find(list, filter: filter)
    }
    
    
    class func filter <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType[] {
        var result = ItemType[]()
        for item in list {
            if filter(item) {
                result += item
            }
        }
        return result
    }

    // alias for filter
    class func select <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType[] {
        return self.filter(list, filter: filter)
    }
    
    class func reject<ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType[] {
        
        // I tried to compose ! and filter directly
        // but I have no idea do it exactly

        func notFilter(item: ItemType) -> Bool {
            return !filter(item)
        }
        
        return self.filter(list, notFilter)
    }
    
    /*
        Maybe every and some can be written by already existing function.
        But I think it is faster to use short-circuit evaluation by for-in loop
    */
    
    class func every(list: Bool[]) -> Bool {
        for item in list {
            if !item {
                return false
            }
        }
        return true
    }
    
    // alias for every
    class func all(list: Bool[]) -> Bool {
        return self.every(list)
    }

    class func some(list: Bool[]) -> Bool {
        for item in list {
            if item {
                return true
            }
        }
        return false
    }
    
    // alias for any
    class func any(list: Bool[]) -> Bool {
        return self.some(list)
    }
    
    // Simple linear search
    class func contains <ItemType: Equatable>(list: ItemType[], value: ItemType) -> Bool {
        for item in list {
            if item == value {
                return true
            }
        }
        return false
    }
    
    // alias for contains
    class func include <ItemType: Equatable>(list: ItemType[], value: ItemType) -> Bool {
        return self.contains(list, value: value);
    }
    
    class func pluck<KeyType: Equatable, ValueType>(list: Array<Dictionary<KeyType, ValueType>>, key: KeyType) -> ValueType[] {
        var result = ValueType[]()
        for item in list {
            if let value = item[key] {
                result += value
            }
        }
        return result
    }
    
    class func max<ItemType: Comparable>(list: ItemType[]) -> ItemType! {
        return self.tournament(list, comparator: {$0 < $1 } )
    }
    
    class func min<ItemType: Comparable>(list: ItemType[]) -> ItemType! {
        return self.tournament(list, comparator: {$0 > $1 } )
    }
    
    // This function is used in max and min function
    // Since max and min function pass the test, we decide tournament function is work correctly
    class func tournament<ItemType: Comparable>(list: ItemType[], comparator: (ItemType, ItemType) -> Bool) -> ItemType! {
        if list.isEmpty { return nil }
        var candidate = list[0]
        for item in list {
            if comparator(candidate,item) {
                candidate = item
            }
        }
        return candidate
    }
    
    // quick sort
    class func sortBy<ItemType, CompareType: Comparable>(list: ItemType[], iterator: ItemType -> CompareType) -> ItemType[] {
        if list.isEmpty { return [] }
        
        var smaller = ItemType[]()
        var bigger = ItemType[]()
        
        let first = list[0]
        let length = list.count
        
        for i in 1..length {
            if iterator(first) < iterator(list[i]) {
                bigger += list[i]
            } else {
                smaller += list[i]
            }
        }
        
        var result = sortBy(smaller, iterator: iterator)
        result += first
        result += sortBy(bigger, iterator: iterator)
        
        return result
    }
    
    class func groupBy<ItemType, EquitableType: Equatable>(list: ItemType[], iterator: ItemType -> EquitableType) -> Dictionary<EquitableType, ItemType[]> {
        var result = Dictionary<EquitableType, ItemType[]>()
        
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
    
    class func indexBy<KeyType, ValueType>(list: Array<Dictionary<KeyType, ValueType>>, key: KeyType) -> Dictionary<ValueType,(Dictionary<KeyType,ValueType>)> {
        var result = Dictionary<ValueType, (Dictionary<KeyType,ValueType>)>()
        for item in list {
            result[item[key]!] = item
        }
        return result
    }
    
    class func countBy<ItemType, NameType>(list: ItemType[], iterator: ItemType -> NameType) -> Dictionary<NameType, Int> {
        var result = Dictionary<NameType, Int>()
        for item in list {
            if let count = result[iterator(item)] {
                result[iterator(item)] = count + 1
            } else {
                result[iterator(item)] = 1
            }
        }
        return result
    }
    
    class func shuffle<ItemType>(list: ItemType[]) -> ItemType[] {
        let length = list.count
        var random = Int[]()
        while random.count < length {
            let index: Int = Int(arc4random() % UInt32(length))
            if !self.contains(random, value: index) {
                random += index
            }
        }
        return self.map(random, iterator: {index in list[index]})
    }
    
    class func sample<ItemType>(list: ItemType[]) -> ItemType {
        let index = Int(arc4random() % UInt32(list.count))
        return list[index]
    }
    
    class func sample<ItemType>(list: ItemType[], n:Int) -> ItemType[] {
        var result = ItemType[]()
        let random = self.shuffle(Array(0..list.count))
        for i in 0..n {
            result += list[random[i]]
        }
        return result
    }
    
    class func size<ItemType>(list: ItemType[]) -> Int {
        return list.count
    }
    
    class func size<KeyType, ValueType>(dict: Dictionary<KeyType,ValueType>) -> Int {
        return Array(dict.keys).count
    }
}

//
//  __.swift
//  __.swift
//
//  Created by Hirose Tatsuya on 2014/06/03.
//  Copyright (c) 2014年 tatsuya hirose. All rights reserved.
//

import Foundation

class __ {

    class func each<ItemType>(list: ItemType[], iterator: ItemType -> Any)  {
        list.map {
            item in
            iterator(item)
        }
    }
    
    class func map <ItemType, resultType>(list: ItemType[], iterator: ItemType -> resultType) -> resultType[] {
        return list.map({
                item in
                iterator(item)
            })
    }
    
    class func reduce <ItemType, resultType>(list: ItemType[], iterator: (first:resultType, second:ItemType) -> resultType, memo:resultType) -> resultType{
    
        var result = memo;
        
        self.each(list, {
            item in
            result = iterator(first: result, second: item)
        })
        
        return result;
    }
    
    class func find <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType? {
        for item in list {
            if filter(item) {
                return item
            }
        }
        return nil;
    }
    
    class func filter <ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType[] {
        var result = ItemType[]()
        for item in list {
            if filter(item) {
                result.append(item)
            }
        }
        return result;
    }

    class func reject<ItemType>(list: ItemType[], filter: ItemType -> Bool) -> ItemType[] {
        var result = ItemType[]()
        for item in list {
            if !filter(item) {
                result.append(item)
            }
        }
        return result;
    }
    
    class func every(list: Bool[]) -> Bool {
        for item in list {
            if !item {
                return false
            }
        }
        return true
    }
    
    class func some(list: Bool[]) -> Bool {
        for item in list {
            if item {
                return true
            }
        }
        return false
    }
    
    class func contains<ItemType: Equatable>(list: ItemType[], value: ItemType) -> Bool {
        var flag: Bool = false;
        for item in list {
            flag = flag || (item == value)
        }
        return flag
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

}

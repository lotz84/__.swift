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
    
}

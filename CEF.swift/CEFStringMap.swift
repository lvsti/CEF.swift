//
//  CEFStringMap.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringMapToSwiftDictionary(cefMap: cef_string_map_t) -> [String:String] {
    guard cefMap != nil else {
        return [:]
    }
    
    let count = cef_string_map_size(cefMap)
    var cefKey = cef_string_t()
    var cefValue = cef_string_t()
    var map = [String:String]()
    
    for i in 0..<count {
        cef_string_map_key(cefMap, i, &cefKey)
        cef_string_map_value(cefMap, i, &cefValue)
        
        let key = CEFStringToSwiftString(cefKey)
        let value = CEFStringToSwiftString(cefValue)
        
        map[key] = value
    }

    return map
}

func CEFStringMapFromSwiftDictionary(dictionary: [String:String]) -> cef_string_map_t {
    let cefMap = cef_string_map_alloc()
    
    for (key, value) in dictionary {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        let cefValuePtr = CEFStringPtrFromSwiftString(value)

        cef_string_map_append(cefMap, cefKeyPtr, cefValuePtr)

        cef_string_userfree_utf16_free(cefKeyPtr)
        cef_string_userfree_utf16_free(cefValuePtr)
    }
    
    return cefMap
}

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

func CEFStringMapCreateFromSwiftDictionary(dictionary: [String:String]) -> cef_string_map_t {
    let cefMap = cef_string_map_alloc()
    
    var cefKey = cef_string_t()
    var cefValue = cef_string_t()
    defer {
        cef_string_utf16_clear(&cefKey)
        cef_string_utf16_clear(&cefValue)
    }

    for (key, value) in dictionary {
        CEFStringSetFromSwiftString(key, cefString: &cefKey)
        CEFStringSetFromSwiftString(value, cefString: &cefValue)

        cef_string_map_append(cefMap, &cefKey, &cefValue)
    }
    
    return cefMap
}

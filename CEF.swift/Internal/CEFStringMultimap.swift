//
//  CEFStringMultimap.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringMultimapToSwiftDictionaryOfArrays(_ cefMultimap: cef_string_multimap_t) -> [String: [String]] {
    guard cefMultimap != nil else {
        return [:]
    }
    
    let count = cef_string_multimap_size(cefMultimap)
    var cefKey = cef_string_t()
    var cefValue = cef_string_t()
    var multimap = [String: [String]]()
    
    for i in 0..<count {
        cef_string_multimap_key(cefMultimap, i, &cefKey)
        cef_string_multimap_value(cefMultimap, i, &cefValue)
        
        let key = CEFStringToSwiftString(cefKey)
        let value = CEFStringToSwiftString(cefValue)
        
        if multimap[key] != nil {
            multimap[key]!.append(value)
        } else {
            multimap[key] = [value]
        }
    }

    return multimap
}

func CEFStringMultimapCreateFromSwiftDictionaryOfArrays(_ dictionary: [String: [String]]) -> cef_string_multimap_t {
    let multimap = cef_string_multimap_alloc()
    
    var cefKey = cef_string_t()
    var cefValue = cef_string_t()
    defer {
        cef_string_utf16_clear(&cefKey)
        cef_string_utf16_clear(&cefValue)
    }
    
    for (key, values) in dictionary {
        CEFStringSetFromSwiftString(key, cefString: &cefKey)
        for value in values {
            CEFStringSetFromSwiftString(value, cefString: &cefValue)
            cef_string_multimap_append(multimap, &cefKey, &cefValue)
        }
    }
    
    return multimap
}

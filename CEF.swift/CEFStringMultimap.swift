//
//  CEFStringMultimap.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringMultimapToSwiftDictionaryOfArrays(cefMultimap: cef_string_multimap_t) -> [String: [String]] {
    guard cefMultimap != nil else {
        return [:]
    }
    
    let count = cef_string_multimap_size(cefMultimap)
    let cefKeyPtr = UnsafeMutablePointer<cef_string_t>.alloc(1)
    let cefValuePtr = UnsafeMutablePointer<cef_string_t>.alloc(1)
    var multimap = [String: [String]]()
    
    for i in 0..<count {
        cef_string_multimap_key(cefMultimap, i, cefKeyPtr)
        cef_string_multimap_value(cefMultimap, i, cefValuePtr)
        
        let key = CEFStringToSwiftString(cefKeyPtr.memory)
        let value = CEFStringToSwiftString(cefValuePtr.memory)
        
        if multimap[key] != nil {
            multimap[key]!.append(value)
        } else {
            multimap[key] = [value]
        }
    }

    cefKeyPtr.dealloc(1)
    cefValuePtr.dealloc(1)

    return multimap
}

func CEFStringMultimapFromSwiftDictionaryOfArrays(dictionary: [String: [String]]) -> cef_string_multimap_t {
    let multimap = cef_string_multimap_alloc()
    
    for (key, values) in dictionary {
        let cefKeyPtr = CEFStringPtrFromSwiftString(key)
        for value in values {
            let cefValuePtr = CEFStringPtrFromSwiftString(value)
            cef_string_multimap_append(multimap, cefKeyPtr, cefValuePtr)
            cef_string_userfree_utf16_free(cefValuePtr)
        }
        cef_string_userfree_utf16_free(cefKeyPtr)
    }
    
    return multimap
}

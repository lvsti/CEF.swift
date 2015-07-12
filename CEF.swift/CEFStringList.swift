//
//  CEFStringList.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringListFromSwiftArray(array: [String]) -> cef_string_list_t {
    let cefList = cef_string_list_alloc()
    
    for item in array {
        let cefStrPtr = CEFStringPtrFromSwiftString(item)
        cef_string_list_append(cefList, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    return cefList
}

func CEFStringListToSwiftArray(cefList: cef_string_list_t) -> [String] {
    let count = cef_string_list_size(cefList)
    let cefStrPtr = cef_string_userfree_utf16_alloc()
    var list = [String]()
    
    for i in 0..<count {
        cef_string_list_value(cefList, i, cefStrPtr)
        list.append(CEFStringToSwiftString(cefStrPtr.memory))
    }
    cef_string_userfree_utf16_free(cefStrPtr)
    
    return list
}



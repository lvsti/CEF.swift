//
//  CEFStringList.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

func CEFStringListCreateFromSwiftArray(_ array: [String]) -> cef_string_list_t! {
    let cefList = cef_string_list_alloc()!
    
    var cefStr = cef_string_t()
    defer { cef_string_utf16_clear(&cefStr) }
    
    for item in array {
        CEFStringSetFromSwiftString(item, cefStringPtr: &cefStr)
        cef_string_list_append(cefList, &cefStr)
    }
    
    return cefList
}

func CEFStringListRelease(_ cefList: cef_string_list_t?) {
    if let cefList = cefList {
        cef_string_list_free(cefList)
    }
}

func CEFStringListToSwiftArray(_ cefList: cef_string_list_t) -> [String] {
    let count = cef_string_list_size(cefList)
    var cefStr = cef_string_t()
    var list = [String]()
    
    for i in 0..<count {
        cef_string_list_value(cefList, i, &cefStr)
        list.append(CEFStringToSwiftString(cefStr))
    }
    
    return list
}



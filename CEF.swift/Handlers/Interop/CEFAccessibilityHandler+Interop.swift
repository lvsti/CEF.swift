//
//  CEFAccessibilityHandler+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 06. 11..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFAccessibilityHandler_on_accessibility_tree_change(ptr: UnsafeMutablePointer<cef_accessibility_handler_t>?,
                                                          value: UnsafeMutablePointer<cef_value_t>?) {
    guard let obj = CEFAccessibilityHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAccessibilityTreeChange(value: CEFValue.fromCEF(value)!)
}

func CEFAccessibilityHandler_on_accessibility_location_change(ptr: UnsafeMutablePointer<cef_accessibility_handler_t>?,
                                                              value: UnsafeMutablePointer<cef_value_t>?) {
    guard let obj = CEFAccessibilityHandlerMarshaller.get(ptr) else {
        return
    }
    
    obj.onAccessibilityLocationChange(value: CEFValue.fromCEF(value)!)
}

//
//  ResourceBundleHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func ResourceBundleHandler_get_localized_string(ptr: UnsafeMutablePointer<cef_resource_bundle_handler_t>,
                                                stringID: Int32,
                                                cefStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let obj = ResourceBundleHandlerMarshaller.get(ptr) else {
        return 0
    }
                                                    
    if let str = obj.localizedStringForID(Int(stringID)) {
        CEFStringSetFromSwiftString(str, cefString: cefStrPtr)
        return 1
    }
    
    return 0
}

func ResourceBundleHandler_get_data_resource(ptr: UnsafeMutablePointer<cef_resource_bundle_handler_t>,
                                             resourceID: Int32,
                                             dataBufferPtr: UnsafeMutablePointer<UnsafeMutablePointer<Void>>,
                                             dataSizePtr: UnsafeMutablePointer<size_t>) -> Int32 {
    guard let obj = ResourceBundleHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    if let (bufferPtr, size) = obj.dataResourceForID(Int(resourceID)) {
        dataBufferPtr.memory = bufferPtr
        dataSizePtr.memory = size
        return 1
    }
    
    return 0
}


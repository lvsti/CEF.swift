//
//  CEFResourceBundleHandler.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 30..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResourceBundleHandler_get_localized_string(ptr: UnsafeMutablePointer<cef_resource_bundle_handler_t>?,
                                                   stringID: Int32,
                                                   cefStrPtr: UnsafeMutablePointer<cef_string_t>?) -> Int32 {
    guard let obj = CEFResourceBundleHandlerMarshaller.get(ptr) else {
        return 0
    }
                                                    
    if let str = obj.localizedStringForID(stringID: Int(stringID)) {
        CEFStringSetFromSwiftString(str, cefStringPtr: cefStrPtr!)
        return 1
    }
    
    return 0
}

func CEFResourceBundleHandler_get_data_resource(ptr: UnsafeMutablePointer<cef_resource_bundle_handler_t>?,
                                                resourceID: Int32,
                                                dataBufferPtr: UnsafeMutablePointer<UnsafeMutableRawPointer?>?,
                                                dataSizePtr: UnsafeMutablePointer<size_t>?) -> Int32 {
    guard let obj = CEFResourceBundleHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    if let (bufferPtr, size) = obj.dataResourceForID(resourceID: Int(resourceID)) {
        dataBufferPtr!.pointee = bufferPtr
        dataSizePtr!.pointee = size
        return 1
    }
    
    return 0
}

func CEFResourceBundleHandler_get_data_resource_for_scale(ptr: UnsafeMutablePointer<cef_resource_bundle_handler_t>?,
                                                          resourceID: Int32,
                                                          scaleFactor: cef_scale_factor_t,
                                                          dataBufferPtr: UnsafeMutablePointer<UnsafeMutableRawPointer?>?,
                                                          dataSizePtr: UnsafeMutablePointer<size_t>?) -> Int32 {
    guard let obj = CEFResourceBundleHandlerMarshaller.get(ptr) else {
        return 0
    }
    
    if let (bufferPtr, size) = obj.dataResourceForID(resourceID: Int(resourceID), scale: CEFScaleFactor.fromCEF(scaleFactor)) {
        dataBufferPtr!.pointee = bufferPtr
        dataSizePtr!.pointee = size
        return 1
    }
    
    return 0
}


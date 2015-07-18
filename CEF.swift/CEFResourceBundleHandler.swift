//
//  CEFResourceBundleHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_resource_bundle_handler_t: CEFObject {
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

class CEFResourceBundleHandler: CEFHandlerBase<cef_resource_bundle_handler_t>, CEFObjectLookup {
    typealias SelfType = CEFResourceBundleHandler
    
    static var _registryMutex = pthread_mutex_t()
    static var _registry = Dictionary<ObjectPtrType, SelfType>()
    
    init?() {
        let handler = ObjectPtrType.alloc(1)
        handler.memory.base.add_ref = CEFResourceBundleHandler_addRef
        handler.memory.base.release = CEFResourceBundleHandler_release
        handler.memory.base.has_one_ref = CEFResourceBundleHandler_hasOneRef
        handler.memory.get_localized_string = CEFResourceBundleHandler_getLocalizedString
        handler.memory.get_data_resource = CEFResourceBundleHandler_getDataResource
        
        super.init(ptr: handler)
    }
    
    func getLocalizedString(stringID: Int) -> String? {
        return nil
    }
    
    func getDataResource(resourceID: Int) -> (dataBufferPtr: UnsafeMutablePointer<Void>, dataSize: size_t)? {
        return nil
    }
    
}


func CEFResourceBundleHandler_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let wrapper = CEFResourceBundleHandler.lookup(CEFResourceBundleHandler.ObjectPtrType(ptr)) else {
        return
    }
    
    wrapper.addRef()
}

func CEFResourceBundleHandler_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFResourceBundleHandler.lookup(CEFResourceBundleHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.release() ? 1 : 0
}

func CEFResourceBundleHandler_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let wrapper = CEFResourceBundleHandler.lookup(CEFResourceBundleHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    return wrapper.hasOneRef() ? 1 : 0
}

func CEFResourceBundleHandler_getLocalizedString(ptr: CEFResourceBundleHandler.ObjectPtrType,
                                                 stringID: Int32,
                                                 cefStrPtr: UnsafeMutablePointer<cef_string_t>) -> Int32 {
    guard let wrapper = CEFResourceBundleHandler.lookup(CEFResourceBundleHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    if let str = wrapper.getLocalizedString(Int(stringID)) {
        CEFStringSetFromSwiftString(str, cefString: cefStrPtr)
        return 1
    }
    
    return 0
}

func CEFResourceBundleHandler_getDataResource(ptr: CEFResourceBundleHandler.ObjectPtrType,
                                              resourceID: Int32,
                                              dataBufferPtr: UnsafeMutablePointer<UnsafeMutablePointer<Void>>,
                                              dataSizePtr: UnsafeMutablePointer<size_t>) -> Int32 {
    guard let wrapper = CEFResourceBundleHandler.lookup(CEFResourceBundleHandler.ObjectPtrType(ptr)) else {
        return 0
    }
    
    if let (bufferPtr, size) = wrapper.getDataResource(Int(resourceID)) {
        dataBufferPtr.memory = bufferPtr
        dataSizePtr.memory = size
        return 1
    }
    
    return 0
}


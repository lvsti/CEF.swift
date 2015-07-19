//
//  CEFBinaryValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


extension cef_binary_value_t: CEFObject {
}

class CEFBinaryValue: CEFProxyBase<cef_binary_value_t> {
    
    init?(data: UnsafePointer<Void>, size: size_t) {
        super.init(ptr: cef_binary_value_create(data, size))
    }
    
    func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    func isOwned() -> Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }
    
    func isSame(other: CEFBinaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    func isEqual(other: CEFBinaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }
    
    func copy() -> CEFBinaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFBinaryValue.fromCEF(copiedObj)
    }
    
    func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }
    
    func getData(buffer: UnsafeMutablePointer<Void>, size: size_t, offset: size_t) -> size_t {
        return cefObject.get_data(cefObjectPtr, buffer, size, offset)
    }
    
}


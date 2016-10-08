//
//  CEFBinaryValue.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


public extension CEFBinaryValue {
    
    /// Creates a new object that is not owned by any other object. The specified
    /// |data| will be copied.
    /// CEF name: `Create`
    public convenience init?(data: UnsafeRawPointer, size: size_t) {
        self.init(ptr: cef_binary_value_create(data, size))
    }
    
    /// Returns true if this object is valid. This object may become invalid if
    /// the underlying data is owned by another object (e.g. list or dictionary)
    /// and that other object is then modified or destroyed. Do not call any other
    /// methods if this method returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    /// Returns true if this object is currently owned by another object.
    /// CEF name: `IsOwned`
    public var isOwned: Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data.
    /// CEF name: `IsSame`
    public func isSameAs(_ other: CEFBinaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    /// CEF name: `IsEqual`
    public func isEqual(to other: CEFBinaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns a copy of this object. The data in this object will also be copied.
    /// CEF name: `Copy`
    public func copy() -> CEFBinaryValue? {
        if let copiedObj = cefObject.copy(cefObjectPtr) {
            return CEFBinaryValue.fromCEF(copiedObj)
        }
        return nil
    }
    
    /// Returns the data size.
    /// CEF name: `GetSize`
    public var length: size_t {
        return cefObject.get_size(cefObjectPtr)
    }
    
    /// Read up to |buffer_size| number of bytes into |buffer|. Reading begins at
    /// the specified byte |data_offset|. Returns the number of bytes read.
    /// CEF name: `GetData`
    public func getData(buffer: UnsafeMutableRawPointer, size: size_t, offset: size_t) -> size_t {
        return cefObject.get_data(cefObjectPtr, buffer, size, offset)
    }
    
}


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

/// Class representing a binary value. Can be used on any process and thread.
public class CEFBinaryValue: CEFProxy<cef_binary_value_t> {
    
    /// Creates a new object that is not owned by any other object. The specified
    /// |data| will be copied.
    public init?(data: UnsafePointer<Void>, size: size_t) {
        super.init(ptr: cef_binary_value_create(data, size))
    }
    
    /// Returns true if this object is valid. This object may become invalid if
    /// the underlying data is owned by another object (e.g. list or dictionary)
    /// and that other object is then modified or destroyed. Do not call any other
    /// methods if this method returns false.
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }
    
    /// Returns true if this object is currently owned by another object.
    public func isOwned() -> Bool {
        return cefObject.is_owned(cefObjectPtr) != 0
    }
    
    /// Returns true if this object and |that| object have the same underlying
    /// data.
    public func isSame(other: CEFBinaryValue) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns true if this object and |that| object have an equivalent underlying
    /// value but are not necessarily the same object.
    public func isEqual(other: CEFBinaryValue) -> Bool {
        return cefObject.is_equal(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns a copy of this object. The data in this object will also be copied.
    public func copy() -> CEFBinaryValue? {
        let copiedObj = cefObject.copy(cefObjectPtr)
        return CEFBinaryValue.fromCEF(copiedObj)
    }
    
    /// Returns the data size.
    public func getSize() -> size_t {
        return cefObject.get_size(cefObjectPtr)
    }
    
    /// Read up to |buffer_size| number of bytes into |buffer|. Reading begins at
    /// the specified byte |data_offset|. Returns the number of bytes read.
    public func getData(buffer: UnsafeMutablePointer<Void>, size: size_t, offset: size_t) -> size_t {
        return cefObject.get_data(cefObjectPtr, buffer, size, offset)
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFBinaryValue? {
        return CEFBinaryValue(ptr: ptr)
    }
}


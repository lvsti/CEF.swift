//
//  CEFPOSTDataElement.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

public extension CEFPOSTDataElement {

    /// Create a new CefPostDataElement object.
    /// CEF name: `Create`
    public convenience init?() {
        self.init(ptr: cef_post_data_element_create())
    }
    
    /// Returns true if this object is read-only.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Remove all contents from the post data element.
    /// CEF name: `SetToEmpty`
    public func setToEmpty() {
        cefObject.set_to_empty(cefObjectPtr)
    }
    
    /// The post data element will represent a file.
    /// CEF name: `SetToFile`
    public func setToFile(fileName: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(fileName)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_to_file(cefObjectPtr, cefStrPtr)
    }
    
    /// The post data element will represent bytes.  The bytes passed
    /// in will be copied.
    /// CEF name: `SetToBytes`
    public func setToBytes(data: NSData) {
        cefObject.set_to_bytes(cefObjectPtr, data.length, data.bytes)
    }
    
    /// Return the type of this post data element.
    /// CEF name: `GetType`
    public var type: CEFPOSTDataElementType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFPOSTDataElementType.fromCEF(cefType)
    }
    
    /// Return the file name.
    /// CEF name: `GetFile`
    public var fileName: String? {
        let cefStrPtr = cefObject.get_file(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Return the number of bytes.
    /// CEF name: `GetBytesCount`
    public var size: size_t {
        return cefObject.get_bytes_count(cefObjectPtr)
    }
    
    /// Read up to |size| bytes into |bytes| and return the number of bytes
    /// actually read.
    /// CEF name: `GetBytes`
    public func data(upToLength maxLength: size_t) -> NSData {
        let data = NSMutableData(length: maxLength)!
        let actualSize = cefObject.get_bytes(cefObjectPtr, maxLength, data.mutableBytes)
        data.length = actualSize
        return data
    }
    
}


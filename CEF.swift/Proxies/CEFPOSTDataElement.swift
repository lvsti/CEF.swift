//
//  CEFPOSTDataElement.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_post_data_element_t: CEFObject {
}

/// Class used to represent a single element in the request post data. The
/// methods of this class may be called on any thread.
public class CEFPOSTDataElement: CEFProxy<cef_post_data_element_t> {

    /// Create a new CefPostDataElement object.
    public init?() {
        super.init(ptr: cef_post_data_element_create())
    }
    
    /// Returns true if this object is read-only.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Remove all contents from the post data element.
    public func setToEmpty() {
        cefObject.set_to_empty(cefObjectPtr)
    }
    
    /// The post data element will represent a file.
    public func setToFile(fileName: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(fileName)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_to_file(cefObjectPtr, cefStrPtr)
    }
    
    /// The post data element will represent bytes.  The bytes passed
    /// in will be copied.
    public func setToBytes(data: NSData) {
        cefObject.set_to_bytes(cefObjectPtr, data.length, data.bytes)
    }
    
    /// Return the type of this post data element.
    public var type: CEFPOSTDataElementType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFPOSTDataElementType.fromCEF(cefType)
    }
    
    /// Return the file name.
    public var file: String {
        let cefStrPtr = cefObject.get_file(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Return the number of bytes.
    public var size: size_t {
        return cefObject.get_bytes_count(cefObjectPtr)
    }
    
    /// Read up to |size| bytes into |bytes| and return the number of bytes
    /// actually read.
    public func getBytes(maxCount: size_t) -> NSData {
        let data = NSMutableData(length: maxCount)!
        let actualSize = cefObject.get_bytes(cefObjectPtr, maxCount, data.mutableBytes)
        data.length = actualSize
        return data
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFPOSTDataElement? {
        return CEFPOSTDataElement(ptr: ptr)
    }
}


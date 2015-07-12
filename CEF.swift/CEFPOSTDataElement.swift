//
//  CEFPOSTDataElement.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//
//

import Foundation

extension cef_post_data_element_t: CEFObject {
    public static func create() -> UnsafeMutablePointer<cef_post_data_element_t> {
        return cef_post_data_element_create()
    }
    public var base: cef_base_t { get { return self.base } nonmutating set { } }
}

public class CEFPOSTDataElement: CEFBase<cef_post_data_element_t> {
    
    enum ElementType: Int {
        case Empty = 0
        case Bytes
        case File
    }
    
    override init() {
        super.init()
    }
    
    override init(proxiedObject obj: cef_post_data_element_t) {
        super.init(proxiedObject: obj)
    }
    
    func isReadOnly() -> Bool {
        return object.is_read_only(cefSelf) != 0
    }

    func setToEmpty() {
        object.set_to_empty(cefSelf)
    }
    
    func setToFile(fileName: String) {
        let cefStrPtr = CEFStringPtrFromSwiftString(fileName)
        object.set_to_file(cefSelf, cefStrPtr)
        cef_string_userfree_utf16_free(cefStrPtr)
    }
    
    func setToBytes(data: NSData) {
        object.set_to_bytes(cefSelf, data.length, data.bytes)
    }
    
    func getType() -> ElementType {
        let type = object.get_type(cefSelf).rawValue
        return ElementType(rawValue: Int(type))!
    }
    
    func getFile() -> String {
        let cefStrPtr = object.get_file(cefSelf)
        let retval = CEFStringToSwiftString(cefStrPtr.memory)
        cefStrPtr.dealloc(1)
        
        return retval
    }
    
    func getBytesCount() -> size_t {
        return object.get_bytes_count(cefSelf)
    }
    
    func getBytes(maxCount: size_t) -> NSData {
        let data = NSMutableData(length: maxCount)!
        let actualSize = object.get_bytes(cefSelf, maxCount, data.mutableBytes)
        data.length = actualSize
        return data
    }
    
}


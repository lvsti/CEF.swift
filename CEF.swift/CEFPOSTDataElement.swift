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

public class CEFPOSTDataElement: CEFProxyBase<cef_post_data_element_t> {
    
    enum ElementType: Int {
        case Empty = 0
        case Bytes
        case File
    }
    
    init?() {
        super.init(ptr: cef_post_data_element_create())
    }
    
    func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    func setToEmpty() {
        cefObject.set_to_empty(cefObjectPtr)
    }
    
    func setToFile(fileName: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(fileName)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.set_to_file(cefObjectPtr, cefStrPtr)
    }
    
    func setToBytes(data: NSData) {
        cefObject.set_to_bytes(cefObjectPtr, data.length, data.bytes)
    }
    
    func getType() -> ElementType {
        let type = cefObject.get_type(cefObjectPtr).rawValue
        return ElementType(rawValue: Int(type))!
    }
    
    func getFile() -> String {
        let cefStrPtr = cefObject.get_file(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    func getBytesCount() -> size_t {
        return cefObject.get_bytes_count(cefObjectPtr)
    }
    
    func getBytes(maxCount: size_t) -> NSData {
        let data = NSMutableData(length: maxCount)!
        let actualSize = cefObject.get_bytes(cefObjectPtr, maxCount, data.mutableBytes)
        data.length = actualSize
        return data
    }
    
}


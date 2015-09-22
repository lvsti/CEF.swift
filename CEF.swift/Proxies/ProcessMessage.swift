//
//  ProcessMessage.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_process_message_t: CEFObject {
}

/// Class representing a message. Can be used on any process and thread.
public class ProcessMessage: Proxy<cef_process_message_t> {

    /// Create a new CefProcessMessage object with the specified name.
    public init?(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }

        super.init(ptr: cef_process_message_create(cefStrPtr))
    }

    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns a writable copy of this object.
    public func copy() -> ProcessMessage? {
        let cefProcMsg = cefObject.copy(cefObjectPtr)
        return ProcessMessage.fromCEF(cefProcMsg)
    }

    /// Returns the message name.
    public var name: String {
        let cefNamePtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        return CEFStringToSwiftString(cefNamePtr.memory)
    }

    /// Returns the list of arguments.
    public var argumentList: ListValue? {
        let cefList = cefObject.get_argument_list(cefObjectPtr)
        return ListValue.fromCEF(cefList)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> ProcessMessage? {
        return ProcessMessage(ptr: ptr)
    }
}

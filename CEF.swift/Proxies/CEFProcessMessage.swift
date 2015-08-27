//
//  CEFProcessMessage.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_process_message_t: CEFObject {
}

///
// Class representing a message. Can be used on any process and thread.
///
public class CEFProcessMessage: CEFProxy<cef_process_message_t> {

    ///
    // Create a new CefProcessMessage object with the specified name.
    ///
    public init?(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }

        super.init(ptr: cef_process_message_create(cefStrPtr))
    }

    ///
    // Returns true if this object is valid. Do not call any other methods if this
    // function returns false.
    ///
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    ///
    // Returns true if the values of this object are read-only. Some APIs may
    // expose read-only objects.
    ///
    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    ///
    // Returns a writable copy of this object.
    ///
    public func copy() -> CEFProcessMessage? {
        let cefProcMsg = cefObject.copy(cefObjectPtr)
        return CEFProcessMessage.fromCEF(cefProcMsg)
    }

    ///
    // Returns the message name.
    ///
    public func getName() -> String {
        let cefNamePtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        return CEFStringToSwiftString(cefNamePtr.memory)
    }

    ///
    // Returns the list of arguments.
    ///
    public func getArgumentList() -> CEFListValue? {
        let cefList = cefObject.get_argument_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFProcessMessage? {
        return CEFProcessMessage(ptr: ptr)
    }
}

//
//  CEFProcessMessage.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFProcessMessage {

    /// Create a new CefProcessMessage object with the specified name.
    public convenience init?(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }

        self.init(ptr: cef_process_message_create(cefStrPtr))
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
    public func copy() -> CEFProcessMessage? {
        let cefProcMsg = cefObject.copy(cefObjectPtr)
        return CEFProcessMessage.fromCEF(cefProcMsg)
    }

    /// Returns the message name.
    public var name: String {
        let cefNamePtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        return CEFStringToSwiftString(cefNamePtr!.pointee)
    }

    /// Returns the list of arguments.
    public var argumentList: CEFListValue? {
        let cefList = cefObject.get_argument_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

}

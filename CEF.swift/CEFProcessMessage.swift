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

public enum CEFProcessID: Int {
    case Browser = 0
    case Renderer
    
    func toCEF() -> cef_process_id_t {
        return cef_process_id_t(rawValue: UInt32(rawValue))
    }
}

public class CEFProcessMessage: CEFProxy<cef_process_message_t> {

    public init?(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }

        super.init(ptr: cef_process_message_create(cefStrPtr))
    }

    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func isReadOnly() -> Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    public func copy() -> CEFProcessMessage? {
        let cefProcMsg = cefObject.copy(cefObjectPtr)
        return CEFProcessMessage.fromCEF(cefProcMsg)
    }

    public func getName() -> String {
        let cefNamePtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        return CEFStringToSwiftString(cefNamePtr.memory)
    }

    public func getArgumentList() -> CEFListValue? {
        let cefList = cefObject.get_argument_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

}

//
//  CEFUserData.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


typealias CEFUserDataMarshaller = CEFMarshaller<CEFUserData, cef_base_t>

extension CEFUserData {
    func toCEF() -> UnsafeMutablePointer<cef_base_t> {
        return CEFUserDataMarshaller.pass(self)
    }

    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_base_t>) -> CEFUserData? {
        return CEFUserDataMarshaller.take(ptr)
    }
}

extension cef_base_t: CEFObject {
    public var base: cef_base_t { get { return self } set {} }
}

extension cef_base_t: CEFCallbackMarshalling {
    func marshalCallbacks() {
    }
}


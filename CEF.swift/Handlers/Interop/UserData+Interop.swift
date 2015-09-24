//
//  UserData.g.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


typealias UserDataMarshaller = Marshaller<UserData, cef_base_t>

extension UserData {
    func toCEF() -> UnsafeMutablePointer<cef_base_t> {
        return UserDataMarshaller.pass(self)
    }

    static func fromCEF(ptr: UnsafeMutablePointer<cef_base_t>) -> UserData? {
        return UserDataMarshaller.take(ptr)
    }
}

extension cef_base_t: CEFObject {
    public var base: cef_base_t { get { return self } set {} }
}

extension cef_base_t: CallbackMarshalling {
    func marshalCallbacks() {
    }
}


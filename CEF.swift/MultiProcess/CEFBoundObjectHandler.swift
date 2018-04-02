//
//  ICEFJsHandler.swift
//  CEF.swift
//
//  Created by Morris on 27/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

// This object is used as the context object when JS calls Native method.
// So one can inherit this object to provide more infomation for the Native method.
public class CEFBoundObjectHandler {

    // Inits the handler with methods. These methods will be resitered in the Render Process.
    // If the method return nil, the method call is considered to be successful with empty return value.
    // If the method throws, the method will caused the corresponding promise in the webpage to be rejected.
    // The return type Any can be: (Notice that Int64 is not supported)
    //   Int32, Int(Cause runtime exception if the int is larger than Int32), Bool, Double, String, NSNull, [Any], [String: Any]
    public typealias Method = (CEFBoundObjectHandler, CEFListValue) throws -> Any?

    internal private(set) var methods: [String: Method]

    public init(methods: [String: Method]) {
        self.methods = methods
    }
}

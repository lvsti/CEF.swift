//
//  ICEFJsHandler.swift
//  CEF.swift
//
//  Created by Morris on 27/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFBoundObjectHandler {
    public enum Result {
        case success(CEFValue)
        case failure(String)
    }

    typealias Method = (CEFBoundObjectHandler, CEFListValue) throws -> Result?

    internal private(set) var methods: [String: Method]

    // Inits the handler with methods. If the method return nil, the method call is considered to be successful
    // with empty return value.
    init(methods: [String: Method]) {
        self.methods = methods
    }

    public func execute(name: String, arguments: CEFListValue) -> Result? {
        if let method = methods[name] {
            do {
                return try method(self, arguments)
            } catch {
                return .failure(error.localizedDescription)
            }
        }

        return .failure("Not implemented")
    }
}

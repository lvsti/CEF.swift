//
//  CEFFrameWrapper.swift
//  CEF.swift
//
//  Created by Morris on 27/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

// This class contains extra data for CEFFrame in multi process mode.
public class CEFFrameWrapper {

    public var contextCreated = false {
        didSet {
            if !contextCreated {
                // Clear any pending response when context is destroyed to free related CEFV8Value
                pendingRequestPromises.removeAll()
            }
        }
    }

    // Used by BrowserProcess
    internal var boundObjectHandlers = [String: CEFBoundObjectHandler]()
    // Used by RenderProcess
    public var boundObjectDelegates = [String: CEFBoundObjectDelegate]()
    private var pendingRequestId: Int32 = 0
    private var pendingRequestPromises = [Int32: CEFV8Value]()

    internal func addPendingPromise(_ value: CEFV8Value) -> Int32 {
        pendingRequestId += 1
        pendingRequestPromises[pendingRequestId] = value
        return pendingRequestId
    }

    public func rejectPromise(_ rid: Int32, _ error: String) {
        if let p = pendingRequestPromises[rid],
           let v8Value = CEFV8Value.createString(error) {
            _ = p.value(for: "f")?.executeFunction(object: nil, arguments: [v8Value])
        }
    }

    public func resolvePromise(_ rid: Int32, _ value: CEFValue?) {
        if let p = pendingRequestPromises[rid] {
            if let v8Value = CEFV8Value.fromCEFValue(value) {
                _ = p.value(for: "s")?.executeFunction(object: nil, arguments: [v8Value])
            } else {
                _ = p.value(for: "s")?.executeFunction(object: nil, arguments: [])
            }
        }
    }

    private var id: CEFFrame.Identifier
    internal init(_ id: CEFFrame.Identifier) {
        self.id = id
    }
}

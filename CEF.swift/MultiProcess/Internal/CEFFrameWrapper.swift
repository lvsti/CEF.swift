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
                // Clear any pending response when context is destroyed to free
                // related CEFV8Value
                for delegate in boundObjectDelegates.values {
                    delegate.clearPendingResponse()
                }
            }
        }
    }

    // Used by BrowserProcess
    internal var boundObjectHandlers = [String: CEFBoundObjectHandler]()
    // Used by RenderProcess
    public var boundObjectDelegates = [String: CEFBoundObjectDelegate]()

    private var id: CEFFrame.Identifier
    internal init(_ id: CEFFrame.Identifier) {
        self.id = id
    }
}

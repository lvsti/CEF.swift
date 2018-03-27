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

    public var contextCreated = false
    // Used by BrowserProcess
    internal var boundObjectHandlers = [String: CEFBoundObjectHandler]()

    // Used by RenderProcess
    public class BoundObjectInfo {
        public private(set) var name: String
        public private(set) var methods: [String]
        public var bound = false
        init(_ name: String, _ methods: [String]) {
            self.name = name
            self.methods = methods
        }
    }
    public var boundObjectInfo = [BoundObjectInfo]()

    private var id: CEFFrame.Identifier
    internal init(_ id: CEFFrame.Identifier) {
        self.id = id
    }
}

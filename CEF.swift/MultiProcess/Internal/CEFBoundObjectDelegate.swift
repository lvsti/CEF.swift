//
//  CEFBoundObjectDelegate.swift
//  CEF.swift
//
//  Created by Morris on 28/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFBoundObjectDelegate: CEFV8Handler {

    public var bound = false

    public private(set) var name: String
    public private(set) var methods: Set<String>
    
    private var fid: CEFFrame.Identifier
    private var bid: CEFBrowser.Identifier

    public func execute(name: String, object: CEFV8Value, arguments: [CEFV8Value]) -> CEFV8Result? {

        guard let browserWrapper = CEFBrowserWrapper.get(byId: bid) else { return nil }
        guard let frame = browserWrapper.browser.frame(id: fid) else { return nil }

        if !methods.contains(name) { return .failure("Not implemented") }

        var context = frame.v8Context
        context.enter()
        defer { context.exit() }

        // Create promise
        let promiseEval = context.eval("var __p={};__p.p=new Promise(function(s,f){__p.s=s;__p.f=f});__p")
        guard case .success(let promise) = promiseEval else { return .failure("Cannot create promise") }

        // Convert CEFV8Values to CEFValue, and send IPC message
        guard let message = CEFProcessMessage(.javascriptAsyncMethodCallRequest),
              let list = message.argumentList else {
            return .failure("Failed to create IPC message")
        }

        let wrapper = browserWrapper.getFrameWrapper(fid)
        let requestId = wrapper.addPendingPromise(promise)

        list.set(fid as Int64, at: 0)
        list.set(requestId, at: 1)
        list.set(self.name, at: 2)
        list.set(name, at: 3)
        list.set(arguments.cefListValue, at: 4)
        browserWrapper.browser.sendProcessMessage(targetProcessID: .browser, message: message)

        return CEFV8Result.success(promise.value(for: "p")!)
    }

    public init(
        name: String,
        methods: [String],
        browser: CEFBrowser,
        fid: CEFFrame.Identifier
    ) {
        self.name = name
        self.methods = Set<String>(methods)
        self.bid = browser.identifier
        self.fid = fid
    }
}

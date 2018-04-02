//
//  CEFBrowserWrapper.swift
//  CEF.swift
//
//  Created by Morris on 27/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

// This class contains extra data for CEFBrowser & CEFFrame in multi process mode.
// This class don't have to be thread-safe, because all the methods are called in main thread.
public class CEFBrowserWrapper {

    private static var terminated = [CEFBrowser.Identifier: Bool]()
    private static var cache = [CEFBrowser.Identifier: CEFBrowserWrapper]()

    private var frameCache = [CEFFrame.Identifier: CEFFrameWrapper]()
    public private(set) var browser: CEFBrowser
    public var id: CEFBrowser.Identifier { return browser.identifier }

    public init?(_ browser: CEFBrowser) {
        let id = browser.identifier
        if CEFBrowserWrapper.cache[id] != nil {
            return nil
        }

        if CEFBrowserWrapper.terminated[id] == true {
            return nil
        }

        self.browser = browser
        CEFBrowserWrapper.cache[id] = self
    }

    // Mark the browser as closed, and release corresponding CEF resource.
    public static func terminate(_ id: CEFBrowser.Identifier) {
        CEFBrowserWrapper.terminated[id] = true
        CEFBrowserWrapper.cache.removeValue(forKey: id)
    }

    public static func get(byId: CEFBrowser.Identifier) -> CEFBrowserWrapper? {
        if let w = cache[byId] {
            return w
        }
        return nil
    }

    public static func get(_ browser: CEFBrowser) -> CEFBrowserWrapper? {
        let id = browser.identifier
        if let w = cache[id] { return w }
        return CEFBrowserWrapper(browser)
    }

    public static func getFrameWrapper(bid: CEFBrowser.Identifier, fid: CEFFrame.Identifier) -> CEFFrameWrapper? {
        return get(byId: bid)?.getFrameWrapper(fid)
    }
    public static func getFrameWrapper(_ browser: CEFBrowser, fid: CEFFrame.Identifier) -> CEFFrameWrapper? {
        return get(browser)?.getFrameWrapper(fid)
    }

    public func getFrameWrapper(_ id: CEFFrame.Identifier) -> CEFFrameWrapper {
        if let w = frameCache[id] {
            return w
        }

        let w = CEFFrameWrapper(id)
        frameCache[id] = w
        return w
    }

    public func removeFrameWrapper(_ id: CEFFrame.Identifier) {
        frameCache.removeValue(forKey: id)
    }
}

//
//  CEFBrowserWrapper.swift
//  CEF.swift
//
//  Created by Morris on 27/03/2018.
//  Copyright © 2018 Tamas Lustyik. All rights reserved.
//

import Foundation

// This class contains extra data for CEFFrame in multi process mode.
public class CEFBrowserWrapper {

    private static var cache = [CEFBrowser.Identifier: CEFBrowserWrapper]()

    private var frameCache = [CEFFrame.Identifier: CEFFrameWrapper]()
    private var id: CEFBrowser.Identifier

    internal init(_ id: CEFBrowser.Identifier) {
        self.id = id
    }

    public static func getWrapper(_ id: CEFBrowser.Identifier) -> CEFBrowserWrapper {
        if let w = cache[id] {
            return w
        }

        let w = CEFBrowserWrapper(id)
        cache[id] = w
        return w
    }

    public static func getFrameWrapper(bid: CEFBrowser.Identifier, fid: CEFFrame.Identifier) -> CEFFrameWrapper {
        return getWrapper(bid).getFrameWrapper(fid)
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

//
//  CEFLifeSpanHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public protocol CEFLifeSpanHandler {

    func onBeforePopup(browser: CEFBrowser,
                       frame: CEFFrame,
                       targetURL: NSURL?,
                       targetFrameName: String?,
                       targetDisposition: CEFWindowOpenDisposition,
                       userGesture: Bool,
                       popupFeatures: CEFPopupFeatures,
                       inout windowInfo: CEFWindowInfo,
                       inout client: CEFClient,
                       inout settings: CEFBrowserSettings,
                       inout jsAccess: Bool) -> Bool

    func onAfterCreated(browser: CEFBrowser)
    func runModal(browser: CEFBrowser) -> Bool
    func doClose(browser: CEFBrowser) -> Bool
    func onBeforeClose(browser: CEFBrowser)

}

public extension CEFLifeSpanHandler {

    func onBeforePopup(browser: CEFBrowser,
                       frame: CEFFrame,
                       targetURL: NSURL?,
                       targetFrameName: String?,
                       targetDisposition: CEFWindowOpenDisposition,
                       userGesture: Bool,
                       popupFeatures: CEFPopupFeatures,
                       windowInfo: CEFWindowInfo,
                       client: CEFClient,
                       settings: CEFBrowserSettings,
                       inout jsAccess: Bool) -> Bool {
        return false
    }

    func onAfterCreated(browser: CEFBrowser) {
    }
    
    func runModal(browser: CEFBrowser) -> Bool {
        return false
    }

    func doClose(browser: CEFBrowser) -> Bool {
        return false
    }
    
    func onBeforeClose(browser: CEFBrowser) {
    }
    
}


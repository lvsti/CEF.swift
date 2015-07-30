//
//  CEFLifeSpanHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public class CEFLifeSpanHandler: CEFHandler {

    public override init() {
        super.init()
    }
    
//    public func onBeforePopup(browser: CEFBrowser,
//                       frame: CEFFrame,
//                       inout targetURL: NSURL,
//                       inout targetFrameName: String,
//                       targetDisposition: CEFWindowOpenDisposition,
//                       userGesture: Bool,
//                       popupFeatures: CEFPopupFeatures,
//                       windowInfo: CEFWindowInfo,
//                       client: CEFClient,
//                       settings: CEFBrowserSettings,
//                       inout jsAccess: Bool) -> Bool {
//        return false
//    }

    public func onAfterCreated(browser: CEFBrowser) {
    }
    
    public func runModal(browser: CEFBrowser) -> Bool {
        return false
    }

    public func doClose(browser: CEFBrowser) -> Bool {
        return false
    }
    
    public func onBeforeClose(browser: CEFBrowser) {
    }
    
}


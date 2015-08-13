//
//  CEFPopupFeatures.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Popup window features.
///
public struct CEFPopupFeatures {
    public var rect: NSRect
    public var rectSet: NSRect

    public var menuBarVisible: Bool
    public var statusBarVisible: Bool
    public var toolBarVisible: Bool
    public var locationBarVisible: Bool
    public var scrollbarsVisible: Bool
    public var isResizable: Bool
    public var isFullscreen: Bool
    public var isDialog: Bool
    
    public var additionalFeatures: [String]
}

extension CEFPopupFeatures {
    static func fromCEF(value: cef_popup_features_t) -> CEFPopupFeatures {
        return CEFPopupFeatures(rect: NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height)),
                                rectSet: NSRect(x: Int(value.xSet), y: Int(value.ySet), width: Int(value.widthSet), height: Int(value.heightSet)),
                                menuBarVisible: value.menuBarVisible != 0,
                                statusBarVisible: value.statusBarVisible != 0,
                                toolBarVisible: value.toolBarVisible != 0,
                                locationBarVisible: value.locationBarVisible != 0,
                                scrollbarsVisible: value.scrollbarsVisible != 0,
                                isResizable: value.resizable != 0,
                                isFullscreen: value.fullscreen != 0,
                                isDialog: value.dialog != 0,
                                additionalFeatures: CEFStringListToSwiftArray(value.additionalFeatures))
    }
}

extension cef_popup_features_t {
    mutating func clear() {
        if additionalFeatures != nil {
            cef_string_list_free(additionalFeatures)
        }
    }
}


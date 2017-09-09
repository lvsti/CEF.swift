//
//  CEFPopupFeatures.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Popup window features.
/// CEF name: `cef_popup_features_t`
public struct CEFPopupFeatures {
    /// CEF name: `x`, `y`, `width`, `height`
    public let rect: NSRect
    /// CEF name: `xSet`, `ySet`, `widthSet`, `heightSet`
    public let rectSet: NSRect

    /// CEF name: `menuBarVisible`
    public let hasMenuBar: Bool
    /// CEF name: `statusBarVisible`
    public let hasStatusBar: Bool
    /// CEF name: `toolBarVisible`
    public let hasToolBar: Bool
    /// CEF name: `scrollbarsVisible`
    public let hasScrollbars: Bool
}

extension CEFPopupFeatures {
    static func fromCEF(_ value: cef_popup_features_t) -> CEFPopupFeatures {
        return CEFPopupFeatures(rect: NSRect(x: Int(value.x), y: Int(value.y), width: Int(value.width), height: Int(value.height)),
                                rectSet: NSRect(x: Int(value.xSet), y: Int(value.ySet), width: Int(value.widthSet), height: Int(value.heightSet)),
                                hasMenuBar: value.menuBarVisible != 0,
                                hasStatusBar: value.statusBarVisible != 0,
                                hasToolBar: value.toolBarVisible != 0,
                                hasScrollbars: value.scrollbarsVisible != 0)
    }
}

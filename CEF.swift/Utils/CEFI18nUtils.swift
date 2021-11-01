//
//  CEFI18nUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2021. 11. 01..
//  Copyright © 2021. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFI18nUtils {
    
    /// Returns true if the application text direction is right-to-left.
    /// CEF name: `CefIsRTL`
    public static var isRTL: Bool {
        return cef_is_rtl() != 0
    }
    
}

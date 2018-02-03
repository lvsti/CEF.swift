//
//  CEFPathUtils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 14..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFPathUtils {
    
    /// Retrieve the path associated with the specified |key|. Returns true (1) on
    /// success. Can be called on any thread in the browser process.
    /// CEF name: `CefGetPath`
    public static func getPathForKey(key: CEFPathKey) -> String? {
        var cefStr = cef_string_t()
        let retval = cef_get_path(key.toCEF(), &cefStr)
        return retval != 0 ? CEFStringToSwiftString(cefStr) : nil
    }

}

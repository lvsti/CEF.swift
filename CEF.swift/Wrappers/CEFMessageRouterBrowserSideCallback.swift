//
//  CEFMessageRouterBrowserSideCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 22..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

import Foundation
import LibCEFWrapper

public extension CEFMessageRouterBrowserSideCallback {
    /// Notify the associated JavaScript onSuccess callback that the query has
    /// completed successfully with the specified |response|.
    /// CEF name: `Success`
    public func reportSuccess(withResponse response: String) {
        let cefStr = CEFStringPtrCreateFromSwiftString(response)
        defer { CEFStringPtrRelease(cefStr) }
        cefObject.success(cefObjectPtr, cefStr)
    }
    
    /// Notify the associated JavaScript onFailure callback that the query has
    /// failed with the specified |error_code| and |error_message|.
    /// CEF name: `Failure`
    public func reportFailure(withErrorCode errorCode: Int, message: String) {
        let cefStr = CEFStringPtrCreateFromSwiftString(message)
        defer { CEFStringPtrRelease(cefStr) }
        cefObject.failure(cefObjectPtr, Int32(errorCode), cefStr)
    }
}


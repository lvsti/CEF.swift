//
//  CEFResolveCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 04. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback interface for CefRequestContext::ResolveHost
/// CEF name: `CefResolveCallback`
public protocol CEFResolveCallback {

    /// Called on the UI thread after the ResolveHost request has completed.
    /// |result| will be the result code. |resolved_ips| will be the list of
    /// resolved IP addresses or empty if the resolution failed.
    /// CEF name: `OnResolveCompleted`
    func onResolveCompleted(results: [String]?, errorCode: CEFErrorCode)
    
}

public extension CEFResolveCallback {

    func onResolveCompleted(results: [String]?, errorCode: CEFErrorCode) {
    }

}


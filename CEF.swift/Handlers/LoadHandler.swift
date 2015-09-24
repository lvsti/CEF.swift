//
//  LoadHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to handle events related to browser load status. The
/// methods of this class will be called on the browser process UI thread or
/// render process main thread (TID_RENDERER).
public protocol LoadHandler {
    
    /// Called when the loading state has changed. This callback will be executed
    /// twice -- once when loading is initiated either programmatically or by user
    /// action, and once when loading is terminated due to completion, cancellation
    /// of failure.
    func onLoadingStateChange(browser: Browser, isLoading: Bool, canGoBack: Bool, canGoForward: Bool)
    
    /// Called when the browser begins loading a frame. The |frame| value will
    /// never be empty -- call the IsMain() method to check if this frame is the
    /// main frame. Multiple frames may be loading at the same time. Sub-frames may
    /// start or continue loading after the main frame load has ended. This method
    /// may not be called for a particular frame if the load request for that frame
    /// fails. For notification of overall browser load status use
    /// OnLoadingStateChange instead.
    func onLoadStart(browser: Browser, frame: Frame)
    
    /// Called when the browser is done loading a frame. The |frame| value will
    /// never be empty -- call the IsMain() method to check if this frame is the
    /// main frame. Multiple frames may be loading at the same time. Sub-frames may
    /// start or continue loading after the main frame load has ended. This method
    /// will always be called for all frames irrespective of whether the request
    /// completes successfully.
    func onLoadEnd(browser: Browser, frame: Frame, statusCode: Int)
    
    /// Called when the resource load for a navigation fails or is canceled.
    /// |errorCode| is the error code number, |errorText| is the error text and
    /// |failedUrl| is the URL that failed to load. See net\base\net_error_list.h
    /// for complete descriptions of the error codes.
    func onLoadError(browser: Browser, frame: Frame, errorCode: ErrorCode, errorMessage: String, url: NSURL)

}

public extension LoadHandler {

    func onLoadingStateChange(browser: Browser, isLoading: Bool, canGoBack: Bool, canGoForward: Bool) {
    }
    
    func onLoadStart(browser: Browser, frame: Frame) {
    }
    
    func onLoadEnd(browser: Browser, frame: Frame, statusCode: Int) {
    }
    
    func onLoadError(browser: Browser, frame: Frame, errorCode: ErrorCode, errorMessage: String, url: NSURL) {
    }

}


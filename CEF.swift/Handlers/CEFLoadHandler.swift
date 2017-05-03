//
//  CEFLoadHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to handle events related to browser load status. The
/// methods of this class will be called on the browser process UI thread or
/// render process main thread (TID_RENDERER).
/// CEF name: `CefLoadHandler`
public protocol CEFLoadHandler {
    
    /// Called when the loading state has changed. This callback will be executed
    /// twice -- once when loading is initiated either programmatically or by user
    /// action, and once when loading is terminated due to completion, cancellation
    /// of failure. It will be called before any calls to OnLoadStart and after all
    /// calls to OnLoadError and/or OnLoadEnd.
    /// CEF name: `OnLoadingStateChange`
    func onLoadingStateChange(browser: CEFBrowser, isLoading: Bool, canGoBack: Bool, canGoForward: Bool)
    
    /// Called after a navigation has been committed and before the browser begins
    /// loading contents in the frame. The |frame| value will never be empty --
    /// call the IsMain() method to check if this frame is the main frame.
    /// |transition_type| provides information about the source of the navigation
    /// and an accurate value is only available in the browser process. Multiple
    /// frames may be loading at the same time. Sub-frames may start or continue
    /// loading after the main frame load has ended. This method will not be called
    /// for same page navigations (fragments, history state, etc.) or for
    /// navigations that fail or are canceled before commit. For notification of
    /// overall browser load status use OnLoadingStateChange instead.
    /// CEF name: `OnLoadStart`
    func onLoadStart(browser: CEFBrowser, frame: CEFFrame, transitionType: CEFTransitionType)
    
    /// Called when the browser is done loading a frame. The |frame| value will
    /// never be empty -- call the IsMain() method to check if this frame is the
    /// main frame. Multiple frames may be loading at the same time. Sub-frames may
    /// start or continue loading after the main frame load has ended. This method
    /// will not be called for same page navigations (fragments, history state,
    /// etc.) or for navigations that fail or are canceled before commit. For
    /// notification of overall browser load status use OnLoadingStateChange
    /// instead.
    /// CEF name: `OnLoadEnd`
    func onLoadEnd(browser: CEFBrowser, frame: CEFFrame, statusCode: Int)
    
    /// Called when a navigation fails or is canceled. This method may be called
    /// by itself if before commit or in combination with OnLoadStart/OnLoadEnd if
    /// after commit. |errorCode| is the error code number, |errorText| is the
    /// error text and |failedUrl| is the URL that failed to load.
    /// See net\base\net_error_list.h for complete descriptions of the error codes.
    /// CEF name: `OnLoadError`
    func onLoadError(browser: CEFBrowser, frame: CEFFrame, errorCode: CEFErrorCode, errorMessage: String, url: NSURL)

}

public extension CEFLoadHandler {

    func onLoadingStateChange(browser: CEFBrowser, isLoading: Bool, canGoBack: Bool, canGoForward: Bool) {
    }
    
    func onLoadStart(browser: CEFBrowser, frame: CEFFrame, transitionType: CEFTransitionType) {
    }
    
    func onLoadEnd(browser: CEFBrowser, frame: CEFFrame, statusCode: Int) {
    }
    
    func onLoadError(browser: CEFBrowser, frame: CEFFrame, errorCode: CEFErrorCode, errorMessage: String, url: NSURL) {
    }

}


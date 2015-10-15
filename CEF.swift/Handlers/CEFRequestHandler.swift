//
//  CEFRequestHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnBeforeBrowseAction {
    case Allow
    case Cancel
}

extension CEFOnBeforeBrowseAction: BooleanType {
    public var boolValue: Bool { return self == .Cancel }
}

public enum CEFOnOpenURLFromTabAction {
    case Allow
    case Cancel
}

extension CEFOnOpenURLFromTabAction: BooleanType {
    public var boolValue: Bool { return self == .Cancel }
}

public enum CEFOnResourceResponseAction {
    case Continue
    case Redirect
    case Retry
}

extension CEFOnResourceResponseAction: BooleanType {
    public var boolValue: Bool { return self == .Redirect || self == .Retry }
}

public enum CEFOnAuthCredentialsRequiredAction {
    case Allow
    case Cancel
}

extension CEFOnAuthCredentialsRequiredAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

public enum CEFOnQuotaRequestAction {
    case Allow
    case Cancel
}

extension CEFOnQuotaRequestAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

public enum CEFOnCertificateErrorAction {
    case Allow
    case Cancel
}

extension CEFOnCertificateErrorAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

/// Implement this interface to handle events related to browser requests. The
/// methods of this class will be called on the thread indicated.
public protocol CEFRequestHandler {
    
    /// Called on the UI thread before browser navigation. Return true to cancel
    /// the navigation or false to allow the navigation to proceed. The |request|
    /// object cannot be modified in this callback.
    /// CefLoadHandler::OnLoadingStateChange will be called twice in all cases.
    /// If the navigation is allowed CefLoadHandler::OnLoadStart and
    /// CefLoadHandler::OnLoadEnd will be called. If the navigation is canceled
    /// CefLoadHandler::OnLoadError will be called with an |errorCode| value of
    /// ERR_ABORTED.
    func onBeforeBrowse(browser: CEFBrowser,
                        frame: CEFFrame,
                        request: CEFRequest,
                        isRedirect: Bool) -> CEFOnBeforeBrowseAction
    
    /// Called on the UI thread before OnBeforeBrowse in certain limited cases
    /// where navigating a new or different browser might be desirable. This
    /// includes user-initiated navigation that might open in a special way (e.g.
    /// links clicked via middle-click or ctrl + left-click) and certain types of
    /// cross-origin navigation initiated from the renderer process (e.g.
    /// navigating the top-level frame to/from a file URL). The |browser| and
    /// |frame| values represent the source of the navigation. The
    /// |target_disposition| value indicates where the user intended to navigate
    /// the browser based on standard Chromium behaviors (e.g. current tab,
    /// new tab, etc). The |user_gesture| value will be true if the browser
    /// navigated via explicit user gesture (e.g. clicking a link) or false if it
    /// navigated automatically (e.g. via the DomContentLoaded event). Return true
    /// to cancel the navigation or false to allow the navigation to proceed in the
    /// source browser's top-level frame.
    func onOpenURLFromTab(browser: CEFBrowser,
                          frame: CEFFrame,
                          url: NSURL,
                          targetDisposition: CEFWindowOpenDisposition,
                          userGesture: Bool) -> CEFOnOpenURLFromTabAction
    
    /// Called on the IO thread before a resource request is loaded. The |request|
    /// object may be modified. Return RV_CONTINUE to continue the request
    /// immediately. Return RV_CONTINUE_ASYNC and call CefRequestCallback::
    /// Continue() at a later time to continue or cancel the request
    /// asynchronously. Return RV_CANCEL to cancel the request immediately.
    func onBeforeResourceLoad(browser: CEFBrowser,
                              frame: CEFFrame,
                              request: CEFRequest,
                              callback: CEFRequestCallback) -> CEFReturnValue
    
    /// Called on the IO thread before a resource is loaded. To allow the resource
    /// to load normally return NULL. To specify a handler for the resource return
    /// a CefResourceHandler object. The |request| object should not be modified in
    /// this callback.
    func resourceHandlerForBrowser(browser: CEFBrowser,
                                   frame: CEFFrame,
                                   request: CEFRequest) -> CEFResourceHandler?
    
    /// Called on the IO thread when a resource load is redirected. The |request|
    /// parameter will contain the old URL and other request-related information.
    /// The |new_url| parameter will contain the new URL and can be changed if
    /// desired. The |request| object cannot be modified in this callback.
    func onResourceRedirect(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            inout newURL: NSURL)
    
    /// Called on the IO thread when a resource response is received. To allow the
    /// resource to load normally return false. To redirect or retry the resource
    /// modify |request| (url, headers or post body) and return true. The
    /// |response| object cannot be modified in this callback.
    func onResourceResponse(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            response: CEFResponse) -> CEFOnResourceResponseAction
    
    /// Called on the IO thread when the browser needs credentials from the user.
    /// |isProxy| indicates whether the host is a proxy server. |host| contains the
    /// hostname and |port| contains the port number. Return true to continue the
    /// request and call CefAuthCallback::Continue() either in this method or
    /// at a later time when the authentication information is available. Return
    /// false to cancel the request immediately.
    func onAuthCredentialsRequired(browser: CEFBrowser,
                                   frame: CEFFrame,
                                   isProxy: Bool,
                                   host: String,
                                   port: UInt16,
                                   realm: String,
                                   scheme: String,
                                   callback: CEFAuthCallback) -> CEFOnAuthCredentialsRequiredAction
    
    /// Called on the IO thread when JavaScript requests a specific storage quota
    /// size via the webkitStorageInfo.requestQuota function. |origin_url| is the
    /// origin of the page making the request. |new_size| is the requested quota
    /// size in bytes. Return true to continue the request and call
    /// CefRequestCallback::Continue() either in this method or at a later time to
    /// grant or deny the request. Return false to cancel the request immediately.
    func onQuotaRequest(browser: CEFBrowser,
                        origin: NSURL,
                        newSize: Int64,
                        callback: CEFRequestCallback) -> CEFOnQuotaRequestAction
    
    /// Called on the UI thread to handle requests for URLs with an unknown
    /// protocol component. Set |allow_os_execution| to true to attempt execution
    /// via the registered OS protocol handler, if any.
    /// SECURITY WARNING: YOU SHOULD USE THIS METHOD TO ENFORCE RESTRICTIONS BASED
    /// ON SCHEME, HOST OR OTHER URL ANALYSIS BEFORE ALLOWING OS EXECUTION.
    func onProtocolExecution(browser: CEFBrowser, url: NSURL, inout allowExecution: Bool)
    
    /// Called on the UI thread to handle requests for URLs with an invalid
    /// SSL certificate. Return true and call CefRequestCallback::Continue() either
    /// in this method or at a later time to continue or cancel the request. Return
    /// false to cancel the request immediately. If |callback| is empty the error
    /// cannot be recovered from and the request will be canceled automatically.
    /// If CefSettings.ignore_certificate_errors is set all invalid certificates
    /// will be accepted without calling this method.
    func onCertificateError(browser: CEFBrowser,
                            errorCode: CEFErrorCode,
                            url: NSURL,
                            sslInfo: CEFSSLInfo,
                            callback: CEFRequestCallback) -> CEFOnCertificateErrorAction
    
    /// Called on the browser process UI thread when a plugin has crashed.
    /// |plugin_path| is the path of the plugin that crashed.
    func onPluginCrashed(browser: CEFBrowser, pluginPath: String)
    
    /// Called on the browser process UI thread when the render view associated
    /// with |browser| is ready to receive/handle IPC messages in the render
    /// process.
    func onRenderViewReady(browser: CEFBrowser)
    
    /// Called on the browser process UI thread when the render process
    /// terminates unexpectedly. |status| indicates how the process
    /// terminated.
    func onRenderProcessTerminated(browser: CEFBrowser, status: CEFTerminationStatus)

}

public extension CEFRequestHandler {

    func onBeforeBrowse(browser: CEFBrowser,
                        frame: CEFFrame,
                        request: CEFRequest,
                        isRedirect: Bool) -> CEFOnBeforeBrowseAction {
        return .Allow
    }

    func onOpenURLFromTab(browser: CEFBrowser,
                          frame: CEFFrame,
                          url: NSURL,
                          targetDisposition: CEFWindowOpenDisposition,
                          userGesture: Bool) -> CEFOnOpenURLFromTabAction {
        return .Allow
    }

    func onBeforeResourceLoad(browser: CEFBrowser,
                              frame: CEFFrame,
                              request: CEFRequest,
                              callback: CEFRequestCallback) -> CEFReturnValue {
        return .Continue
    }

    func resourceHandlerForBrowser(browser: CEFBrowser,
                                   frame: CEFFrame,
                                   request: CEFRequest) -> CEFResourceHandler? {
        return nil
    }

    func onResourceRedirect(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            inout newURL: NSURL) {
    }
    
    func onResourceResponse(browser: CEFBrowser,
                            frame: CEFFrame,
                            request: CEFRequest,
                            response: CEFResponse) -> CEFOnResourceResponseAction {
        return .Continue
    }
    
    func onAuthCredentialsRequired(browser: CEFBrowser,
                                   frame: CEFFrame,
                                   isProxy: Bool,
                                   host: String,
                                   port: UInt16,
                                   realm: String,
                                   scheme: String,
                                   callback: CEFAuthCallback) -> CEFOnAuthCredentialsRequiredAction {
        return .Cancel
    }

    func onQuotaRequest(browser: CEFBrowser,
                        origin: NSURL,
                        newSize: Int64,
                        callback: CEFRequestCallback) -> CEFOnQuotaRequestAction {
        return .Cancel
    }

    func onProtocolExecution(browser: CEFBrowser, url: NSURL, inout allowExecution: Bool) {
    }

    func onCertificateError(browser: CEFBrowser,
                            errorCode: CEFErrorCode,
                            url: NSURL,
                            sslInfo: CEFSSLInfo,
                            callback: CEFRequestCallback) -> CEFOnCertificateErrorAction {
        return .Cancel
    }

    func onPluginCrashed(browser: CEFBrowser, pluginPath: String) {
    }

    func onRenderViewReady(browser: CEFBrowser) {
    }

    func onRenderProcessTerminated(browser: CEFBrowser, status: CEFTerminationStatus) {
    }
    
}


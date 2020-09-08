//
//  CEFRequestHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 05..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnBeforeBrowseAction {
    case allow
    case cancel
}

public enum CEFOnOpenURLFromTabAction {
    case allow
    case cancel
}

public enum CEFOnAuthCredentialsRequiredAction {
    case allow
    case cancel
}

public enum CEFOnAttachCookiesAction {
    case allow
    case cancel
}

public enum CEFOnSetCookieAction {
    case allow
    case cancel
}

public enum CEFOnQuotaRequestAction {
    case allow
    case cancel
}

public enum CEFOnCertificateErrorAction {
    case allow
    case cancel
}

public enum CEFOnSelectClientCertificateAction {
    case useDefault
    case useSelected
}

/// Implement this interface to handle events related to browser requests. The
/// methods of this class will be called on the thread indicated.
/// CEF name: `CefRequestHandler`
public protocol CEFRequestHandler {
    
    /// Called on the UI thread before browser navigation. Return true to cancel
    /// the navigation or false to allow the navigation to proceed. The |request|
    /// object cannot be modified in this callback.
    /// CefLoadHandler::OnLoadingStateChange will be called twice in all cases.
    /// If the navigation is allowed CefLoadHandler::OnLoadStart and
    /// CefLoadHandler::OnLoadEnd will be called. If the navigation is canceled
    /// CefLoadHandler::OnLoadError will be called with an |errorCode| value of
    /// ERR_ABORTED. The |user_gesture| value will be true if the browser
    /// navigated via explicit user gesture (e.g. clicking a link) or false if it
    /// navigated automatically (e.g. via the DomContentLoaded event).
    /// CEF name: `OnBeforeBrowse`
    func onBeforeBrowse(browser: CEFBrowser,
                        frame: CEFFrame,
                        request: CEFRequest,
                        userGesture: Bool,
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
    /// CEF name: `OnOpenURLFromTab`
    func onOpenURLFromTab(browser: CEFBrowser,
                          frame: CEFFrame,
                          url: URL,
                          targetDisposition: CEFWindowOpenDisposition,
                          userGesture: Bool) -> CEFOnOpenURLFromTabAction
    
    /// Called on the browser process IO thread before a resource request is
    /// initiated. The |browser| and |frame| values represent the source of the
    /// request. |request| represents the request contents and cannot be modified
    /// in this callback. |is_navigation| will be true if the resource request is a
    /// navigation. |is_download| will be true if the resource request is a
    /// download. |request_initiator| is the origin (scheme + domain) of the page
    /// that initiated the request. Set |disable_default_handling| to true to
    /// disable default handling of the request, in which case it will need to be
    /// handled via CefResourceRequestHandler::GetResourceHandler or it will be
    /// canceled. To allow the resource load to proceed with default handling
    /// return NULL. To specify a handler for the resource return a
    /// CefResourceRequestHandler object. If this callback returns NULL the same
    /// method will be called on the associated CefRequestContextHandler, if any.
    /// CEF name: `GetResourceRequestHandler`
    func onGetResourceRequestHandler(browser: CEFBrowser,
                                     frame: CEFFrame,
                                     request: CEFRequest,
                                     isNavigation: Bool,
                                     isDownload: Bool,
                                     initiator: String,
                                     disableDefault: inout Bool) -> CEFResourceRequestHandler?
    
    /// Called on the IO thread when the browser needs credentials from the user.
    /// |origin_url| is the origin making this authentication request. |isProxy|
    /// indicates whether the host is a proxy server. |host| contains the hostname
    /// and |port| contains the port number. |realm| is the realm of the challenge
    /// and may be empty. |scheme| is the authentication scheme used, such as
    /// "basic" or "digest", and will be empty if the source of the request is an
    /// FTP server. Return true to continue the request and call
    /// CefAuthCallback::Continue() either in this method or at a later time when
    /// the authentication information is available. Return false to cancel the
    /// request immediately.
    /// CEF name: `GetAuthCredentials`
    func onAuthCredentialsRequired(browser: CEFBrowser,
                                   originURL: URL,
                                   isProxy: Bool,
                                   host: String,
                                   port: UInt16,
                                   realm: String?,
                                   scheme: String?,
                                   callback: CEFAuthCallback) -> CEFOnAuthCredentialsRequiredAction
    
    /// Called on the IO thread when JavaScript requests a specific storage quota
    /// size via the webkitStorageInfo.requestQuota function. |origin_url| is the
    /// origin of the page making the request. |new_size| is the requested quota
    /// size in bytes. Return true to continue the request and call
    /// CefRequestCallback::Continue() either in this method or at a later time to
    /// grant or deny the request. Return false to cancel the request immediately.
    /// CEF name: `OnQuotaRequest`
    func onQuotaRequest(browser: CEFBrowser,
                        origin: URL,
                        newSize: Int64,
                        callback: CEFRequestCallback) -> CEFOnQuotaRequestAction
    
    /// Called on the UI thread to handle requests for URLs with an invalid
    /// SSL certificate. Return true and call CefRequestCallback::Continue() either
    /// in this method or at a later time to continue or cancel the request. Return
    /// false to cancel the request immediately. If
    /// CefSettings.ignore_certificate_errors is set all invalid certificates will
    /// be accepted without calling this method.
    /// CEF name: `OnCertificateError`
    func onCertificateError(browser: CEFBrowser,
                            errorCode: CEFErrorCode,
                            url: URL,
                            sslInfo: CEFSSLInfo,
                            callback: CEFRequestCallback) -> CEFOnCertificateErrorAction
    
    /// Called on the UI thread when a client certificate is being requested for
    /// authentication. Return false to use the default behavior and automatically
    /// select the first certificate available. Return true and call
    /// CefSelectClientCertificateCallback::Select either in this method or at a
    /// later time to select a certificate. Do not call Select or call it with NULL
    /// to continue without using any certificate. |isProxy| indicates whether the
    /// host is an HTTPS proxy or the origin server. |host| and |port| contains the
    /// hostname and port of the SSL server. |certificates| is the list of
    /// certificates to choose from; this list has already been pruned by Chromium
    /// so that it only contains certificates from issuers that the server trusts.
    /// CEF name: `OnSelectClientCertificate`
    func onSelectClientCertificate(browser: CEFBrowser,
                                   isProxy: Bool,
                                   hostName: String,
                                   port: UInt16,
                                   certificates: [CEFX509Certificate],
                                   callback: CEFSelectClientCertificateCallback) -> CEFOnSelectClientCertificateAction
    
    /// Called on the browser process UI thread when a plugin has crashed.
    /// |plugin_path| is the path of the plugin that crashed.
    /// CEF name: `OnPluginCrashed`
    func onPluginCrashed(browser: CEFBrowser, pluginPath: String)
    
    /// Called on the browser process UI thread when the render view associated
    /// with |browser| is ready to receive/handle IPC messages in the render
    /// process.
    /// CEF name: `OnRenderViewReady`
    func onRenderViewReady(browser: CEFBrowser)
    
    /// Called on the browser process UI thread when the render process
    /// terminates unexpectedly. |status| indicates how the process
    /// terminated.
    /// CEF name: `OnRenderProcessTerminated`
    func onRenderProcessTerminated(browser: CEFBrowser, status: CEFTerminationStatus)

    /// Called on the browser process UI thread when the window.document object of
    /// the main frame has been created.
    /// CEF name: `OnDocumentAvailableInMainFrame`
    func onDocumentAvailableInMainFrame(browser: CEFBrowser)

}

public extension CEFRequestHandler {

    func onBeforeBrowse(browser: CEFBrowser,
                        frame: CEFFrame,
                        request: CEFRequest,
                        userGesture: Bool,
                        isRedirect: Bool) -> CEFOnBeforeBrowseAction {
        return .allow
    }

    func onOpenURLFromTab(browser: CEFBrowser,
                          frame: CEFFrame,
                          url: URL,
                          targetDisposition: CEFWindowOpenDisposition,
                          userGesture: Bool) -> CEFOnOpenURLFromTabAction {
        return .allow
    }

    func onGetResourceRequestHandler(browser: CEFBrowser,
                                     frame: CEFFrame,
                                     request: CEFRequest,
                                     isNavigation: Bool,
                                     isDownload: Bool,
                                     initiator: String,
                                     disableDefault: inout Bool) -> CEFResourceRequestHandler? {
        return nil
    }

    func onAuthCredentialsRequired(browser: CEFBrowser,
                                   originURL: URL,
                                   isProxy: Bool,
                                   host: String,
                                   port: UInt16,
                                   realm: String?,
                                   scheme: String?,
                                   callback: CEFAuthCallback) -> CEFOnAuthCredentialsRequiredAction {
        return .cancel
    }

    func onQuotaRequest(browser: CEFBrowser,
                        origin: URL,
                        newSize: Int64,
                        callback: CEFRequestCallback) -> CEFOnQuotaRequestAction {
        return .cancel
    }

    func onProtocolExecution(browser: CEFBrowser, url: URL, allowExecution: inout Bool) {
    }

    func onCertificateError(browser: CEFBrowser,
                            errorCode: CEFErrorCode,
                            url: URL,
                            sslInfo: CEFSSLInfo,
                            callback: CEFRequestCallback) -> CEFOnCertificateErrorAction {
        return .cancel
    }
    
    func onSelectClientCertificate(browser: CEFBrowser,
                                   isProxy: Bool,
                                   hostName: String,
                                   port: UInt16,
                                   certificates: [CEFX509Certificate],
                                   callback: CEFSelectClientCertificateCallback) -> CEFOnSelectClientCertificateAction {
        return .useDefault
    }

    func onPluginCrashed(browser: CEFBrowser, pluginPath: String) {
    }

    func onRenderViewReady(browser: CEFBrowser) {
    }

    func onRenderProcessTerminated(browser: CEFBrowser, status: CEFTerminationStatus) {
    }

    func onDocumentAvailableInMainFrame(browser: CEFBrowser) {
    }
}


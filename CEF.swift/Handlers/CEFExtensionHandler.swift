//
//  CEFExtensionHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 02..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnBeforeBackgroundBrowserAction {
    case allow
    case cancel
}

public enum CEFOnBeforeBrowserAction {
    case allow
    case cancel
}

public enum CEFOnGetExtensionResourceAction {
    case performCustom
    case performDefault
}

/// Implement this interface to handle events related to browser extensions.
/// The methods of this class will be called on the UI thread. See
/// CefRequestContext::LoadExtension for information about extension loading.
/// CEF name: `CefExtensionHandler`
public protocol CEFExtensionHandler {

    /// Called if the CefRequestContext::LoadExtension request fails. |result| will
    /// be the error code.
    /// CEF name: `OnExtensionLoadFailed`
    func onExtensionLoadFailed(errorCode: CEFErrorCode)

    /// Called if the CefRequestContext::LoadExtension request succeeds.
    /// |extension| is the loaded extension.
    /// CEF name: `OnExtensionLoaded`
    func onExtensionLoaded(extension: CEFExtension)
    
    /// Called after the CefExtension::Unload request has completed.
    /// CEF name: `OnExtensionUnloaded`
    func onExtensionUnloaded(extension: CEFExtension)

    /// Called when an extension needs a browser to host a background script
    /// specified via the "background" manifest key. The browser will have no
    /// visible window and cannot be displayed. |extension| is the extension that
    /// is loading the background script. |url| is an internally generated
    /// reference to an HTML page that will be used to load the background script
    /// via a <script> src attribute. To allow creation of the browser optionally
    /// modify |client| and |settings| and return false. To cancel creation of the
    /// browser (and consequently cancel load of the background script) return
    /// true. Successful creation will be indicated by a call to
    /// CefLifeSpanHandler::OnAfterCreated, and CefBrowserHost::IsBackgroundHost
    /// will return true for the resulting browser. See
    /// https://developer.chrome.com/extensions/event_pages for more information
    /// about extension background script usage.
    /// CEF name: `OnBeforeBackgroundBrowser`
    func onBeforeBackgroundBrowser(extension: CEFExtension,
                                   href: String,
                                   client: inout CEFClient,
                                   settings: inout CEFBrowserSettings) -> CEFOnBeforeBackgroundBrowserAction

    /// Called when an extension API (e.g. chrome.tabs.create) requests creation of
    /// a new browser. |extension| and |browser| are the source of the API call.
    /// |active_browser| may optionally be specified via the windowId property or
    /// returned via the GetActiveBrowser() callback and provides the default
    /// |client| and |settings| values for the new browser. |index| is the position
    /// value optionally specified via the index property. |url| is the URL that
    /// will be loaded in the browser. |active| is true if the new browser should
    /// be active when opened.  To allow creation of the browser optionally modify
    /// |windowInfo|, |client| and |settings| and return false. To cancel creation
    /// of the browser return true. Successful creation will be indicated by a call
    /// to CefLifeSpanHandler::OnAfterCreated. Any modifications to |windowInfo|
    /// will be ignored if |active_browser| is wrapped in a CefBrowserView.
    /// CEF name: `OnBeforeBrowser`
    func onBeforeBrowser(extension: CEFExtension,
                         browser: CEFBrowser,
                         activeBrowser: CEFBrowser,
                         index: Int,
                         url: NSURL,
                         activateOnOpen: Bool,
                         windowInfo: inout CEFWindowInfo,
                         client: inout CEFClient,
                         settings: inout CEFBrowserSettings) -> CEFOnBeforeBrowserAction

    /// Called when no tabId is specified to an extension API call that accepts a
    /// tabId parameter (e.g. chrome.tabs.*). |extension| and |browser| are the
    /// source of the API call. Return the browser that will be acted on by the API
    /// call or return NULL to act on |browser|. The returned browser must share
    /// the same CefRequestContext as |browser|. Incognito browsers should not be
    /// considered unless the source extension has incognito access enabled, in
    /// which case |include_incognito| will be true.
    /// CEF name: `GetActiveBrowser`
    func activeBrowser(for extension: CEFExtension,
                       browser: CEFBrowser,
                       includeIncognito: Bool) -> CEFBrowser?
    
    /// Called when the tabId associated with |target_browser| is specified to an
    /// extension API call that accepts a tabId parameter (e.g. chrome.tabs.*).
    /// |extension| and |browser| are the source of the API call. Return true
    /// to allow access of false to deny access. Access to incognito browsers
    /// should not be allowed unless the source extension has incognito access
    /// enabled, in which case |include_incognito| will be true.
    /// CEF name: `CanAccessBrowser`
    func canAccessBrowser(for extension: CEFExtension,
                          browser: CEFBrowser,
                          includeIncognito: Bool,
                          targetBrowser: CEFBrowser) -> Bool

    /// Called to retrieve an extension resource that would normally be loaded from
    /// disk (e.g. if a file parameter is specified to chrome.tabs.executeScript).
    /// |extension| and |browser| are the source of the resource request. |file| is
    /// the requested relative file path. To handle the resource request return
    /// true and execute |callback| either synchronously or asynchronously. For the
    /// default behavior which reads the resource from the extension directory on
    /// disk return false. Localization substitutions will not be applied to
    /// resources handled via this method.
    /// CEF name: `GetExtensionResource`
    func onGetExtensionResource(for extension: CEFExtension,
                                browser: CEFBrowser,
                                filePath: String,
                                callback: CEFGetExtensionResourceCallback) -> CEFOnGetExtensionResourceAction

}

public extension CEFExtensionHandler {

    func onExtensionLoadFailed(errorCode: CEFErrorCode) {
    }
    
    func onExtensionLoaded(extension: CEFExtension) {
    }
    
    func onExtensionUnloaded(extension: CEFExtension) {
    }
    
    func onBeforeBackgroundBrowser(extension: CEFExtension,
                                   href: String,
                                   client: inout CEFClient,
                                   settings: inout CEFBrowserSettings) -> CEFOnBeforeBackgroundBrowserAction {
        return .allow
    }
    
    func onBeforeBrowser(extension: CEFExtension,
                         browser: CEFBrowser,
                         activeBrowser: CEFBrowser,
                         index: Int,
                         url: NSURL,
                         activateOnOpen: Bool,
                         windowInfo: inout CEFWindowInfo,
                         client: inout CEFClient,
                         settings: inout CEFBrowserSettings) -> CEFOnBeforeBrowserAction {
        return .allow
    }
    
    func activeBrowser(for extension: CEFExtension,
                       browser: CEFBrowser,
                       includeIncognito: Bool) -> CEFBrowser? {
        return nil
    }
    
    func canAccessBrowser(for extension: CEFExtension,
                          browser: CEFBrowser,
                          includeIncognito: Bool,
                          targetBrowser: CEFBrowser) -> Bool {
        return true
    }
    
    func onGetExtensionResource(for extension: CEFExtension,
                                browser: CEFBrowser,
                                filePath: String,
                                callback: CEFGetExtensionResourceCallback) -> CEFOnGetExtensionResourceAction {
        return .performDefault
    }

}



//
//  CEFRequestContext.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFRequestContext {

    /// Returns the global context object.
    /// CEF name: `GetGlobalContext`
    public static var globalContext: CEFRequestContext? {
        let cefCtx = cef_request_context_get_global_context()
        return CEFRequestContext.fromCEF(cefCtx)
    }

    /// Creates a new context object with the specified |settings| and optional
    /// |handler|.
    /// CEF name: `CreateContext`
    public convenience init?(settings: CEFRequestContextSettings, handler: CEFRequestContextHandler? = nil) {
        var cefSettings = settings.toCEF()
        defer { cefSettings.clear() }

        let cefHandlerPtr = handler?.toCEF()
        let cefCtx = cef_request_context_create_context(&cefSettings, cefHandlerPtr)
        self.init(ptr: cefCtx)
    }

    /// Creates a new context object that shares storage with |other| and uses an
    /// optional |handler|.
    /// CEF name: `CreateContext`
    public static func createSharedWithContext(context: CEFRequestContext,
                                               handler: CEFRequestContextHandler? = nil) -> CEFRequestContext? {
        let cefHandlerPtr = handler?.toCEF()
        let cefCtx = cef_create_context_shared(context.toCEF(), cefHandlerPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }
    
    /// Returns true if this object is pointing to the same context as |that|
    /// object.
    /// CEF name: `IsSame`
    public func isSameAs(_ other: CEFRequestContext) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if this object is sharing the same storage as |that| object.
    /// CEF name: `IsSharingWith`
    public func isSharingStorageWithContext(other: CEFRequestContext) -> Bool {
        return cefObject.is_sharing_with(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns true if this object is the global context. The global context is
    /// used by default when creating a browser or URL request with a NULL context
    /// argument.
    /// CEF name: `IsGlobal`
    public var isGlobal: Bool {
        return cefObject.is_global(cefObjectPtr) != 0
    }
    
    /// Returns the handler for this context if any.
    /// CEF name: `GetHandler`
    public var handler: CEFRequestContextHandler? {
        let cefHandler = cefObject.get_handler(cefObjectPtr)
        return CEFRequestContextHandlerMarshaller.take(cefHandler)
    }

    /// Returns the cache path for this object. If empty an "incognito mode"
    /// in-memory cache is being used.
    /// CEF name: `GetCachePath`
    public var cachePath: String? {
        let cefStrPtr = cefObject.get_cache_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr!.pointee) : nil
    }
    
    /// Returns the default cookie manager for this object. This will be the global
    /// cookie manager if this object is the global request context. Otherwise,
    /// this will be the default cookie manager used when this request context does
    /// not receive a value via CefRequestContextHandler::GetCookieManager().
    /// CEF name: `GetDefaultCookieManager`
    public var defaultCookieManager: CEFCookieManager? {
        let cefCookieMgr = cefObject.get_default_cookie_manager(cefObjectPtr, nil)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }
    
    /// Returns the default cookie manager for this object. This will be the global
    /// cookie manager if this object is the global request context. Otherwise,
    /// this will be the default cookie manager used when this request context does
    /// not receive a value via CefRequestContextHandler::GetCookieManager(). If
    /// |callback| is non-NULL it will be executed asnychronously on the IO thread
    /// after the manager's storage has been initialized.
    /// CEF name: `GetDefaultCookieManager`
    public func getDefaultCookieManagerWithCallback(callback: CEFCompletionCallback? = nil) -> CEFCookieManager? {
        let cefCallbackPtr = callback?.toCEF()
        let cefCookieMgr = cefObject.get_default_cookie_manager(cefObjectPtr, cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }
    
    /// Register a scheme handler factory for the specified |scheme_name| and
    /// optional |domain_name|. An empty |domain_name| value for a standard scheme
    /// will cause the factory to match all domain names. The |domain_name| value
    /// will be ignored for non-standard schemes. If |scheme_name| is a built-in
    /// scheme and no handler is returned by |factory| then the built-in scheme
    /// handler factory will be called. If |scheme_name| is a custom scheme then
    /// you must also implement the CefApp::OnRegisterCustomSchemes() method in all
    /// processes. This function may be called multiple times to change or remove
    /// the factory that matches the specified |scheme_name| and optional
    /// |domain_name|. Returns false if an error occurs. This function may be
    /// called on any thread in the browser process.
    /// CEF name: `RegisterSchemeHandlerFactory`
    public func registerSchemeHandlerFactory(scheme: String, domain: String? = nil, factory: CEFSchemeHandlerFactory? = nil) -> Bool {
        let cefSchemePtr = CEFStringPtrCreateFromSwiftString(scheme)
        let cefDomainPtr = domain != nil ? CEFStringPtrCreateFromSwiftString(domain!) : nil
        defer {
            CEFStringPtrRelease(cefSchemePtr)
            CEFStringPtrRelease(cefDomainPtr)
        }

        let cefFactoryPtr = factory?.toCEF()
        
        return cefObject.register_scheme_handler_factory(cefObjectPtr, cefSchemePtr, cefDomainPtr, cefFactoryPtr) != 0
    }

    /// Clear all registered scheme handler factories. Returns false on error. This
    /// function may be called on any thread in the browser process.
    /// CEF name: `ClearSchemeHandlerFactories`
    public func clearSchemeHandlerFactories() -> Bool {
        return cefObject.clear_scheme_handler_factories(cefObjectPtr) != 0
    }

    /// Tells all renderer processes associated with this context to throw away
    /// their plugin list cache. If |reload_pages| is true they will also reload
    /// all pages with plugins. CefRequestContextHandler::OnBeforePluginLoad may
    /// be called to rebuild the plugin list cache.
    /// CEF name: `PurgePluginListCache`
    public func purgePluginListCacheWithReload(reload: Bool) {
        cefObject.purge_plugin_list_cache(cefObjectPtr, reload ? 1 : 0)
    }
    
    /// Returns true if a preference with the specified |name| exists. This method
    /// must be called on the browser process UI thread.
    /// CEF name: `HasPreference`
    public func hasPreference(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_preference(cefObjectPtr, cefStrPtr) != 0
    }
    
    /// Returns the value for the preference with the specified |name|. Returns
    /// NULL if the preference does not exist. The returned object contains a copy
    /// of the underlying preference value and modifications to the returned object
    /// will not modify the underlying preference value. This method must be called
    /// on the browser process UI thread.
    /// CEF name: `GetPreference`
    public func valueForPreference(name: String) -> CEFValue? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefValue = cefObject.get_preference(cefObjectPtr, cefStrPtr)
        return CEFValue.fromCEF(cefValue)
    }
    
    /// Returns all preferences as a dictionary. If |include_defaults| is true then
    /// preferences currently at their default value will be included. The returned
    /// object contains a copy of the underlying preference values and
    /// modifications to the returned object will not modify the underlying
    /// preference values. This method must be called on the browser process UI
    /// thread.
    /// CEF name: `GetAllPreferences`
    public func allPreferencesIncludingDefaults(includeDefaults: Bool) -> CEFDictionaryValue {
        let cefDict = cefObject.get_all_preferences(cefObjectPtr, includeDefaults ? 1 : 0)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }
    
    /// Returns true if the preference with the specified |name| can be modified
    /// using SetPreference. As one example preferences set via the command-line
    /// usually cannot be modified. This method must be called on the browser
    /// process UI thread.
    /// CEF name: `CanSetPreference`
    public func canSetPreference(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.can_set_preference(cefObjectPtr, cefStrPtr) != 0
    }
    
    /// Set the |value| associated with preference |name|. Returns true if the
    /// value is set successfully and false otherwise. If |value| is NULL the
    /// preference will be restored to its default value. If setting the preference
    /// fails then |error| will be populated with a detailed description of the
    /// problem. This method must be called on the browser process UI thread.
    /// CEF name: `SetPreference`
    public func setValue(value: CEFValue?, forPreference name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        let cefValue = value?.toCEF()
        return cefObject.set_preference(cefObjectPtr, cefStrPtr, cefValue, nil) != 0
    }

    /// Clears all certificate exceptions that were added as part of handling
    /// CefRequestHandler::OnCertificateError(). If you call this it is
    /// recommended that you also call CloseAllConnections() or you risk not
    /// being prompted again for server certificates if you reconnect quickly.
    /// If |callback| is non-NULL it will be executed on the UI thread after
    /// completion.
    /// CEF name: `ClearCertificateExceptions`
    public func clearCertificateExceptions(callback: CEFCompletionCallback? = nil) {
        let cefCallbackPtr = callback?.toCEF()
        cefObject.clear_certificate_exceptions(cefObjectPtr, cefCallbackPtr)
    }
    
    /// Clears all active and idle connections that Chromium currently has.
    /// This is only recommended if you have released all other CEF objects but
    /// don't yet want to call CefShutdown(). If |callback| is non-NULL it will be
    /// executed on the UI thread after completion.
    /// CEF name: `CloseAllConnections`
    public func closeAllConnections(callback: CEFCompletionCallback? = nil) {
        let cefCallbackPtr = callback?.toCEF()
        cefObject.close_all_connections(cefObjectPtr, cefCallbackPtr)
    }
    
    /// Attempts to resolve |origin| to a list of associated IP addresses.
    /// |callback| will be executed on the UI thread after completion.
    /// CEF name: `ResolveHost`
    public func resolveHost(hostName: String, callback: CEFResolveCallback) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(hostName)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.resolve_host(cefObjectPtr, cefStrPtr, callback.toCEF())
    }
    
    /// Attempts to resolve |origin| to a list of associated IP addresses using
    /// cached data. |resolved_ips| will be populated with the list of resolved IP
    /// addresses or empty if no cached data is available. Returns ERR_NONE on
    /// success. This method must be called on the browser process IO thread.
    /// CEF name: `ResolveHostCached`
    public func resolveCachedHost(hostName: String) -> [String]? {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(hostName)
        let cefList = cef_string_list_alloc()!
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringListRelease(cefList)
        }
        let errorCode = cefObject.resolve_host_cached(cefObjectPtr, cefStrPtr, cefList)
        
        return errorCode == ERR_NONE ? CEFStringListToSwiftArray(cefList) : nil
    }

}

public extension CEFRequestContext {
    
    /// Returns the default cookie manager for this object. This will be the global
    /// cookie manager if this object is the global request context. Otherwise,
    /// this will be the default cookie manager used when this request context does
    /// not receive a value via CefRequestContextHandler::GetCookieManager(). If
    /// |callback| is non-NULL it will be executed asnychronously on the IO thread
    /// after the manager's storage has been initialized.
    /// CEF name: `GetDefaultCookieManager`
    public func defaultCookieManager(block: @escaping CEFCompletionCallbackOnCompleteBlock) -> CEFCookieManager? {
        return getDefaultCookieManagerWithCallback(callback: CEFCompletionCallbackBridge(block: block))
    }
    
    /// Clears all certificate exceptions that were added as part of handling
    /// CefRequestHandler::OnCertificateError(). If you call this it is
    /// recommended that you also call CloseAllConnections() or you risk not
    /// being prompted again for server certificates if you reconnect quickly.
    /// If |callback| is non-NULL it will be executed on the UI thread after
    /// completion.
    /// CEF name: `ClearCertificateExceptions`
    func clearCertificateExceptions(block: @escaping CEFCompletionCallbackOnCompleteBlock) {
        clearCertificateExceptions(callback: CEFCompletionCallbackBridge(block: block))
    }
    
    /// Clears all active and idle connections that Chromium currently has.
    /// This is only recommended if you have released all other CEF objects but
    /// don't yet want to call CefShutdown(). If |callback| is non-NULL it will be
    /// executed on the UI thread after completion.
    /// CEF name: `CloseAllConnections`
    public func closeAllConnections(block: @escaping CEFCompletionCallbackOnCompleteBlock) {
        closeAllConnections(callback: CEFCompletionCallbackBridge(block: block))
    }
    
    /// Attempts to resolve |origin| to a list of associated IP addresses.
    /// |callback| will be executed on the UI thread after completion.
    /// CEF name: `ResolveHost`
    public func resolveHost(hostName: String, block: @escaping CEFResolveCallbackOnResolveCompletedBlock) {
        resolveHost(hostName: hostName, callback: CEFResolveCallbackBridge(block: block))
    }
}


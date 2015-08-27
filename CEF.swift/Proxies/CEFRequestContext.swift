//
//  CEFRequestContext.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_request_context_t: CEFObject {
}

///
// A request context provides request handling for a set of related browser
// or URL request objects. A request context can be specified when creating a
// new browser via the CefBrowserHost static factory methods or when creating a
// new URL request via the CefURLRequest static factory methods. Browser objects
// with different request contexts will never be hosted in the same render
// process. Browser objects with the same request context may or may not be
// hosted in the same render process depending on the process model. Browser
// objects created indirectly via the JavaScript window.open function or
// targeted links will share the same render process and the same request
// context as the source browser. When running in single-process mode there is
// only a single render process (the main process) and so all browsers created
// in single-process mode will share the same request context. This will be the
// first request context passed into a CefBrowserHost static factory method and
// all other request context objects will be ignored.
///
public class CEFRequestContext: CEFProxy<cef_request_context_t> {

    ///
    // Returns the global context object.
    ///
    public static func getGlobalContext() -> CEFRequestContext? {
        let cefCtx = cef_request_context_get_global_context()
        return CEFRequestContext.fromCEF(cefCtx)
    }

    ///
    // Creates a new context object with the specified |settings| and optional
    // |handler|.
    ///
    public static func createContext(settings: CEFRequestContextSettings,
                                     handler: CEFRequestContextHandler? = nil) -> CEFRequestContext? {
        var cefSettings = settings.toCEF()
        defer { cefSettings.clear() }

        var cefHandlerPtr: UnsafeMutablePointer<cef_request_context_handler_t> = nil
        if let handler = handler {
            cefHandlerPtr = handler.toCEF()
        }

        let cefCtx = cef_request_context_create_context(&cefSettings, cefHandlerPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }

    ///
    // Creates a new context object that shares storage with |other| and uses an
    // optional |handler|.
    ///
    public static func createSharedContext(context: CEFRequestContext,
                                           handler: CEFRequestContextHandler? = nil) -> CEFRequestContext? {
        var cefHandlerPtr: UnsafeMutablePointer<cef_request_context_handler_t> = nil
        if let handler = handler {
            cefHandlerPtr = handler.toCEF()
        }
        
        let cefCtx = create_context_shared(context.toCEF(), cefHandlerPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }
    
    ///
    // Returns true if this object is pointing to the same context as |that|
    // object.
    ///
    public func isSame(other: CEFRequestContext) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    ///
    // Returns true if this object is sharing the same storage as |that| object.
    ///
    public func isSharingWith(other: CEFRequestContext) -> Bool {
        return cefObject.is_sharing_with(cefObjectPtr, other.toCEF()) != 0
    }
    
    ///
    // Returns true if this object is the global context. The global context is
    // used by default when creating a browser or URL request with a NULL context
    // argument.
    ///
    public func isGlobal() -> Bool {
        return cefObject.is_global(cefObjectPtr) != 0
    }
    
    ///
    // Returns the handler for this context if any.
    ///
    public func getHandler() -> CEFRequestContextHandler? {
        let cefHandler = cefObject.get_handler(cefObjectPtr)
        return CEFRequestContextHandlerMarshaller.take(cefHandler)
    }

    ///
    // Returns the cache path for this object. If empty an "incognito mode"
    // in-memory cache is being used.
    ///
    public func getCachePath() -> String {
        let cefStrPtr = cefObject.get_cache_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the default cookie manager for this object. This will be the global
    // cookie manager if this object is the global request context. Otherwise,
    // this will be the default cookie manager used when this request context does
    // not receive a value via CefRequestContextHandler::GetCookieManager(). If
    // |callback| is non-NULL it will be executed asnychronously on the IO thread
    // after the manager's storage has been initialized.
    ///
    public func getDefaultCookieManager(callback: CEFCompletionCallback? = nil) -> CEFCookieManager? {
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        let cefCookieMgr = cefObject.get_default_cookie_manager(cefObjectPtr, cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }
    
    ///
    // Register a scheme handler factory for the specified |scheme_name| and
    // optional |domain_name|. An empty |domain_name| value for a standard scheme
    // will cause the factory to match all domain names. The |domain_name| value
    // will be ignored for non-standard schemes. If |scheme_name| is a built-in
    // scheme and no handler is returned by |factory| then the built-in scheme
    // handler factory will be called. If |scheme_name| is a custom scheme then
    // you must also implement the CefApp::OnRegisterCustomSchemes() method in all
    // processes. This function may be called multiple times to change or remove
    // the factory that matches the specified |scheme_name| and optional
    // |domain_name|. Returns false if an error occurs. This function may be
    // called on any thread in the browser process.
    ///
    public func registerSchemeHandlerFactory(scheme: String, domain: String? = nil, factory: CEFSchemeHandlerFactory? = nil) -> Bool {
        let cefSchemePtr = CEFStringPtrCreateFromSwiftString(scheme)
        let cefDomainPtr = domain != nil ? CEFStringPtrCreateFromSwiftString(domain!) : nil
        defer {
            CEFStringPtrRelease(cefSchemePtr)
            CEFStringPtrRelease(cefDomainPtr)
        }

        var cefFactoryPtr: UnsafeMutablePointer<cef_scheme_handler_factory_t> = nil
        if let factory = factory {
            cefFactoryPtr = factory.toCEF()
        }
        
        return cefObject.register_scheme_handler_factory(cefObjectPtr, cefSchemePtr, cefDomainPtr, cefFactoryPtr) != 0
    }

    ///
    // Clear all registered scheme handler factories. Returns false on error. This
    // function may be called on any thread in the browser process.
    ///
    public func clearSchemeHandlerFactories() -> Bool {
        return cefObject.clear_scheme_handler_factories(cefObjectPtr) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFRequestContext? {
        return CEFRequestContext(ptr: ptr)
    }
}

public extension CEFRequestContext {
    
    ///
    // Returns the default cookie manager for this object. This will be the global
    // cookie manager if this object is the global request context. Otherwise,
    // this will be the default cookie manager used when this request context does
    // not receive a value via CefRequestContextHandler::GetCookieManager(). If
    // |callback| is non-NULL it will be executed asnychronously on the IO thread
    // after the manager's storage has been initialized.
    ///
    public func getDefaultCookieManager(block: CEFCompletionCallbackOnCompleteBlock) -> CEFCookieManager? {
        return getDefaultCookieManager(CEFCompletionCallbackBridge(block: block))
    }
    
}


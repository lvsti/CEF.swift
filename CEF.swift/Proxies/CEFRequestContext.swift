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

public class CEFRequestContext: CEFProxy<cef_request_context_t> {

    public static func getGlobalContext() -> CEFRequestContext? {
        let cefCtx = cef_request_context_get_global_context()
        return CEFRequestContext.fromCEF(cefCtx)
    }

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

    public static func createSharedContext(context: CEFRequestContext,
                                           handler: CEFRequestContextHandler? = nil) -> CEFRequestContext? {
        var cefHandlerPtr: UnsafeMutablePointer<cef_request_context_handler_t> = nil
        if let handler = handler {
            cefHandlerPtr = handler.toCEF()
        }
        
        let cefCtx = create_context_shared(context.toCEF(), cefHandlerPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }
    
    public func isSame(other: CEFRequestContext) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    public func isSharingWith(other: CEFRequestContext) -> Bool {
        return cefObject.is_sharing_with(cefObjectPtr, other.toCEF()) != 0
    }
    
    public func isGlobal() -> Bool {
        return cefObject.is_global(cefObjectPtr) != 0
    }
    
    public func getHandler() -> CEFRequestContextHandler? {
        let cefHandler = cefObject.get_handler(cefObjectPtr)
        return cefHandler.toSwift()
    }

    public func getCachePath() -> String {
        let cefStrPtr = cefObject.get_cache_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getDefaultCookieManager(callback: CEFCompletionCallback? = nil) -> CEFCookieManager? {
        var cefCallbackPtr: UnsafeMutablePointer<cef_completion_callback_t> = nil
        if let callback = callback {
            cefCallbackPtr = callback.toCEF()
        }
        
        let cefCookieMgr = cefObject.get_default_cookie_manager(cefObjectPtr, cefCallbackPtr)
        return CEFCookieManager.fromCEF(cefCookieMgr)
    }
    
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


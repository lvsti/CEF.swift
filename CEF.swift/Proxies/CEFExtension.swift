//
//  CEFExtension.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 02..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFExtension {
    
    typealias ID = String
    
    /// Returns the unique extension identifier. This is calculated based on the
    /// extension public key, if available, or on the extension path. See
    /// https://developer.chrome.com/extensions/manifest/key for details.
    /// CEF name: `GetIdentifier`
    public var identifier: ID {
        let cefStr = cefObject.get_identifier(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStr) }
        return CEFStringToSwiftString(cefStr!.pointee)
    }
    
    /// Returns the absolute path to the extension directory on disk. This value
    /// will be prefixed with PK_DIR_RESOURCES if a relative path was passed to
    /// CefRequestContext::LoadExtension.
    /// CEF name: `GetPath`
    public var path: String {
        let cefStr = cefObject.get_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStr) }
        return CEFStringToSwiftString(cefStr!.pointee)
    }
    
    /// Returns the extension manifest contents as a CefDictionaryValue object. See
    /// https://developer.chrome.com/extensions/manifest for details.
    /// CEF name: `GetManifest`
    public var manifest: CEFDictionaryValue {
        let cefDict = cefObject.get_manifest(cefObjectPtr)
        return CEFDictionaryValue.fromCEF(cefDict)!
    }
    
    /// Returns true if this object is the same extension as |that| object.
    /// Extensions are considered the same if identifier, path and loader context
    /// match.
    /// CEF name: `IsSame`
    public func isSameAs(_ other: CEFExtension) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns the handler for this extension. Will return NULL for internal
    /// extensions or if no handler was passed to CefRequestContext::LoadExtension.
    /// CEF name: `GetHandler`
    public var handler: CEFExtensionHandler? {
        let cefHandler = cefObject.get_handler(cefObjectPtr)
        return CEFExtensionHandlerMarshaller.take(cefHandler)
    }
    
    /// Returns the request context that loaded this extension. Will return NULL
    /// for internal extensions or if the extension has been unloaded. See the
    /// CefRequestContext::LoadExtension documentation for more information about
    /// loader contexts. Must be called on the browser process UI thread.
    /// CEF name: `GetLoaderContext`
    public var loaderContext: CEFRequestContext? {
        let cefCtx = cefObject.get_loader_context(cefObjectPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }
    
    /// Returns true if this extension is currently loaded. Must be called on the
    /// browser process UI thread.
    /// CEF name: `IsLoaded`
    public var isLoaded: Bool {
        return cefObject.is_loaded(cefObjectPtr) != 0
    }
    
    /// Unload this extension if it is not an internal extension and is currently
    /// loaded. Will result in a call to CefExtensionHandler::OnExtensionUnloaded
    /// on success.
    /// CEF name: `Unload`
    public func unload() {
        cefObject.unload(cefObjectPtr)
    }
    
}

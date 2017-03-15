//
//  CEFBrowser.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFBrowser {
    public typealias Identifier = Int32
    
    /// Returns the browser host object. This method can only be called in the
    /// browser process.
    /// CEF name: `GetHost`
    public var host: CEFBrowserHost? {
        let cefHost = cefObject.get_host(cefObjectPtr)
        return CEFBrowserHost.fromCEF(cefHost)
    }
    
    /// Returns true if the browser can navigate backwards.
    /// CEF name: `CanGoBack`
    public var canGoBack: Bool {
        return cefObject.can_go_back(cefObjectPtr) != 0
    }

    /// Navigate backwards.
    /// CEF name: `GoBack`
    public func goBack() {
        cefObject.go_back(cefObjectPtr)
    }
    
    /// Returns true if the browser can navigate forwards.
    /// CEF name: `CanGoForward`
    public var canGoForward: Bool {
        return cefObject.can_go_forward(cefObjectPtr) != 0
    }

    /// Navigate forwards.
    /// CEF name: `GoForward`
    public func goForward() {
        cefObject.go_forward(cefObjectPtr)
    }
    
    /// Returns true if the browser is currently loading.
    /// CEF name: `IsLoading`
    public var isLoading: Bool {
        return cefObject.is_loading(cefObjectPtr) != 0
    }

    /// Reload the current page.
    /// CEF name: `Reload`, `ReloadIgnoreCache`
    public func reload(ignoringCache ignore: Bool = false) {
        if ignore {
            cefObject.reload_ignore_cache(cefObjectPtr)
        }
        else {
            cefObject.reload(cefObjectPtr)
        }
    }

    /// Stop loading the page.
    /// CEF name: `StopLoad`
    public func stopLoad() {
        cefObject.stop_load(cefObjectPtr)
    }

    /// Returns the globally unique identifier for this browser.
    /// CEF name: `GetIdentifier`
    public var identifier: Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    /// Returns true if this object is pointing to the same handle as |that|
    /// object.
    /// CEF name: `IsSame`
    public func isSameAs(_ other: CEFBrowser) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if the window is a popup window.
    /// CEF name: `IsPopup`
    public var isPopup: Bool {
        return cefObject.is_popup(cefObjectPtr) != 0
    }
    
    /// Returns true if a document has been loaded in the browser.
    /// CEF name: `HasDocument`
    public var hasDocument: Bool {
        return cefObject.has_document(cefObjectPtr) != 0
    }
    
    /// Returns the main (top-level) frame for the browser window.
    /// CEF name: `GetMainFrame`
    public var mainFrame: CEFFrame? {
        // TODO: audit nonnull
        let cefFrame = cefObject.get_main_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    /// Returns the focused frame for the browser window.
    /// CEF name: `GetFocusedFrame`
    public var focusedFrame: CEFFrame? {
        // TODO: audit nonnull
        let cefFrame = cefObject.get_focused_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    /// Returns the frame with the specified identifier, or NULL if not found.
    /// CEF name: `GetFrame`
    public func frame(id: CEFFrame.Identifier) -> CEFFrame? {
        let cefFrame = cefObject.get_frame_byident(cefObjectPtr, id)
        return CEFFrame.fromCEF(cefFrame)
    }

    /// Returns the frame with the specified name, or NULL if not found.
    /// CEF name: `GetFrame`
    public func frame(named: String) -> CEFFrame? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(named)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        let cefFrame = cefObject.get_frame(cefObjectPtr, cefNamePtr)
        return CEFFrame.fromCEF(cefFrame)
    }

    /// Returns the number of frames that currently exist.
    /// CEF name: `GetFrameCount`
    public var frameCount: Int {
        return Int(cefObject.get_frame_count(cefObjectPtr))
    }

    /// Returns the identifiers of all existing frames.
    /// CEF name: `GetFrameIdentifiers`
    public var frameIDs: [CEFFrame.Identifier] {
        var idCount: size_t = 0
        let idsPtr: UnsafeMutablePointer<CEFFrame.Identifier>? = nil
        cefObject.get_frame_identifiers(cefObjectPtr, &idCount, idsPtr)
        
        var ids = Array<CEFFrame.Identifier>()
        for i in 0..<idCount {
            ids.append(idsPtr!.advanced(by: i).pointee)
        }
        return ids
    }

    /// Returns the names of all existing frames.
    /// CEF name: `GetFrameNames`
    public var frameNames: [String] {
        let cefList = cef_string_list_alloc()!
        defer { cef_string_list_free(cefList) }
        
        cefObject.get_frame_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }

    /// Send a message to the specified |target_process|. Returns true if the
    /// message was sent successfully.
    /// CEF name: `SendProcessMessage`
    @discardableResult
    public func sendProcessMessage(targetProcessID: CEFProcessID, message: CEFProcessMessage) -> Bool {
        return cefObject.send_process_message(cefObjectPtr, targetProcessID.toCEF(), message.toCEF()) != 0
    }

}


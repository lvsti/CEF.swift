//
//  CEFBrowser.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_browser_t: CEFObject {
}

/// Class used to represent a browser window. When used in the browser process
/// the methods of this class may be called on any thread unless otherwise
/// indicated in the comments. When used in the render process the methods of
/// this class may only be called on the main thread.
public class CEFBrowser : CEFProxy<cef_browser_t> {
    public typealias Identifier = Int32
    
    /// Returns the browser host object. This method can only be called in the
    /// browser process.
    public func getHost() -> CEFBrowserHost? {
        let cefHost = cefObject.get_host(cefObjectPtr)
        return CEFBrowserHost.fromCEF(cefHost)
    }
    
    /// Returns true if the browser can navigate backwards.
    public func canGoBack() -> Bool {
        return cefObject.can_go_back(cefObjectPtr) != 0
    }

    /// Navigate backwards.
    public func goBack() {
        cefObject.go_back(cefObjectPtr)
    }
    
    /// Returns true if the browser can navigate forwards.
    public func canGoForward() -> Bool {
        return cefObject.can_go_forward(cefObjectPtr) != 0
    }

    /// Navigate forwards.
    public func goForward() {
        cefObject.go_forward(cefObjectPtr)
    }
    
    /// Returns true if the browser is currently loading.
    public func isLoading() -> Bool {
        return cefObject.is_loading(cefObjectPtr) != 0
    }

    /// Reload the current page.
    public func reload(ignoringCache: Bool = false) {
        if ignoringCache {
            cefObject.reload_ignore_cache(cefObjectPtr)
        }
        else {
            cefObject.reload(cefObjectPtr)
        }
    }

    /// Stop loading the page.
    public func stopLoad() {
        cefObject.stop_load(cefObjectPtr)
    }

    /// Returns the globally unique identifier for this browser.
    public func getIdentifier() -> Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    /// Returns true if this object is pointing to the same handle as |that|
    /// object.
    public func isSame(other: CEFBrowser) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    /// Returns true if the window is a popup window.
    public func isPopup() -> Bool {
        return cefObject.is_popup(cefObjectPtr) != 0
    }
    
    /// Returns true if a document has been loaded in the browser.
    public func hasDocument() -> Bool {
        return cefObject.has_document(cefObjectPtr) != 0
    }
    
    /// Returns the main (top-level) frame for the browser window.
    public func getMainFrame() -> CEFFrame? {
        let cefFrame = cefObject.get_main_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    /// Returns the focused frame for the browser window.
    public func getFocusedFrame() -> CEFFrame? {
        let cefFrame = cefObject.get_focused_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    /// Returns the frame with the specified identifier, or NULL if not found.
    public func getFrame(byID id: CEFFrame.Identifier) -> CEFFrame? {
        let cefFrame = cefObject.get_frame_byident(cefObjectPtr, id)
        return CEFFrame.fromCEF(cefFrame)
    }

    /// Returns the frame with the specified name, or NULL if not found.
    public func getFrame(byName name: String) -> CEFFrame? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        let cefFrame = cefObject.get_frame(cefObjectPtr, cefNamePtr)
        return CEFFrame.fromCEF(cefFrame)
    }

    /// Returns the number of frames that currently exist.
    public func getFrameCount() -> size_t {
        return cefObject.get_frame_count(cefObjectPtr)
    }

    /// Returns the identifiers of all existing frames.
    public func getFrameIDs() -> [CEFFrame.Identifier] {
        var idCount:size_t = 0
        let idsPtr:UnsafeMutablePointer<CEFFrame.Identifier> = nil
        cefObject.get_frame_identifiers(cefObjectPtr, &idCount, idsPtr)
        
        var ids = Array<CEFFrame.Identifier>()
        for i in 0..<idCount {
            ids.append(idsPtr.advancedBy(i).memory)
        }
        return ids
    }

    /// Returns the names of all existing frames.
    public func getFrameNames() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        
        cefObject.get_frame_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }

    //
    // Send a message to the specified |target_process|. Returns true if the
    // message was sent successfully.
    ///
    public func sendProcessMessage(targetProcessID: CEFProcessID, message: CEFProcessMessage) -> Bool {
        return cefObject.send_process_message(cefObjectPtr, targetProcessID.toCEF(), message.toCEF()) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFBrowser? {
        return CEFBrowser(ptr: ptr)
    }

}


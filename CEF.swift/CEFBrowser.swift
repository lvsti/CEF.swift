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

public class CEFBrowser : CEFProxyBase<cef_browser_t> {
    typealias Identifier = Int32
    
    func getHost() -> CEFBrowserHost? {
        let cefHost = cefObject.get_host(cefObjectPtr)
        return CEFBrowserHost.fromCEF(cefHost)
    }
    
    func canGoBack() -> Bool {
        return cefObject.can_go_back(cefObjectPtr) != 0
    }

    func goBack() {
        cefObject.go_back(cefObjectPtr)
    }
    
    func canGoForward() -> Bool {
        return cefObject.can_go_forward(cefObjectPtr) != 0
    }

    func goForward() {
        cefObject.go_forward(cefObjectPtr)
    }
    
    func isLoading() -> Bool {
        return cefObject.is_loading(cefObjectPtr) != 0
    }

    func reload(ignoringCache: Bool = false) {
        if ignoringCache {
            cefObject.reload_ignore_cache(cefObjectPtr)
        }
        else {
            cefObject.reload(cefObjectPtr)
        }
    }

    func stopLoad() {
        cefObject.stop_load(cefObjectPtr)
    }

    func getIdentifier() -> Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    func isSame(other: CEFBrowser) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }

    func isPopup() -> Bool {
        return cefObject.is_popup(cefObjectPtr) != 0
    }
    
    func hasDocument() -> Bool {
        return cefObject.has_document(cefObjectPtr) != 0
    }
    
    func getMainFrame() -> CEFFrame? {
        let cefFrame = cefObject.get_main_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    func getFocusedFrame() -> CEFFrame? {
        let cefFrame = cefObject.get_focused_frame(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    func getFrame(byID id: CEFFrame.Identifier) -> CEFFrame? {
        let cefFrame = cefObject.get_frame_byident(cefObjectPtr, id)
        return CEFFrame.fromCEF(cefFrame)
    }

    func getFrame(byName name: String) -> CEFFrame? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        let cefFrame = cefObject.get_frame(cefObjectPtr, cefNamePtr)
        return CEFFrame.fromCEF(cefFrame)
    }

    func getFrameCount() -> size_t {
        return cefObject.get_frame_count(cefObjectPtr)
    }

    func getFrameIDs() -> [CEFFrame.Identifier] {
        var idCount:size_t = 0
        let idsPtr:UnsafeMutablePointer<CEFFrame.Identifier> = nil
        cefObject.get_frame_identifiers(cefObjectPtr, &idCount, idsPtr)
        
        var ids = Array<CEFFrame.Identifier>()
        for i in 0..<idCount {
            ids.append(idsPtr.advancedBy(i).memory)
        }
        return ids
    }

    func getFrameNames() -> [String] {
        let cefList = cef_string_list_alloc()
        defer { cef_string_list_free(cefList) }
        
        cefObject.get_frame_names(cefObjectPtr, cefList)
        return CEFStringListToSwiftArray(cefList)
    }

    func sendProcessMessage(targetProcessID: CEFProcessID, message: CEFProcessMessage) -> Bool {
        return cefObject.send_process_message(cefObjectPtr, targetProcessID.toCEF(), message.toCEF()) != 0
    }

}


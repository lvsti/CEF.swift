//
//  CEFBrowserHost.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


extension cef_browser_host_t: CEFObject {
}

public class CEFBrowserHost : CEFProxy<cef_browser_host_t> {

    public static func createBrowser(windowInfo: CEFWindowInfo,
                                     client: CEFClient? = nil,
                                     url: NSURL? = nil,
                                     settings: CEFBrowserSettings,
                                     requestContext: CEFRequestContext? = nil) -> Bool {
        var cefSettings = settings.toCEF()
        let cefURLPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        var cefWinInfo = windowInfo.toCEF()
        let cefClient = client != nil ? client!.toCEF() : nil
        let cefReqCtx = requestContext != nil ? requestContext!.toCEF() : nil
        
        defer {
            cefSettings.clear()
            CEFStringPtrRelease(cefURLPtr)
            cefWinInfo.clear()
        }
        
        return cef_browser_host_create_browser(&cefWinInfo, cefClient, cefURLPtr, &cefSettings, cefReqCtx) != 0
    }

    public static func createBrowserSync(windowInfo: CEFWindowInfo,
                                         client: CEFClient? = nil,
                                         url: NSURL? = nil,
                                         settings: CEFBrowserSettings,
                                         requestContext: CEFRequestContext? = nil) -> CEFBrowser? {
        var cefSettings = settings.toCEF()
        let cefURLPtr = url != nil ? CEFStringPtrCreateFromSwiftString(url!.absoluteString) : nil
        var cefWinInfo = windowInfo.toCEF()
        let cefClient = client != nil ? client!.toCEF() : nil
        let cefReqCtx = requestContext != nil ? requestContext!.toCEF() : nil
        
        defer {
            cefSettings.clear()
            CEFStringPtrRelease(cefURLPtr)
            cefWinInfo.clear()
        }
        
        let cefBrowser = cef_browser_host_create_browser_sync(&cefWinInfo, cefClient, cefURLPtr, &cefSettings, cefReqCtx)
        return CEFBrowser.fromCEF(cefBrowser)
    }

    public func getBrowser() -> CEFBrowser? {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return CEFBrowser.fromCEF(cefBrowser)
    }
    
    public func closeBrowser(force: Bool) {
        cefObject.close_browser(cefObjectPtr, force ? 1 : 0)
    }

    public func setFocused(focused: Bool) {
        cefObject.set_focus(cefObjectPtr, focused ? 1 : 0)
    }

    public func setWindowVisibility(visible: Bool) {
        cefObject.set_window_visibility(cefObjectPtr, visible ? 1 : 0)
    }

    public func getWindowHandle() -> CEFWindowHandle {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_window_handle(cefObjectPtr)
        return Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }
    
    public func getOpenerWindowHandle() -> CEFWindowHandle {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_opener_window_handle(cefObjectPtr)
        return Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }
    
    public func getClient() -> CEFClient? {
        let cefClient = cefObject.get_client(cefObjectPtr)
        return CEFClientMarshaller.take(cefClient)
    }

    public func getRequestContext() -> CEFRequestContext? {
        let cefCtx = cefObject.get_request_context(cefObjectPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }

    public func getZoomLevel() -> Double {
        return cefObject.get_zoom_level(cefObjectPtr)
    }
    
    public func setZoomLevel(zoomLevel: Double) {
        cefObject.set_zoom_level(cefObjectPtr, zoomLevel)
    }

    public func runFileDialog(mode: CEFFileDialogMode,
                              title: String?,
                              defaultPath: String?,
                              acceptFilters: [String],
                              selectedFilterIndex: Int,
                              callback: CEFRunFileDialogCallback) {
        let cefTitle = CEFStringPtrCreateFromSwiftString(title ?? "")
        let cefPath = CEFStringPtrCreateFromSwiftString(defaultPath ?? "")
        let cefFilterList = CEFStringListCreateFromSwiftArray(acceptFilters)
        
        defer {
            CEFStringPtrRelease(cefTitle)
            CEFStringPtrRelease(cefPath)
            cef_string_list_free(cefFilterList)
        }

        cefObject.run_file_dialog(cefObjectPtr,
                                  mode.toCEF(),
                                  cefTitle,
                                  cefPath,
                                  cefFilterList,
                                  Int32(selectedFilterIndex),
                                  callback.toCEF())
    }
    
    public func startDownload(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.start_download(cefObjectPtr, cefURLPtr)
    }

    public func print() {
        cefObject.print(cefObjectPtr)
    }

    public func find(identifier: CEFFindIdentifier, searchText: String, forward: Bool, caseSensitive: Bool, findNext: Bool) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(searchText)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.find(cefObjectPtr, identifier, cefStrPtr, forward ? 1 : 0, caseSensitive ? 1 : 0, findNext ? 1 : 0)
    }
    
    public func stopFinding(clearSelection: Bool) {
        cefObject.stop_finding(cefObjectPtr, clearSelection ? 1 : 0)
    }
    
    public func showDevTools(windowInfo: CEFWindowInfo,
                             client: CEFClient,
                             settings: CEFBrowserSettings,
                             inspectionPoint: NSPoint?) {
        var cefPointPtr: UnsafeMutablePointer<cef_point_t> = nil
        if let inspectionPoint = inspectionPoint {
            cefPointPtr = UnsafeMutablePointer<cef_point_t>.alloc(1)
            defer { cefPointPtr.destroy(1) }
            cefPointPtr.initialize(inspectionPoint.toCEF())
        }

        var cefSettings = settings.toCEF()
        var cefWinInfo = windowInfo.toCEF()
        defer {
            cefSettings.clear()
            cefWinInfo.clear()
        }
        cefObject.show_dev_tools(cefObjectPtr, &cefWinInfo, client.toCEF(), &cefSettings, cefPointPtr)
    }
    
    public func closeDevTools() {
        cefObject.close_dev_tools(cefObjectPtr)
    }

    public func getNavigationEntries(visitor: CEFNavigationEntryVisitor, currentOnly: Bool) {
        cefObject.get_navigation_entries(cefObjectPtr, visitor.toCEF(), currentOnly ? 1 : 0)
    }
    
    public func setMouseCursorChangeDisabled(value: Bool) {
        cefObject.set_mouse_cursor_change_disabled(cefObjectPtr, value ? 1 : 0)
    }
    
    public func isMouseCursorChangeDisabled() -> Bool {
        return cefObject.is_mouse_cursor_change_disabled(cefObjectPtr) != 0
    }

    public func replaceMisspelling(replacementWord: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(replacementWord)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.replace_misspelling(cefObjectPtr, cefStrPtr)
    }

    public func addWordToDictionary(word: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(word)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.add_word_to_dictionary(cefObjectPtr, cefStrPtr)
    }
    
    public func isWindowRenderingDisabled() -> Bool {
        return cefObject.is_window_rendering_disabled(cefObjectPtr) != 0
    }
    
    public func notifyWasResized() {
        cefObject.was_resized(cefObjectPtr)
    }
    
    public func notifyWasHidden(hidden: Bool) {
        cefObject.was_hidden(cefObjectPtr, hidden ? 1 : 0)
    }

    public func notifyScreenInfoChanged() {
        cefObject.notify_screen_info_changed(cefObjectPtr)
    }

    public func invalidate(element: CEFPaintElementType) {
        cefObject.invalidate(cefObjectPtr, element.toCEF())
    }

    public func sendKeyEvent(event: CEFKeyEvent) {
        var cefEvent = event.toCEF()
        cefObject.send_key_event(cefObjectPtr, &cefEvent)
    }

    public func sendMouseClickEvent(event: CEFMouseEvent, type: CEFMouseButtonType, mouseUp: Bool, clickCount: Int) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_click_event(cefObjectPtr, &cefEvent, type.toCEF(), mouseUp ? 1 : 0, Int32(clickCount))
    }

    public func sendMouseMoveEvent(event: CEFMouseEvent, mouseLeave: Bool) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_move_event(cefObjectPtr, &cefEvent, mouseLeave ? 1 : 0)
    }

    public func sendMouseWheelEvent(event: CEFMouseEvent, deltaX: Int, deltaY: Int) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_wheel_event(cefObjectPtr, &cefEvent, Int32(deltaX), Int32(deltaY))
    }
    
    public func sendFocusEvent(focus: Bool) {
        cefObject.send_focus_event(cefObjectPtr, focus ? 1 : 0)
    }
    
    public func sendCaptureLostEvent() {
        cefObject.send_capture_lost_event(cefObjectPtr)
    }

    public func notifyMoveOrResizeStarted() {
        cefObject.notify_move_or_resize_started(cefObjectPtr)
    }
    
    public func getNSTextInputContext() -> CEFTextInputContext {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_nstext_input_context(cefObjectPtr)
        return Unmanaged<CEFTextInputContext>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }

    public func handleKeyEventBeforeTextInputClient(event: CEFEventHandle) {
        let rawEvent = UnsafeMutablePointer<Void>(Unmanaged<CEFEventHandle>.passUnretained(event).toOpaque())
        cefObject.handle_key_event_before_text_input_client(cefObjectPtr, rawEvent)
    }
    
    public func handleKeyEventAfterTextInputClient(event: CEFEventHandle) {
        let rawEvent = UnsafeMutablePointer<Void>(Unmanaged<CEFEventHandle>.passUnretained(event).toOpaque())
        cefObject.handle_key_event_after_text_input_client(cefObjectPtr, rawEvent)
    }

    public func dragTargetDragEnter(dragData: CEFDragData, event: CEFMouseEvent, operationMask: CEFDragOperationsMask) {
        let cefDragData = dragData.toCEF()
        var cefEvent = event.toCEF()
        cefObject.drag_target_drag_enter(cefObjectPtr, cefDragData, &cefEvent, operationMask.toCEF())
    }
    
    public func dragTargetDragOver(event: CEFMouseEvent, operationMask: CEFDragOperationsMask) {
        var cefEvent = event.toCEF()
        cefObject.drag_target_drag_over(cefObjectPtr, &cefEvent, operationMask.toCEF())
    }
    
    public func dragTargetDragLeave() {
        cefObject.drag_target_drag_leave(cefObjectPtr)
    }
    
    public func dragTargetDrop(event: CEFMouseEvent) {
        var cefEvent = event.toCEF()
        cefObject.drag_target_drop(cefObjectPtr, &cefEvent)
    }
    
    public func dragSourceEndedAt(x: Int, y: Int, operationMask: CEFDragOperationsMask) {
        cefObject.drag_source_ended_at(cefObjectPtr, Int32(x), Int32(y), operationMask.toCEF())
    }
    
    public func dragSourceSystemDragEnded() {
        cefObject.drag_source_system_drag_ended(cefObjectPtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFBrowserHost? {
        return CEFBrowserHost(ptr: ptr)
    }

}


public extension CEFBrowserHost {
    public func getNavigationEntries(currentOnly: Bool, block: CEFNavigationEntryVisitorVisitBlock) {
        getNavigationEntries(CEFNavigationEntryVisitorBridge(block: block), currentOnly: currentOnly)
    }

    public func runFileDialog(mode: CEFFileDialogMode,
                              title: String?,
                              defaultPath: String?,
                              acceptFilters: [String],
                              selectedFilterIndex: Int,
                              block: CEFRunFileDialogCallbackOnFileDialogDismissedBlock) {
        runFileDialog(mode,
                      title: title,
                      defaultPath: defaultPath,
                      acceptFilters: acceptFilters,
                      selectedFilterIndex: selectedFilterIndex,
                      callback: CEFRunFileDialogCallbackBridge(block: block))
    }
}


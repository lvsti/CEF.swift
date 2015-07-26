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

public struct CEFDragOperationsMask: OptionSetType {
    public let rawValue: UInt
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }

    public static let None = CEFDragOperationsMask(rawValue: 0)
    public static let Copy = CEFDragOperationsMask(rawValue: 1)
    public static let Link = CEFDragOperationsMask(rawValue: 2)
    public static let Generic = CEFDragOperationsMask(rawValue: 4)
    public static let Private = CEFDragOperationsMask(rawValue: 8)
    public static let Move = CEFDragOperationsMask(rawValue: 16)
    public static let Delete = CEFDragOperationsMask(rawValue: 32)
    public static let Every = CEFDragOperationsMask(rawValue: ~0)
    
    func toCEF() -> cef_drag_operations_mask_t {
        return cef_drag_operations_mask_t(rawValue: UInt32(rawValue))
    }
}

public struct CEFFileDialogMode: RawRepresentable {
    public let rawValue: UInt
    
    public enum Type: UInt8 {
        case Open = 0
        case OpenMultiple
        case OpenFolder
        case Save
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }

        public static let OverwritePrompt = Flags(rawValue: 0x01000000)
        public static let HideReadOnly = Flags(rawValue: 0x02000000)
    }
    
    var type: Type { get { return Type(rawValue: UInt8(UInt32(rawValue) & FILE_DIALOG_TYPE_MASK.rawValue))! } }
    var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & ~FILE_DIALOG_TYPE_MASK.rawValue)) } }
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    func toCEF() -> cef_file_dialog_mode_t {
        return cef_file_dialog_mode_t(rawValue: UInt32(type.rawValue) | UInt32(flags.rawValue))
    }
}


public class CEFBrowserHost : CEFProxyBase<cef_browser_host_t> {

    typealias CEFFindIdentifier = Int32
    
    static func createBrowser(windowInfo: CEFWindowInfo,
                              client: CEFClient,
                              url: NSURL,
                              settings: CEFBrowserSettings,
                              requestContext: CEFRequestContext?) -> Bool {
        var cefSettings = settings.toCEF()
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        var cefWinInfo = windowInfo.toCEF()
        let cefReqCtxPtr: UnsafeMutablePointer<cef_request_context_t> = requestContext != nil ? requestContext!.toCEF() : nil
        
        defer {
            cefSettings.clear()
            CEFStringPtrRelease(cefURLPtr)
            cefWinInfo.clear()
        }
        
        return cef_browser_host_create_browser(&cefWinInfo, client.toCEF(), cefURLPtr, &cefSettings, cefReqCtxPtr) != 0
    }

    static func createBrowserSync(windowInfo: CEFWindowInfo,
                                  client: CEFClient,
                                  url: NSURL,
                                  settings: CEFBrowserSettings,
                                  requestContext: CEFRequestContext?) -> CEFBrowser? {
        var cefSettings = settings.toCEF()
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        var cefWinInfo = windowInfo.toCEF()
        let cefReqCtxPtr: UnsafeMutablePointer<cef_request_context_t> = requestContext != nil ? requestContext!.toCEF() : nil
        
        defer {
            cefSettings.clear()
            CEFStringPtrRelease(cefURLPtr)
            cefWinInfo.clear()
        }
        
        let cefBrowser = cef_browser_host_create_browser_sync(&cefWinInfo, client.toCEF(), cefURLPtr, &cefSettings, cefReqCtxPtr)
        return CEFBrowser.fromCEF(cefBrowser)
    }

    func getBrowser() -> CEFBrowser? {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return CEFBrowser.fromCEF(cefBrowser)
    }
    
    func closeBrowser(force: Bool) {
        cefObject.close_browser(cefObjectPtr, force ? 1 : 0)
    }

    func setFocused(focused: Bool) {
        cefObject.set_focus(cefObjectPtr, focused ? 1 : 0)
    }

    func setWindowVisibility(visible: Bool) {
        cefObject.set_window_visibility(cefObjectPtr, visible ? 1 : 0)
    }

    func getWindowHandle() -> CEFWindowHandle {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_window_handle(cefObjectPtr)
        return Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }
    
    func getOpenerWindowHandle() -> CEFWindowHandle {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_opener_window_handle(cefObjectPtr)
        return Unmanaged<CEFWindowHandle>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }
    
    func getClient() -> CEFClient? {
        let cefClient = cefObject.get_client(cefObjectPtr)
        return CEFClientMarshaller.take(cefClient)
    }

    func getRequestContext() -> CEFRequestContext? {
        let cefCtx = cefObject.get_request_context(cefObjectPtr)
        return CEFRequestContext.fromCEF(cefCtx)
    }

    func getZoomLevel() -> Double {
        return cefObject.get_zoom_level(cefObjectPtr)
    }
    
    func setZoomLevel(zoomLevel: Double) {
        cefObject.set_zoom_level(cefObjectPtr, zoomLevel)
    }

    func runFileDialog(mode: CEFFileDialogMode,
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
    
    func startDownload(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.start_download(cefObjectPtr, cefURLPtr)
    }

    func print() {
        cefObject.print(cefObjectPtr)
    }

    func find(identifier: CEFFindIdentifier, searchText: String, forward: Bool, caseSensitive: Bool, findNext: Bool) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(searchText)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.find(cefObjectPtr, identifier, cefStrPtr, forward ? 1 : 0, caseSensitive ? 1 : 0, findNext ? 1 : 0)
    }
    
    func stopFinding(clearSelection: Bool) {
        cefObject.stop_finding(cefObjectPtr, clearSelection ? 1 : 0)
    }
    
    func showDevTools(windowInfo: CEFWindowInfo, client: CEFClient, settings: CEFBrowserSettings, inspectionPoint: CEFPoint) {
        var cefSettings = settings.toCEF()
        var cefPoint = inspectionPoint.toCEF()
        var cefWinInfo = windowInfo.toCEF()
        defer {
            cefSettings.clear()
            cefWinInfo.clear()
        }
        cefObject.show_dev_tools(cefObjectPtr, &cefWinInfo, client.toCEF(), &cefSettings, &cefPoint)
    }
    
    func closeDevTools() {
        cefObject.close_dev_tools(cefObjectPtr)
    }

    func getNavigationEntries(visitor: CEFNavigationEntryVisitor, currentOnly: Bool) {
        cefObject.get_navigation_entries(cefObjectPtr, visitor.toCEF(), currentOnly ? 1 : 0)
    }
    
    func setMouseCursorChangeDisabled(value: Bool) {
        cefObject.set_mouse_cursor_change_disabled(cefObjectPtr, value ? 1 : 0)
    }
    
    func isMouseCursorChangeDisabled() -> Bool {
        return cefObject.is_mouse_cursor_change_disabled(cefObjectPtr) != 0
    }

    func replaceMisspelling(replacementWord: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(replacementWord)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.replace_misspelling(cefObjectPtr, cefStrPtr)
    }

    func addWordToDictionary(word: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(word)
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.add_word_to_dictionary(cefObjectPtr, cefStrPtr)
    }
    
    func isWindowRenderingDisabled() -> Bool {
        return cefObject.is_window_rendering_disabled(cefObjectPtr) != 0
    }
    
    func notifyWasResized() {
        cefObject.was_resized(cefObjectPtr)
    }
    
    func notifyWasHidden(hidden: Bool) {
        cefObject.was_hidden(cefObjectPtr, hidden ? 1 : 0)
    }

    func notifyScreenInfoChanged() {
        cefObject.notify_screen_info_changed(cefObjectPtr)
    }

    func invalidate(element: CEFPaintElementType) {
        cefObject.invalidate(cefObjectPtr, element.toCEF())
    }

    func sendKeyEvent(event: CEFKeyEvent) {
        var cefEvent = event.toCEF()
        cefObject.send_key_event(cefObjectPtr, &cefEvent)
    }

    func sendMouseClickEvent(event: CEFMouseEvent, type: CEFMouseButtonType, mouseUp: Bool, clickCount: Int) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_click_event(cefObjectPtr, &cefEvent, type.toCEF(), mouseUp ? 1 : 0, Int32(clickCount))
    }

    func sendMouseMoveEvent(event: CEFMouseEvent, mouseLeave: Bool) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_move_event(cefObjectPtr, &cefEvent, mouseLeave ? 1 : 0)
    }

    func sendMouseWheelEvent(event: CEFMouseEvent, deltaX: Int, deltaY: Int) {
        var cefEvent = event.toCEF()
        cefObject.send_mouse_wheel_event(cefObjectPtr, &cefEvent, Int32(deltaX), Int32(deltaY))
    }
    
    func sendFocusEvent(focus: Bool) {
        cefObject.send_focus_event(cefObjectPtr, focus ? 1 : 0)
    }
    
    func sendCaptureLostEvent() {
        cefObject.send_capture_lost_event(cefObjectPtr)
    }

    func notifyMoveOrResizeStarted() {
        cefObject.notify_move_or_resize_started(cefObjectPtr)
    }
    
    func getNSTextInputContext() -> CEFTextInputContext {
        let rawHandle:UnsafeMutablePointer<Void> = cefObject.get_nstext_input_context(cefObjectPtr)
        return Unmanaged<CEFTextInputContext>.fromOpaque(COpaquePointer(rawHandle)).takeUnretainedValue()
    }

    func handleKeyEventBeforeTextInputClient(event: CEFEventHandle) {
        let rawEvent = UnsafeMutablePointer<Void>(Unmanaged<CEFEventHandle>.passUnretained(event).toOpaque())
        cefObject.handle_key_event_before_text_input_client(cefObjectPtr, rawEvent)
    }
    
    func handleKeyEventAfterTextInputClient(event: CEFEventHandle) {
        let rawEvent = UnsafeMutablePointer<Void>(Unmanaged<CEFEventHandle>.passUnretained(event).toOpaque())
        cefObject.handle_key_event_after_text_input_client(cefObjectPtr, rawEvent)
    }

    func dragTargetDragEnter(dragData: CEFDragData, event: CEFMouseEvent, operationMask: CEFDragOperationsMask) {
        let cefDragData = dragData.toCEF()
        var cefEvent = event.toCEF()
        cefObject.drag_target_drag_enter(cefObjectPtr, cefDragData, &cefEvent, operationMask.toCEF())
    }
    
    func dragTargetDragOver(event: CEFMouseEvent, operationMask: CEFDragOperationsMask) {
        var cefEvent = event.toCEF()
        cefObject.drag_target_drag_over(cefObjectPtr, &cefEvent, operationMask.toCEF())
    }
    
    func dragTargetDragLeave() {
        cefObject.drag_target_drag_leave(cefObjectPtr)
    }
    
    func dragTargetDrop(event: CEFMouseEvent) {
        var cefEvent = event.toCEF()
        cefObject.drag_target_drop(cefObjectPtr, &cefEvent)
    }
    
    func dragSourceEndedAt(x: Int, y: Int, operationMask: CEFDragOperationsMask) {
        cefObject.drag_source_ended_at(cefObjectPtr, Int32(x), Int32(y), operationMask.toCEF())
    }
    
    func dragSourceSystemDragEnded() {
        cefObject.drag_source_system_drag_ended(cefObjectPtr)
    }
    
};

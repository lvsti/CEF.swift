//
//  CEFRenderHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnStartDraggingAction {
    case allow
    case cancel
}

public struct CEFTextSelection {
    let text: String
    let range: CEFRange
}

/// Implement this interface to handle events when window rendering is disabled.
/// The methods of this class will be called on the UI thread.
/// CEF name: `CefRenderHandler`
public protocol CEFRenderHandler {
    
    /// Return the handler for accessibility notifications. If no handler is
    /// provided the default implementation will be used.
    /// CEF name: `GetAccessibilityHandler`
    var accessibilityHandler: CEFAccessibilityHandler? { get }
    
    /// Called to retrieve the root window rectangle in screen coordinates. Return
    /// true if the rectangle was provided. If this method returns false the
    /// rectangle from GetViewRect will be used.
    /// CEF name: `GetRootScreenRect`
    func rootScreenRectForBrowser(browser: CEFBrowser) -> NSRect?
    
    /// Called to retrieve the view rectangle which is relative to screen
    /// coordinates. This method must always provide a non-empty rectangle.
    /// CEF name: `GetViewRect`
    func viewRectForBrowser(browser: CEFBrowser) -> NSRect
    
    /// Called to retrieve the translation from view coordinates to actual screen
    /// coordinates. Return true if the screen coordinates were provided.
    /// CEF name: `GetScreenPoint`
    func screenPointForBrowser(browser: CEFBrowser, viewPoint: NSPoint) -> NSPoint?
    
    /// Called to allow the client to fill in the CefScreenInfo object with
    /// appropriate values. Return true if the |screen_info| structure has been
    /// modified.
    /// If the screen info rectangle is left empty the rectangle from GetViewRect
    /// will be used. If the rectangle is still empty or invalid popups may not be
    /// drawn correctly.
    /// CEF name: `GetScreenInfo`
    func screenInfoForBrowser(browser: CEFBrowser) -> CEFScreenInfo?
    
    /// Called when the browser wants to show or hide the popup widget. The popup
    /// should be shown if |show| is true and hidden if |show| is false.
    /// CEF name: `OnPopupShow`
    func onPopupTransition(browser: CEFBrowser, willShow: Bool)
    
    /// Called when the browser wants to move or resize the popup widget. |rect|
    /// contains the new location and size in view coordinates.
    /// CEF name: `OnPopupSize`
    func onPopupRectChange(browser: CEFBrowser, newRect: NSRect)
    
    /// Called when an element should be painted. Pixel values passed to this
    /// method are scaled relative to view coordinates based on the value of
    /// CefScreenInfo.device_scale_factor returned from GetScreenInfo. |type|
    /// indicates whether the element is the view or the popup widget. |buffer|
    /// contains the pixel data for the whole image. |dirtyRects| contains the set
    /// be |width|*|height|*4 bytes in size and represents a BGRA image with an
    /// upper-left origin. This method is only called when
    /// CefWindowInfo::shared_texture_enabled is set to false.
    /// CEF name: `OnPaint`
    func onPaint(browser: CEFBrowser,
                 type: CEFPaintElementType,
                 dirtyRects: [NSRect],
                 buffer: UnsafeRawPointer,
                 size: NSSize)
    
    /// Called when an element has been rendered to the shared texture handle.
    /// |type| indicates whether the element is the view or the popup widget.
    /// |dirtyRects| contains the set of rectangles in pixel coordinates that need
    /// to be repainted. |shared_handle| is the handle for a D3D11 Texture2D that
    /// can be accessed via ID3D11Device using the OpenSharedResource method. This
    /// method is only called when CefWindowInfo::shared_texture_enabled is set to
    /// true, and is currently only supported on Windows.
    /// CEF name: `OnAcceleratedPaint`
    func onAcceleratedPaint(browser: CEFBrowser,
                            type: CEFPaintElementType,
                            dirtyRects: [NSRect],
                            textureHandle: UnsafeMutableRawPointer)
    
    /// Called when the browser's cursor has changed. If |type| is CT_CUSTOM then
    /// |custom_cursor_info| will be populated with the custom cursor information.
    /// CEF name: `OnCursorChange`
    func onCursorChange(browser: CEFBrowser,
                        cursor: CEFCursorHandle,
                        type: CEFCursorType,
                        cursorInfo: CEFCursorInfo?)
    
    /// Called when the user starts dragging content in the web view. Contextual
    /// information about the dragged content is supplied by |drag_data|.
    /// (|x|, |y|) is the drag start location in screen coordinates.
    /// OS APIs that run a system message loop may be used within the
    /// StartDragging call.
    /// Return false to abort the drag operation. Don't call any of
    /// CefBrowserHost::DragSource*Ended* methods after returning false.
    /// Return true to handle the drag operation. Call
    /// CefBrowserHost::DragSourceEndedAt and DragSourceSystemDragEnded either
    /// synchronously or asynchronously to inform the web view that the drag
    /// operation has ended.
    /// CEF name: `StartDragging`
    func onStartDragging(browser: CEFBrowser,
                         dragData: CEFDragData,
                         operationMask: CEFDragOperationsMask,
                         location: NSPoint) -> CEFOnStartDraggingAction
    
    /// Called when the web view wants to update the mouse cursor during a
    /// drag & drop operation. |operation| describes the allowed operation
    /// (none, move, copy, link).
    /// CEF name: `UpdateDragCursor`
    func onUpdateDragCursor(browser: CEFBrowser, operation: CEFDragOperationsMask)
    
    /// Called when the scroll offset has changed.
    /// CEF name: `OnScrollOffsetChanged`
    func onScrollOffsetChanged(browser: CEFBrowser, offset: NSPoint)

    /// Called when the IME composition range has changed. |selected_range| is the
    /// range of characters that have been selected. |character_bounds| is the
    /// bounds of each character in view coordinates.
    /// CEF name: `OnImeCompositionRangeChanged`
    func onIMECompositionRangeChanged(browser: CEFBrowser, selectedRange: CEFRange, characterBounds: [NSRect])

    /// Called when text selection has changed for the specified |browser|.
    /// |selected_text| is the currently selected text and |selected_range| is
    // the character range.
    /// CEF name: `OnTextSelectionChanged`
    func onTextSelectionChanged(browser: CEFBrowser, selection: CEFTextSelection?)
}

public extension CEFRenderHandler {
    
    var accessibilityHandler: CEFAccessibilityHandler? {
        return nil
    }
    
    func rootScreenRectForBrowser(browser: CEFBrowser) -> NSRect? {
        return nil
    }

    func viewRectForBrowser(browser: CEFBrowser) -> NSRect {
        return .zero
    }

    func screenPointForBrowser(browser: CEFBrowser, viewPoint: NSPoint) -> NSPoint? {
        return nil
    }
    
    func screenInfoForBrowser(browser: CEFBrowser) -> CEFScreenInfo? {
        return nil
    }

    func onPopupTransition(browser: CEFBrowser, willShow: Bool) {
    }

    func onPopupRectChange(browser: CEFBrowser, newRect: NSRect) {
    }

    func onPaint(browser: CEFBrowser,
                 type: CEFPaintElementType,
                 dirtyRects: [NSRect],
                 buffer: UnsafeRawPointer,
                 size: NSSize) {
    }

    func onAcceleratedPaint(browser: CEFBrowser,
                            type: CEFPaintElementType,
                            dirtyRects: [NSRect],
                            textureHandle: UnsafeMutableRawPointer) {
    }

    func onCursorChange(browser: CEFBrowser,
                        cursor: CEFCursorHandle,
                        type: CEFCursorType,
                        cursorInfo: CEFCursorInfo?) {
    }

    func onStartDragging(browser: CEFBrowser,
                         dragData: CEFDragData,
                         operationMask: CEFDragOperationsMask,
                         location: NSPoint) -> CEFOnStartDraggingAction {
        return .cancel
    }

    func onUpdateDragCursor(browser: CEFBrowser, operation: CEFDragOperationsMask) {
    }

    func onScrollOffsetChanged(browser: CEFBrowser, offset: NSPoint) {
    }

    func onIMECompositionRangeChanged(browser: CEFBrowser, selectedRange: CEFRange, characterBounds: [NSRect]) {
    }
    
    func onTextSelectionChanged(browser: CEFBrowser, selection: CEFTextSelection?) {
    }
}


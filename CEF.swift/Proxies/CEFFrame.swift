//
//  CEFFrame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFFrame {

    public typealias Identifier = Int64
    
    /// True if this object is currently attached to a valid frame.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Execute undo in this frame.
    /// CEF name: `Undo`
    public func undo() {
        cefObject.undo(cefObjectPtr)
    }

    /// Execute redo in this frame.
    /// CEF name: `Redo`
    public func redo() {
        cefObject.redo(cefObjectPtr)
    }

    /// Execute cut in this frame.
    /// CEF name: `Cut`
    public func cut() {
        cefObject.cut(cefObjectPtr)
    }

    /// Execute copy in this frame.
    /// CEF name: `Copy`
    public func copy() {
        cefObject.copy(cefObjectPtr)
    }

    /// Execute paste in this frame.
    /// CEF name: `Paste`
    public func paste() {
        cefObject.paste(cefObjectPtr)
    }

    /// Execute delete in this frame.
    /// CEF name: `Delete`
    public func delete() {
        cefObject.del(cefObjectPtr)
    }
    
    /// Execute select all in this frame.
    /// CEF name: `SelectAll`
    public func selectAll() {
        cefObject.select_all(cefObjectPtr)
    }

    /// Save this frame's HTML source to a temporary file and open it in the
    /// default text viewing application. This method can only be called from the
    /// browser process.
    /// CEF name: `ViewSource`
    public func viewSource() {
        cefObject.view_source(cefObjectPtr)
    }

    /// Retrieve this frame's HTML source as a string sent to the specified
    /// visitor.
    /// CEF name: `GetSource`
    public func getSource(with visitor: CEFStringVisitor) {
        cefObject.get_source(cefObjectPtr, visitor.toCEF())
    }

    /// Retrieve this frame's display text as a string sent to the specified
    /// visitor.
    /// CEF name: `GetText`
    public func getText(with visitor: CEFStringVisitor) {
        cefObject.get_text(cefObjectPtr, visitor.toCEF())
    }
    
    /// Load the request represented by the |request| object.
    /// WARNING: This method will fail with "bad IPC message" reason
    /// INVALID_INITIATOR_ORIGIN (213) unless you first navigate to the
    /// request origin using some other mechanism (LoadURL, link click, etc).
    /// CEF name: `LoadRequest`
    public func loadRequest(_ request: CEFRequest) {
        cefObject.load_request(cefObjectPtr, request.toCEF())
    }
    
    /// Load the specified |url|.
    /// CEF name: `LoadURL`
    public func loadURL(_ url: URL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.load_url(cefObjectPtr, cefURLPtr)
    }
    
    /// Execute a string of JavaScript code in this frame. The |script_url|
    /// parameter is the URL where the script in question can be found, if any.
    /// The renderer may request this URL to show the developer the source of the
    /// error.  The |start_line| parameter is the base line number to use for error
    /// reporting.
    /// CEF name: `ExecuteJavaScript`
    public func executeJavaScript(code: String, scriptURL: URL? = nil, startLine: Int = 1) {
        let cefCodePtr = CEFStringPtrCreateFromSwiftString(code)
        let cefURLPtr = scriptURL != nil ? CEFStringPtrCreateFromSwiftString(scriptURL!.absoluteString) : nil
        defer {
            CEFStringPtrRelease(cefCodePtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        cefObject.execute_java_script(cefObjectPtr, cefCodePtr, cefURLPtr, Int32(startLine))
    }

    /// Returns true if this is the main (top-level) frame.
    /// CEF name: `IsMain`
    public var isMain: Bool {
        return cefObject.is_main(cefObjectPtr) != 0
    }
    
    /// Returns true if this is the focused frame.
    /// CEF name: `IsFocused`
    public var isFocused: Bool {
        return cefObject.is_focused(cefObjectPtr) != 0
    }
    
    /// Returns the name for this frame. If the frame has an assigned name (for
    /// example, set via the iframe "name" attribute) then that value will be
    /// returned. Otherwise a unique name will be constructed based on the frame
    /// parent hierarchy. The main (top-level) frame will always have an empty name
    /// value.
    /// CEF name: `GetName`
    public var name: String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the globally unique identifier for this frame or < 0 if the
    /// underlying frame does not yet exist.
    /// CEF name: `GetIdentifier`
    public var identifier: Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    /// Returns the parent of this frame or NULL if this is the main (top-level)
    /// frame.
    /// CEF name: `GetParent`
    public var parent: CEFFrame? {
        let cefFrame = cefObject.get_parent(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    /// Returns the URL currently loaded in this frame.
    /// CEF name: `GetURL`
    public var url: URL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return URL(string: CEFStringToSwiftString(cefURLPtr!.pointee))!
    }
    
    /// Returns the browser that this frame belongs to.
    /// CEF name: `GetBrowser`
    public var browser: CEFBrowser {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return CEFBrowser.fromCEF(cefBrowser)!
    }

    /// Get the V8 context associated with the frame. This method can only be
    /// called from the render process.
    /// CEF name: `GetV8Context`
    public var v8Context: CEFV8Context {
        let cefV8Ctx = cefObject.get_v8context(cefObjectPtr)
        return CEFV8Context.fromCEF(cefV8Ctx)!
    }

    /// Visit the DOM document. This method can only be called from the render
    /// process.
    /// CEF name: `VisitDOM`
    public func getDOMDocument(with visitor: CEFDOMVisitor) {
        return cefObject.visit_dom(cefObjectPtr, visitor.toCEF())
    }

    /// Create a new URL request that will be treated as originating from this
    /// frame and the associated browser. This request may be intercepted by the
    /// client via CefResourceRequestHandler or CefSchemeHandlerFactory. Use
    /// CefURLRequest::Create instead if you do not want the request to have this
    /// association, in which case it may be handled differently (see documentation
    /// on that method). Requests may originate from both the browser process and
    /// the render process.
    ///
    /// For requests originating from the browser process:
    ///   - POST data may only contain a single element of type PDE_TYPE_FILE or
    ///     PDE_TYPE_BYTES.
    /// For requests originating from the render process:
    ///   - POST data may only contain a single element of type PDE_TYPE_BYTES.
    ///   - If the response contains Content-Disposition or Mime-Type header values
    ///     that would not normally be rendered then the response may receive
    ///     special handling inside the browser (for example, via the file download
    ///     code path instead of the URL request code path).
    ///
    /// The |request| object will be marked as read-only after calling this method.
    /// CEF name: `CreateURLRequest`
    func createURLRequest(request: CEFRequest, client: CEFURLRequestClient) -> CEFURLRequest {
        let cefURLReq = cefObject.create_urlrequest(cefObjectPtr, request.toCEF(), client.toCEF())
        return CEFURLRequest.fromCEF(cefURLReq)!
    }
    
    /// Send a message to the specified |target_process|. Ownership of the message
    /// contents will be transferred and the |message| reference will be
    /// invalidated. Message delivery is not guaranteed in all cases (for example,
    /// if the browser is closing, navigating, or if the target process crashes).
    /// Send an ACK message back from the target process if confirmation is
    /// required.
    /// CEF name: `SendProcessMessage`
    func sendProcessMessage(targetProcess: CEFProcessID, message: CEFProcessMessage) {
        cefObject.send_process_message(cefObjectPtr, targetProcess.toCEF(), message.toCEF())
    }
}


public extension CEFFrame {

    /// Visit the DOM document. This method can only be called from the render
    /// process.
    /// CEF name: `VisitDOM`
    public func withDOMDocument(block: @escaping CEFDOMVisitorVisitBlock) {
        getDOMDocument(with: CEFDOMVisitorBridge(block: block))
    }

    /// Retrieve this frame's HTML source as a string sent to the specified
    /// visitor.
    /// CEF name: `GetSource`
    public func withSource(block: @escaping CEFStringVisitorVisitBlock) {
        getSource(with: CEFStringVisitorBridge(block: block))
    }

    /// Retrieve this frame's display text as a string sent to the specified
    /// visitor.
    /// CEF name: `GetText`
    public func withText(block: @escaping CEFStringVisitorVisitBlock) {
        getText(with: CEFStringVisitorBridge(block: block))
    }

}

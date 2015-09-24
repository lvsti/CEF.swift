//
//  Frame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_frame_t: CEFObject {
}

/// Class used to represent a frame in the browser window. When used in the
/// browser process the methods of this class may be called on any thread unless
/// otherwise indicated in the comments. When used in the render process the
/// methods of this class may only be called on the main thread.
public class Frame: Proxy<cef_frame_t> {
    
    public typealias Identifier = Int64
    
    /// True if this object is currently attached to a valid frame.
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Execute undo in this frame.
    public func undo() {
        cefObject.undo(cefObjectPtr)
    }

    /// Execute redo in this frame.
    public func redo() {
        cefObject.redo(cefObjectPtr)
    }

    /// Execute cut in this frame.
    public func cut() {
        cefObject.cut(cefObjectPtr)
    }

    /// Execute copy in this frame.
    public func copy() {
        cefObject.copy(cefObjectPtr)
    }

    /// Execute paste in this frame.
    public func paste() {
        cefObject.paste(cefObjectPtr)
    }

    /// Execute delete in this frame.
    public func delete() {
        cefObject.del(cefObjectPtr)
    }
    
    /// Execute select all in this frame.
    public func selectAll() {
        cefObject.select_all(cefObjectPtr)
    }

    /// Save this frame's HTML source to a temporary file and open it in the
    /// default text viewing application. This method can only be called from the
    /// browser process.
    public func viewSource() {
        cefObject.view_source(cefObjectPtr)
    }

    /// Retrieve this frame's HTML source as a string sent to the specified
    /// visitor.
    public func getSourceUsingVisitor(visitor: StringVisitor) {
        cefObject.get_source(cefObjectPtr, visitor.toCEF())
    }

    /// Retrieve this frame's display text as a string sent to the specified
    /// visitor.
    public func getTextUsingVisitor(visitor: StringVisitor) {
        cefObject.get_text(cefObjectPtr, visitor.toCEF())
    }
    
    /// Load the request represented by the |request| object.
    public func loadRequest(request: Request) {
        cefObject.load_request(cefObjectPtr, request.toCEF())
    }
    
    /// Load the specified |url|.
    public func loadURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.load_url(cefObjectPtr, cefURLPtr)
    }
    
    /// Load the contents of |string_val| with the specified dummy |url|. |url|
    /// should have a standard scheme (for example, http scheme) or behaviors like
    /// link clicks and web security restrictions may not behave as expected.
    public func loadString(str: String, url: NSURL) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(str)
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        cefObject.load_string(cefObjectPtr, cefStrPtr, cefURLPtr)
    }

    /// Execute a string of JavaScript code in this frame. The |script_url|
    /// parameter is the URL where the script in question can be found, if any.
    /// The renderer may request this URL to show the developer the source of the
    /// error.  The |start_line| parameter is the base line number to use for error
    /// reporting.
    public func executeJavaScript(code: String, scriptURL: NSURL? = nil, startLine: Int = 1) {
        let cefCodePtr = CEFStringPtrCreateFromSwiftString(code)
        let cefURLPtr = scriptURL != nil ? CEFStringPtrCreateFromSwiftString(scriptURL!.absoluteString) : nil
        defer {
            CEFStringPtrRelease(cefCodePtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        cefObject.execute_java_script(cefObjectPtr, cefCodePtr, cefURLPtr, Int32(startLine))
    }

    /// Returns true if this is the main (top-level) frame.
    public var isMain: Bool {
        return cefObject.is_main(cefObjectPtr) != 0
    }
    
    /// Returns true if this is the focused frame.
    public var isFocused: Bool {
        return cefObject.is_focused(cefObjectPtr) != 0
    }
    
    /// Returns the name for this frame. If the frame has an assigned name (for
    /// example, set via the iframe "name" attribute) then that value will be
    /// returned. Otherwise a unique name will be constructed based on the frame
    /// parent hierarchy. The main (top-level) frame will always have an empty name
    /// value.
    public var name: String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the globally unique identifier for this frame.
    public var identifier: Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    /// Returns the parent of this frame or NULL if this is the main (top-level)
    /// frame.
    public var parent: Frame? {
        let cefFrame = cefObject.get_parent(cefObjectPtr)
        return Frame.fromCEF(cefFrame)
    }
    
    /// Returns the URL currently loaded in this frame.
    public var url: NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    /// Returns the browser that this frame belongs to.
    public var browser: Browser {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return Browser.fromCEF(cefBrowser)!
    }

    /// Get the V8 context associated with the frame. This method can only be
    /// called from the render process.
    public var v8Context: V8Context {
        let cefV8Ctx = cefObject.get_v8context(cefObjectPtr)
        return V8Context.fromCEF(cefV8Ctx)!
    }

    /// Visit the DOM document. This method can only be called from the render
    /// process.
    public func getDOMDocumentUsingVisitor(visitor: DOMVisitor) {
        return cefObject.visit_dom(cefObjectPtr, visitor.toCEF())
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> Frame? {
        return Frame(ptr: ptr)
    }
}


public extension Frame {
    
    /// Visit the DOM document. This method can only be called from the render
    /// process.
    public func withDOMDocument(block: DOMVisitorVisitBlock) {
        getDOMDocumentUsingVisitor(DOMVisitorBridge(block: block))
    }

    /// Retrieve this frame's HTML source as a string sent to the specified
    /// visitor.
    public func withSource(block: StringVisitorVisitBlock) {
        getSourceUsingVisitor(StringVisitorBridge(block: block))
    }

    /// Retrieve this frame's display text as a string sent to the specified
    /// visitor.
    public func withText(block: StringVisitorVisitBlock) {
        getTextUsingVisitor(StringVisitorBridge(block: block))
    }

}

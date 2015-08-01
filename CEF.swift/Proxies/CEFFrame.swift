//
//  CEFFrame.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_frame_t: CEFObject {
}

public class CEFFrame: CEFProxy<cef_frame_t> {
    
    public typealias Identifier = Int64
    
    public func isValid() -> Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    public func undo() {
        cefObject.undo(cefObjectPtr)
    }

    public func redo() {
        cefObject.redo(cefObjectPtr)
    }

    public func cut() {
        cefObject.cut(cefObjectPtr)
    }

    public func copy() {
        cefObject.copy(cefObjectPtr)
    }

    public func paste() {
        cefObject.paste(cefObjectPtr)
    }

    public func delete() {
        cefObject.del(cefObjectPtr)
    }
    
    public func selectAll() {
        cefObject.select_all(cefObjectPtr)
    }

    public func viewSource() {
        cefObject.view_source(cefObjectPtr)
    }

    public func getSource(visitor: CEFStringVisitor) {
        cefObject.get_source(cefObjectPtr, visitor.toCEF())
    }

    public func getText(visitor: CEFStringVisitor) {
        cefObject.get_text(cefObjectPtr, visitor.toCEF())
    }
    
    public func loadRequest(request: CEFRequest) {
        cefObject.load_request(cefObjectPtr, request.toCEF())
    }
    
    public func loadURL(url: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        cefObject.load_url(cefObjectPtr, cefURLPtr)
    }
    
    public func loadString(str: String, url: NSURL) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(str)
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(url.absoluteString)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        cefObject.load_string(cefObjectPtr, cefStrPtr, cefURLPtr)
    }

    public func executeJavaScript(code: String, scriptURL: NSURL, startLine: Int) {
        let cefCodePtr = CEFStringPtrCreateFromSwiftString(code)
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(scriptURL.absoluteString)
        defer {
            CEFStringPtrRelease(cefCodePtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        cefObject.execute_java_script(cefObjectPtr, cefCodePtr, cefURLPtr, Int32(startLine))
    }

    public func isMain() -> Bool {
        return cefObject.is_main(cefObjectPtr) != 0
    }
    
    public func isFocused() -> Bool {
        return cefObject.is_focused(cefObjectPtr) != 0
    }
    
    public func getName() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getIdentifier() -> Identifier {
        return cefObject.get_identifier(cefObjectPtr)
    }

    public func getParent() -> CEFFrame? {
        let cefFrame = cefObject.get_parent(cefObjectPtr)
        return CEFFrame.fromCEF(cefFrame)
    }
    
    public func getURL() -> NSURL {
        let cefURLPtr = cefObject.get_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    public func getBrowser() -> CEFBrowser {
        let cefBrowser = cefObject.get_browser(cefObjectPtr)
        return CEFBrowser.fromCEF(cefBrowser)!
    }

    public func getV8Context() -> CEFV8Context {
        let cefV8Ctx = cefObject.get_v8context(cefObjectPtr)
        return CEFV8Context.fromCEF(cefV8Ctx)!
    }

    public func visitDOM(visitor: CEFDOMVisitor) {
        return cefObject.visit_dom(cefObjectPtr, visitor.toCEF())
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFFrame? {
        return CEFFrame(ptr: ptr)
    }
}

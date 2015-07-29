//
//  CEFDOMDocument.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_domdocument_t: CEFObject {
}

public enum CEFDOMDocumentType: Int {
    case Unknown = 0
    case HTML
    case XHTML
    case Plugin

    func toCEF() -> cef_dom_document_type_t {
        return cef_dom_document_type_t(rawValue: UInt32(rawValue))
    }
}

public class CEFDOMDocument: CEFProxy<cef_domdocument_t> {
    
    public typealias Type = CEFDOMDocumentType

    public func getType() -> Type {
        let cefType = cefObject.get_type(cefObjectPtr)
        return Type(rawValue: Int(cefType.rawValue))!
    }

    public func getDocument() -> CEFDOMNode? {
        let cefNode = cefObject.get_document(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    public func getBody() -> CEFDOMNode? {
        let cefNode = cefObject.get_body(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    public func getHead() -> CEFDOMNode? {
        let cefNode = cefObject.get_head(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    public func getTitle() -> String {
        let cefStrPtr = cefObject.get_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getElementByID(id: String) -> CEFDOMNode? {
        let cefIDPtr = CEFStringPtrCreateFromSwiftString(id)
        defer { CEFStringPtrRelease(cefIDPtr) }
        let cefNode = cefObject.get_element_by_id(cefObjectPtr, cefIDPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    public func getFocusedNode() -> CEFDOMNode? {
        let cefNode = cefObject.get_focused_node(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    public func hasSelection() -> Bool {
        return cefObject.has_selection(cefObjectPtr) != 0
    }
    
    public func getSelectionStartOffset() -> Int {
        return Int(cefObject.get_selection_start_offset(cefObjectPtr))
    }

    public func getSelectionEndOffset() -> Int {
        return Int(cefObject.get_selection_end_offset(cefObjectPtr))
    }

    public func getSelectionAsMarkup() -> String {
        let cefStrPtr = cefObject.get_selection_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getSelectionAsText() -> String {
        let cefStrPtr = cefObject.get_selection_as_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    public func getBaseURL() -> NSURL {
        let cefURLPtr = cefObject.get_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    public func getCompleteURL(relativePart: String) -> NSURL {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(relativePart)
        let cefURLPtr = cefObject.get_complete_url(cefObjectPtr, cefStrPtr)
        defer {
            CEFStringPtrRelease(cefStrPtr)
            CEFStringPtrRelease(cefURLPtr)
        }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDOMDocument? {
        return CEFDOMDocument(ptr: ptr)
    }
}


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

/// Class used to represent a DOM document. The methods of this class should only
/// be called on the render process main thread thread.
public class CEFDOMDocument: CEFProxy<cef_domdocument_t> {
    
    /// Returns the document type.
    public func getType() -> CEFDOMDocumentType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFDOMDocumentType.fromCEF(cefType)
    }

    /// Returns the root document node.
    public func getDocument() -> CEFDOMNode? {
        let cefNode = cefObject.get_document(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the BODY node of an HTML document.
    public func getBody() -> CEFDOMNode? {
        let cefNode = cefObject.get_body(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the HEAD node of an HTML document.
    public func getHead() -> CEFDOMNode? {
        let cefNode = cefObject.get_head(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns the title of an HTML document.
    public func getTitle() -> String {
        let cefStrPtr = cefObject.get_title(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    /// Returns the document element with the specified ID value.
    public func getElementByID(id: String) -> CEFDOMNode? {
        let cefIDPtr = CEFStringPtrCreateFromSwiftString(id)
        defer { CEFStringPtrRelease(cefIDPtr) }
        let cefNode = cefObject.get_element_by_id(cefObjectPtr, cefIDPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the node that currently has keyboard focus.
    public func getFocusedNode() -> CEFDOMNode? {
        let cefNode = cefObject.get_focused_node(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns true if a portion of the document is selected.
    public func hasSelection() -> Bool {
        return cefObject.has_selection(cefObjectPtr) != 0
    }
    
    /// Returns the selection offset within the start node.
    public func getSelectionStartOffset() -> Int {
        return Int(cefObject.get_selection_start_offset(cefObjectPtr))
    }

    /// Returns the selection offset within the end node.
    public func getSelectionEndOffset() -> Int {
        return Int(cefObject.get_selection_end_offset(cefObjectPtr))
    }

    /// Returns the contents of this selection as markup.
    public func getSelectionAsMarkup() -> String {
        let cefStrPtr = cefObject.get_selection_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the contents of this selection as text.
    public func getSelectionAsText() -> String {
        let cefStrPtr = cefObject.get_selection_as_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the base URL for the document.
    public func getBaseURL() -> NSURL {
        let cefURLPtr = cefObject.get_base_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        return NSURL(string: CEFStringToSwiftString(cefURLPtr.memory))!
    }
    
    /// Returns a complete URL based on the document base URL and the specified
    /// partial URL.
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


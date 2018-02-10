//
//  CEFDOMNode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFDOMNode {

    /// Returns the type for this node.
    /// CEF name: `GetType`
    public var type: CEFDOMNodeType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFDOMNodeType.fromCEF(cefType)
    }

    /// Returns true if this is a text node.
    /// CEF name: `IsText`
    public var isText: Bool {
        return cefObject.is_text(cefObjectPtr) != 0
    }

    /// Returns true if this is an element node.
    /// CEF name: `IsElement`
    public var isElement: Bool {
        return cefObject.is_element(cefObjectPtr) != 0
    }

    /// Returns true if this is an editable node.
    /// CEF name: `IsEditable`
    public var isEditable: Bool {
        return cefObject.is_editable(cefObjectPtr) != 0
    }

    /// Returns true if this is a form control element node.
    /// CEF name: `IsFormControlElement`
    public var isFormControlElement: Bool {
        return cefObject.is_form_control_element(cefObjectPtr) != 0
    }
    
    /// Returns the type of this form control element node.
    /// CEF name: `GetFormControlElementType`
    public var formControlElementType: String? {
        let cefStrPtr = cefObject.get_form_control_element_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }
    
    /// Returns true if this object is pointing to the same handle as |that|
    /// object.
    /// CEF name: `IsSame`
    public func isSame(as other: CEFDOMNode) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    /// Returns the name of this node.
    /// CEF name: `GetName`
    public var name: String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }

    /// Returns the value of this node.
    /// CEF name: `GetValue`, `SetValue`
    public var stringValue: String {
        get {
            let cefStrPtr = cefObject.get_value(cefObjectPtr)
            defer { CEFStringPtrRelease(cefStrPtr) }
            return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
        }
        set {
            let cefStrPtr = CEFStringPtrCreateFromSwiftString(newValue)
            defer { CEFStringPtrRelease(cefStrPtr) }
            _ = cefObject.set_value(cefObjectPtr, cefStrPtr)
        }
    }

    /// Set the value of this node. Returns true on success.
    /// CEF name: `SetValue`
    @discardableResult
    public func setStringValue(_ value: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(value)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_value(cefObjectPtr, cefStrPtr) != 0
    }

    /// Returns the contents of this node as markup.
    /// CEF name: `GetAsMarkup`
    public var markupValue: String {
        let cefStrPtr = cefObject.get_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }

    /// Returns the document associated with this node.
    /// CEF name: `GetDocument`
    public var document: CEFDOMDocument {
        let cefDoc = cefObject.get_document(cefObjectPtr)
        return CEFDOMDocument.fromCEF(cefDoc)!
    }
    
    /// Returns the parent node.
    /// CEF name: `GetParent`
    public var parent: CEFDOMNode? {
        let cefNode = cefObject.get_parent(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the previous sibling node.
    /// CEF name: `GetPreviousSibling`
    public var previousSibling: CEFDOMNode? {
        let cefNode = cefObject.get_previous_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    /// Returns the next sibling node.
    /// CEF name: `GetNextSibling`
    public var nextSibling: CEFDOMNode? {
        let cefNode = cefObject.get_next_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns true if this node has child nodes.
    /// CEF name: `HasChildren`
    public var hasChildren: Bool {
        return cefObject.has_children(cefObjectPtr) != 0
    }

    /// Return the first child node.
    /// CEF name: `GetFirstChild`
    public var firstChild: CEFDOMNode? {
        let cefNode = cefObject.get_first_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    /// Returns the last child node.
    /// CEF name: `GetLastChild`
    public var lastChild: CEFDOMNode? {
        let cefNode = cefObject.get_last_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    // The following methods are valid only for element nodes.
    
    /// Returns the tag name of this element.
    /// CEF name: `GetElementTagName`
    public var elementTagName: String? {
        let cefStrPtr = cefObject.get_element_tag_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns true if this element has attributes.
    /// CEF name: `HasElementAttributes`
    public var hasElementAttributes: Bool {
        return cefObject.has_element_attributes(cefObjectPtr) != 0
    }

    /// Returns true if this element has an attribute named |attrName|.
    /// CEF name: `HasElementAttribute`
    public func hasElementAttribute(named: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_element_attribute(cefObjectPtr, cefStrPtr) != 0
    }

    /// Returns the element attribute named |attrName|.
    /// CEF name: `GetElementAttribute`
    public func elementAttribute(named: String) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_element_attribute(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return CEFStringPtrToSwiftString(cefValuePtr)
    }

    /// Returns a map of all element attributes.
    /// CEF name: `GetElementAttributes`
    public var elementAttributes: [String: String] {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        
        cefObject.get_element_attributes(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    /// Set the value for the element attribute named |attrName|. Returns true on
    /// success.
    /// CEF name: `SetElementAttribute`
    @discardableResult
    public func setElementAttribute(_ value: String, for name: String) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return cefObject.set_element_attribute(cefObjectPtr, cefNamePtr, cefValuePtr) != 0
    }

    /// Returns the inner text of the element.
    /// CEF name: `GetElementInnerText`
    public var elementInnerText: String {
        let cefStrPtr = cefObject.get_element_inner_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr, defaultValue: "")
    }
    
    /// Returns the bounds of the element.
    /// CEF name: `GetElementBounds`
    public var elementBounds: NSRect {
        let cefRect = cefObject.get_element_bounds(cefObjectPtr)
        return NSRect.fromCEF(cefRect)
    }

}


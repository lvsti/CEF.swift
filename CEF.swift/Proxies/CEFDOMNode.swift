//
//  CEFDOMNode.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 29..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_domnode_t: CEFObject {
}

///
// Class used to represent a DOM node. The methods of this class should only be
// called on the render process main thread.
///
public class CEFDOMNode: CEFProxy<cef_domnode_t> {

    public typealias AttributeMap = [String: String]
    
    ///
    // Returns the type for this node.
    ///
    func getType() -> CEFDOMNodeType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFDOMNodeType.fromCEF(cefType)
    }

    ///
    // Returns true if this is a text node.
    ///
    func isText() -> Bool {
        return cefObject.is_text(cefObjectPtr) != 0
    }

    ///
    // Returns true if this is an element node.
    ///
    func isElement() -> Bool {
        return cefObject.is_element(cefObjectPtr) != 0
    }

    ///
    // Returns true if this is an editable node.
    ///
    func isEditable() -> Bool {
        return cefObject.is_editable(cefObjectPtr) != 0
    }

    ///
    // Returns true if this is a form control element node.
    ///
    func isFormControlElement() -> Bool {
        return cefObject.is_form_control_element(cefObjectPtr) != 0
    }
    
    ///
    // Returns the type of this form control element node.
    ///
    func getFormControlElementType() -> String {
        let cefStrPtr = cefObject.get_form_control_element_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns true if this object is pointing to the same handle as |that|
    // object.
    ///
    func isSame(other: CEFDOMNode) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    ///
    // Returns the name of this node.
    ///
    func getName() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Returns the value of this node.
    ///
    func getValue() -> String {
        let cefStrPtr = cefObject.get_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Set the value of this node. Returns true on success.
    ///
    func setValue(value: String)-> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(value)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_value(cefObjectPtr, cefStrPtr) != 0
    }

    ///
    // Returns the contents of this node as markup.
    ///
    func getAsMarkup() -> String {
        let cefStrPtr = cefObject.get_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Returns the document associated with this node.
    ///
    func getDocument() -> CEFDOMDocument {
        let cefDoc = cefObject.get_document(cefObjectPtr)
        return CEFDOMDocument.fromCEF(cefDoc)!
    }
    
    ///
    // Returns the parent node.
    ///
    func getParent() -> CEFDOMNode? {
        let cefNode = cefObject.get_parent(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    ///
    // Returns the previous sibling node.
    ///
    func getPreviousSibling() -> CEFDOMNode? {
        let cefNode = cefObject.get_previous_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    ///
    // Returns the next sibling node.
    ///
    func getNextSibling() -> CEFDOMNode? {
        let cefNode = cefObject.get_next_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    ///
    // Returns true if this node has child nodes.
    ///
    func hasChildren() -> Bool {
        return cefObject.has_children(cefObjectPtr) != 0
    }

    ///
    // Return the first child node.
    ///
    func getFirstChild() -> CEFDOMNode? {
        let cefNode = cefObject.get_first_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    ///
    // Returns the last child node.
    ///
    func getLastChild() -> CEFDOMNode? {
        let cefNode = cefObject.get_last_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    // The following methods are valid only for element nodes.
    
    ///
    // Returns the tag name of this element.
    ///
    func getElementTagName() -> String {
        let cefStrPtr = cefObject.get_element_tag_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    ///
    // Returns true if this element has attributes.
    ///
    func hasElementAttributes() -> Bool {
        return cefObject.has_element_attributes(cefObjectPtr) != 0
    }

    ///
    // Returns true if this element has an attribute named |attrName|.
    ///
    func hasElementAttribute(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_element_attribute(cefObjectPtr, cefStrPtr) != 0
    }

    ///
    // Returns the element attribute named |attrName|.
    ///
    func getElementAttribute(name: String) -> String {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_element_attribute(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return CEFStringToSwiftString(cefValuePtr.memory)
    }

    ///
    // Returns a map of all element attributes.
    ///
    func getElementAttributes() -> AttributeMap {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        
        cefObject.get_element_attributes(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    ///
    // Set the value for the element attribute named |attrName|. Returns true on
    // success.
    ///
    func setElementAttribute(name: String, value: String) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return cefObject.set_element_attribute(cefObjectPtr, cefNamePtr, cefValuePtr) != 0
    }

    ///
    // Returns the inner text of the element.
    ///
    func getElementInnerText() -> String {
        let cefStrPtr = cefObject.get_element_inner_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFDOMNode? {
        return CEFDOMNode(ptr: ptr)
    }
}


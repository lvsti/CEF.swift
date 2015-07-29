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

public enum CEFDOMNodeType: Int {
    case Unsupported = 0
    case Element
    case Attribute
    case Text
    case CDATASection
    case ProcessingInstructions
    case Comment
    case Document
    case DocumentType
    case DocumentFragment
    
    func toCEF() -> cef_dom_node_type_t {
        return cef_dom_node_type_t(rawValue: UInt32(rawValue))
    }
}

public class CEFDOMNode: CEFProxy<cef_domnode_t> {

    public typealias AttributeMap = [String: String]
    public typealias Type = CEFDOMNodeType
    
    func getType() -> Type {
        let cefType = cefObject.get_type(cefObjectPtr)
        return Type(rawValue: Int(cefType.rawValue))!
    }

    func isText() -> Bool {
        return cefObject.is_text(cefObjectPtr) != 0
    }

    func isElement() -> Bool {
        return cefObject.is_element(cefObjectPtr) != 0
    }

    func isEditable() -> Bool {
        return cefObject.is_editable(cefObjectPtr) != 0
    }

    func isFormControlElement() -> Bool {
        return cefObject.is_form_control_element(cefObjectPtr) != 0
    }
    
    func getFormControlElementType() -> String {
        let cefStrPtr = cefObject.get_form_control_element_type(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    func isSame(other: CEFDOMNode) -> Bool {
        return cefObject.is_same(cefObjectPtr, other.toCEF()) != 0
    }
    
    func getName() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    func getValue() -> String {
        let cefStrPtr = cefObject.get_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    func setValue(value: String)-> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(value)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.set_value(cefObjectPtr, cefStrPtr) != 0
    }

    func getAsMarkup() -> String {
        let cefStrPtr = cefObject.get_as_markup(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    func getDocument() -> CEFDOMDocument {
        let cefDoc = cefObject.get_document(cefObjectPtr)
        return CEFDOMDocument.fromCEF(cefDoc)!
    }
    
    func getParent() -> CEFDOMNode? {
        let cefNode = cefObject.get_parent(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    func getPreviousSibling() -> CEFDOMNode? {
        let cefNode = cefObject.get_previous_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    func getNextSibling() -> CEFDOMNode? {
        let cefNode = cefObject.get_next_sibling(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    func hasChildren() -> Bool {
        return cefObject.has_children(cefObjectPtr) != 0
    }

    func getFirstChild() -> CEFDOMNode? {
        let cefNode = cefObject.get_first_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }

    func getLastChild() -> CEFDOMNode? {
        let cefNode = cefObject.get_last_child(cefObjectPtr)
        return CEFDOMNode.fromCEF(cefNode)
    }
    
    func getElementTagName() -> String {
        let cefStrPtr = cefObject.get_element_tag_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    func hasElementAttributes() -> Bool {
        return cefObject.has_element_attributes(cefObjectPtr) != 0
    }

    func hasElementAttribute(name: String) -> Bool {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefObject.has_element_attribute(cefObjectPtr, cefStrPtr) != 0
    }

    func getElementAttribute(name: String) -> String {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = cefObject.get_element_attribute(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return CEFStringToSwiftString(cefValuePtr.memory)
    }

    func getElementAttributes() -> AttributeMap {
        let cefMap = cef_string_map_alloc()
        defer { cef_string_map_free(cefMap) }
        
        cefObject.get_element_attributes(cefObjectPtr, cefMap)
        return CEFStringMapToSwiftDictionary(cefMap)
    }
    
    func setElementAttribute(name: String, value: String) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefValuePtr = CEFStringPtrCreateFromSwiftString(value)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefValuePtr)
        }
        return cefObject.set_element_attribute(cefObjectPtr, cefNamePtr, cefValuePtr) != 0
    }

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


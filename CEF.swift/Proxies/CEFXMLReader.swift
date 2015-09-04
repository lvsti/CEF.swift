//
//  CEFXMLReader.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_xml_reader_t: CEFObject {
}

/// Class that supports the reading of XML data via the libxml streaming API.
/// The methods of this class should only be called on the thread that creates
/// the object.
public class CEFXMLReader: CEFProxy<cef_xml_reader_t> {

    /// Create a new CefXmlReader object. The returned object's methods can only
    /// be called from the thread that created the object.
    public init?(stream: CEFStreamReader, encoding: CEFXMLEncodingType, uri: NSURL) {
        let cefURLPtr = CEFStringPtrCreateFromSwiftString(uri.absoluteString)
        defer { CEFStringPtrRelease(cefURLPtr) }
        super.init(ptr: cef_xml_reader_create(stream.toCEF(), encoding.toCEF(), cefURLPtr))
    }
    
    /// Moves the cursor to the next node in the document. This method must be
    /// called at least once to set the current cursor position. Returns true if
    /// the cursor position was set successfully.
    public func moveToNextNode() -> Bool {
        return cefObject.move_to_next_node(cefObjectPtr) != 0
    }

    /// Close the document. This should be called directly to ensure that cleanup
    /// occurs on the correct thread.
    public func close() -> Bool {
        return cefObject.close(cefObjectPtr) != 0
    }

    /// Returns true if an error has been reported by the XML parser.
    public var hasError: Bool {
        return cefObject.has_error(cefObjectPtr) != 0
    }

    /// Returns the error string.
    public var error: String? {
        let cefStrPtr = cefObject.get_error(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    // The below methods retrieve data for the node at the current cursor
    // position.
    
    /// Returns the node type.
    public var type: CEFXMLNodeType {
        let cefType = cefObject.get_type(cefObjectPtr)
        return CEFXMLNodeType.fromCEF(cefType)
    }

    /// Returns the node depth. Depth starts at 0 for the root node.
    public var depth: Int {
        return Int(cefObject.get_depth(cefObjectPtr))
    }

    /// Returns the local name. See
    /// http://www.w3.org/TR/REC-xml-names/#NT-LocalPart for additional details.
    public var localName: String {
        let cefStrPtr = cefObject.get_local_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the namespace prefix. See http://www.w3.org/TR/REC-xml-names/ for
    /// additional details.
    public var prefix: String {
        let cefStrPtr = cefObject.get_prefix(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the qualified name, equal to (Prefix:)LocalName. See
    /// http://www.w3.org/TR/REC-xml-names/#ns-qualnames for additional details.
    public var qualifiedName: String {
        let cefStrPtr = cefObject.get_qualified_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the URI defining the namespace associated with the node. See
    /// http://www.w3.org/TR/REC-xml-names/ for additional details.
    public var namespaceURI: NSURL {
        let cefStrPtr = cefObject.get_namespace_uri(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    /// Returns the base URI of the node. See http://www.w3.org/TR/xmlbase/ for
    /// additional details.
    public var baseURI: NSURL {
        let cefStrPtr = cefObject.get_base_uri(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return NSURL(string: CEFStringToSwiftString(cefStrPtr.memory))!
    }
    
    /// Returns the xml:lang scope within which the node resides. See
    /// http://www.w3.org/TR/REC-xml/#sec-lang-tag for additional details.
    public var xmlLang: String {
        let cefStrPtr = cefObject.get_xml_lang(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns true if the node represents an empty element. <a/> is considered
    /// empty but <a></a> is not.
    public var isEmptyElement: Bool {
        return cefObject.is_empty_element(cefObjectPtr) != 0
    }
    
    /// Returns true if the node has a text value.
    public var hasValue: Bool {
        return cefObject.has_value(cefObjectPtr) != 0
    }

    /// Returns the text value.
    public var value: String? {
        let cefStrPtr = cefObject.get_value(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Returns true if the node has attributes.
    public var hasAttributes: Bool {
        return cefObject.has_attributes(cefObjectPtr) != 0
    }

    /// Returns the number of attributes.
    public func attributeCount() -> size_t {
        return cefObject.get_attribute_count(cefObjectPtr)
    }

    /// Returns the value of the attribute at the specified 0-based index.
    public func attributeAtIndex(index: Int) -> String? {
        let cefStrPtr = cefObject.get_attribute_byindex(cefObjectPtr, Int32(index))
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Returns the value of the attribute with the specified qualified name.
    public func attributeForQualifiedName(qualifiedName: String) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(qualifiedName)
        let cefStrPtr = cefObject.get_attribute_byqname(cefObjectPtr, cefNamePtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Returns the value of the attribute with the specified local name and
    /// namespace URI.
    public func attributeForName(name: String, namespaceURI: NSURL) -> String? {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefURIPtr = CEFStringPtrCreateFromSwiftString(namespaceURI.absoluteString)
        let cefStrPtr = cefObject.get_attribute_bylname(cefObjectPtr, cefNamePtr, cefURIPtr)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefURIPtr)
            CEFStringPtrRelease(cefStrPtr)
        }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    /// Returns an XML representation of the current node's children.
    public var innerXML: String {
        let cefStrPtr = cefObject.get_inner_xml(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns an XML representation of the current node including its children.
    public var outerXML: String {
        let cefStrPtr = cefObject.get_outer_xml(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    /// Returns the line number for the current node.
    public var lineNumber: Int {
        return Int(cefObject.get_line_number(cefObjectPtr))
    }

    // Attribute nodes are not traversed by default. The below methods can be
    // used to move the cursor to an attribute node. MoveToCarryingElement() can
    // be called afterwards to return the cursor to the carrying element. The
    // depth of an attribute node will be 1 + the depth of the carrying element.
    
    /// Moves the cursor to the attribute at the specified 0-based index. Returns
    /// true if the cursor position was set successfully.
    public func moveToAttributeAtIndex(index: Int) -> Bool {
        return cefObject.move_to_attribute_byindex(cefObjectPtr, Int32(index)) != 0
    }

    /// Moves the cursor to the attribute with the specified qualified name.
    /// Returns true if the cursor position was set successfully.
    public func moveToAttributeWithQualifiedName(qualifiedName: String) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(qualifiedName)
        defer { CEFStringPtrRelease(cefNamePtr) }
        return cefObject.move_to_attribute_byqname(cefObjectPtr, cefNamePtr) != 0
    }
    
    /// Moves the cursor to the attribute with the specified local name and
    /// namespace URI. Returns true if the cursor position was set successfully.
    public func moveToAttributeWithName(name: String, namespaceURI: NSURL) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefURIPtr = CEFStringPtrCreateFromSwiftString(namespaceURI.absoluteString)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefURIPtr)
        }
        return cefObject.move_to_attribute_bylname(cefObjectPtr, cefNamePtr, cefURIPtr) != 0
    }
    
    /// Moves the cursor to the first attribute in the current element. Returns
    /// true if the cursor position was set successfully.
    public func moveToFirstAttribute() -> Bool {
        return cefObject.move_to_first_attribute(cefObjectPtr) != 0
    }

    /// Moves the cursor to the next attribute in the current element. Returns
    /// true if the cursor position was set successfully.
    public func moveToNextAttribute() -> Bool {
        return cefObject.move_to_next_attribute(cefObjectPtr) != 0
    }
    
    /// Moves the cursor back to the carrying element. Returns true if the cursor
    /// position was set successfully.
    public func moveToCarryingElement() -> Bool {
        return cefObject.move_to_carrying_element(cefObjectPtr) != 0
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFXMLReader? {
        return CEFXMLReader(ptr: ptr)
    }
}

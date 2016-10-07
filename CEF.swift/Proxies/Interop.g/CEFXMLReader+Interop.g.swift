//
//  CEFXMLReader+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_xml_reader.h.
//

import Foundation

extension cef_xml_reader_t: CEFObject {}

/// Class that supports the reading of XML data via the libxml streaming API.
/// The methods of this class should only be called on the thread that creates
/// the object.
/// CEF name: `CefXmlReader`
public class CEFXMLReader: CEFProxy<cef_xml_reader_t> {
    override init?(ptr: UnsafeMutablePointer<cef_xml_reader_t>?) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(_ ptr: UnsafeMutablePointer<cef_xml_reader_t>?) -> CEFXMLReader? {
        return CEFXMLReader(ptr: ptr)
    }
}


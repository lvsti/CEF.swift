//
//  CEFZipReader+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_zip_reader.h.
//

import Foundation

extension cef_zip_reader_t: CEFObject {}

/// Class that supports the reading of zip archives via the zlib unzip API.
/// The methods of this class should only be called on the thread that creates
/// the object.
public class CEFZipReader: CEFProxy<cef_zip_reader_t> {
    override init?(ptr: UnsafeMutablePointer<cef_zip_reader_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_zip_reader_t>) -> CEFZipReader? {
        return CEFZipReader(ptr: ptr)
    }
}


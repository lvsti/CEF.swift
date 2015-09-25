//
//  CEFStreamReader+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_stream_reader_t: CEFObject {}

/// Class used to read data from a stream. The methods of this class may be
/// called on any thread.
public class CEFStreamReader: CEFProxy<cef_stream_reader_t> {
    override init?(ptr: UnsafeMutablePointer<cef_stream_reader_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_stream_reader_t>) -> CEFStreamReader? {
        return CEFStreamReader(ptr: ptr)
    }
}


//
//  CEFStreamWriter+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_stream.h.
//

import Foundation

extension cef_stream_writer_t: CEFObject {}

/// Class used to write data to a stream. The methods of this class may be called
/// on any thread.
public class CEFStreamWriter: CEFProxy<cef_stream_writer_t> {
    override init?(ptr: UnsafeMutablePointer<cef_stream_writer_t>) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: UnsafeMutablePointer<cef_stream_writer_t>) -> CEFStreamWriter? {
        return CEFStreamWriter(ptr: ptr)
    }
}


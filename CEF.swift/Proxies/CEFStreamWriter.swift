//
//  CEFStreamWriter.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_stream_writer_t: CEFObject {
}

/// Class used to write data to a stream. The methods of this class may be called
/// on any thread.
public class CEFStreamWriter: CEFProxy<cef_stream_writer_t> {
    /// Create a new CefStreamWriter object for a file.
    public init?(filePath: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(filePath)
        defer { CEFStringPtrRelease(cefStrPtr) }
        super.init(ptr: cef_stream_writer_create_for_file(cefStrPtr))
    }

    /// Create a new CefStreamWriter object for a custom handler.
    public init?(handler: CEFWriteHandler) {
        super.init(ptr: cef_stream_writer_create_for_handler(handler.toCEF()))
    }
    
    /// Write raw binary data.
    func write(buffer: UnsafePointer<Void>, chunkSize: size_t, count: size_t) -> size_t {
        return cefObject.write(cefObjectPtr, buffer, chunkSize, count)
    }

    /// Seek to the specified offset position. |whence| may be any one of
    /// SEEK_CUR, SEEK_END or SEEK_SET. Returns zero on success and non-zero on
    /// failure.
    func seek(offset: Int64, whence: CEFSeekPosition) -> Bool {
        return cefObject.seek(cefObjectPtr, offset, whence.rawValue) == 0
    }
    
    /// Return the current offset position.
    func tell() -> Int64 {
        return cefObject.tell(cefObjectPtr)
    }
    
    /// Flush the stream.
    func flush() -> Bool {
        return cefObject.flush(cefObjectPtr) != 0
    }
    
    /// Returns true if this reader performs work like accessing the file system
    /// which may block. Used as a hint for determining the thread to access the
    /// reader from.
    func mayBlock() -> Bool {
        return cefObject.may_block(cefObjectPtr) != 0
    }
    
    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFStreamWriter? {
        return CEFStreamWriter(ptr: ptr)
    }

}


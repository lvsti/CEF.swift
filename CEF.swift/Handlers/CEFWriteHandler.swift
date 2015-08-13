//
//  CEFWriteHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface the client can implement to provide a custom stream writer. The
// methods of this class may be called on any thread.
///
public protocol CEFWriteHandler {
    ///
    // Write raw binary data.
    ///
    func write(buffer: UnsafePointer<Void>, chunkSize: size_t, count: size_t) -> size_t
    
    ///
    // Seek to the specified offset position. |whence| may be any one of
    // SEEK_CUR, SEEK_END or SEEK_SET. Return zero on success and non-zero on
    // failure.
    ///
    func seek(offset: Int64, whence: CEFSeekPosition) -> Bool
    
    ///
    // Return the current offset position.
    ///
    func tell() -> Int64
    
    ///
    // Flush the stream.
    ///
    func flush() -> Bool
    
    ///
    // Return true if this handler performs work like accessing the file system
    // which may block. Used as a hint for determining the thread to access the
    // handler from.
    ///
    func mayBlock() -> Bool
}


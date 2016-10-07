//
//  CEFWriteHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Interface the client can implement to provide a custom stream writer. The
/// methods of this class may be called on any thread.
/// CEF name: `CefWriteHandler`
public protocol CEFWriteHandler {
    /// Write raw binary data.
    /// CEF name: `Write`
    func write(buffer: UnsafeRawPointer, chunkSize: size_t, count: size_t) -> size_t
    
    /// Seek to the specified offset position. |whence| may be any one of
    /// SEEK_CUR, SEEK_END or SEEK_SET. Return zero on success and non-zero on
    /// failure.
    /// CEF name: `Seek`
    func seek(offset: Int64, whence: CEFSeekPosition) -> Bool
    
    /// Return the current offset position.
    /// CEF name: `Tell`
    func tell() -> Int64
    
    /// Flush the stream.
    /// CEF name: `Flush`
    func flush() -> Bool
    
    /// Return true if this handler performs work like accessing the file system
    /// which may block. Used as a hint for determining the thread to access the
    /// handler from.
    /// CEF name: `MayBlock`
    func mayBlock() -> Bool
}


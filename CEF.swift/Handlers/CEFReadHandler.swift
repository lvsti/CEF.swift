//
//  CEFReadHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 13..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Interface the client can implement to provide a custom stream reader. The
// methods of this class may be called on any thread.
///
public protocol CEFReadHandler {
    ///
    // Read raw binary data.
    ///
    func read(buffer: UnsafeMutablePointer<Void>, chunkSize: size_t, count: size_t) -> size_t
    
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
    // Return non-zero if at end of file.
    ///
    func isEOF() -> Bool
    
    ///
    // Return true if this handler performs work like accessing the file system
    // which may block. Used as a hint for determining the thread to access the
    // handler from.
    ///
    func mayBlock() -> Bool
}


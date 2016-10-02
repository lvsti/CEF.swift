//
//  CEFResponseFilter.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 12. 19..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFResponseFilterInitAction {
    case allow
    case cancel
}

extension CEFResponseFilterInitAction {
    public var boolValue: Bool { return self == .allow }
}


/// Implement this interface to filter resource response content. The methods of
/// this class will be called on the browser process IO thread.
public protocol CEFResponseFilter {
    
    /// Initialize the response filter. Will only be called a single time. The
    /// filter will not be installed if this method returns false.
    func onFilterInit() -> CEFResponseFilterInitAction
    
    /// Called to filter a chunk of data. |data_in| is the input buffer containing
    /// |data_in_size| bytes of pre-filter data (|data_in| will be NULL if
    /// |data_in_size| is zero). |data_out| is the output buffer that can accept up
    /// to |data_out_size| bytes of filtered output data. Set |data_in_read| to the
    /// number of bytes that were read from |data_in|. Set |data_out_written| to
    /// the number of bytes that were written into |data_out|. If some or all of
    /// the pre-filter data was read successfully but more data is needed in order
    /// to continue filtering (filtered output is pending) return
    /// RESPONSE_FILTER_NEED_MORE_DATA. If some or all of the pre-filter data was
    /// read successfully and all available filtered output has been written return
    /// RESPONSE_FILTER_DONE. If an error occurs during filtering return
    /// RESPONSE_FILTER_ERROR. This method will be called repeatedly until there is
    /// no more data to filter (resource response is complete), |data_in_read|
    /// matches |data_in_size| (all available pre-filter bytes have been read), and
    /// the method returns RESPONSE_FILTER_DONE or RESPONSE_FILTER_ERROR. Do not
    /// keep a reference to the buffers passed to this method.
    /*--cef(optional_param=data_in,default_retval=RESPONSE_FILTER_ERROR)--*/
    func filterResponseChunk(inputChunk: UnsafePointer<Void>,
                             ofSize: size_t,
                             intoBuffer: UnsafeMutablePointer<Void>,
                             ofCapacity: size_t) -> (bytesRead: size_t, bytesWriten: size_t, status: CEFResponseFilterStatus)
    
}

public extension CEFResponseFilter {

    func onFilterInit() -> CEFResponseFilterInitAction {
        return .cancel
    }

    func filterResponseChunk(inputChunk: UnsafePointer<Void>,
                             ofSize: size_t,
                             intoBuffer: UnsafeMutablePointer<Void>,
                             ofCapacity: size_t) -> (bytesRead: size_t, bytesWriten: size_t, status: CEFResponseFilterStatus) {
        return (0, 0, .Error)
    }
    
}

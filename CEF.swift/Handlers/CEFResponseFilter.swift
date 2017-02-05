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


/// Implement this interface to filter resource response content. The methods of
/// this class will be called on the browser process IO thread.
/// CEF name: `CefResponseFilter`
public protocol CEFResponseFilter {
    
    /// Initialize the response filter. Will only be called a single time. The
    /// filter will not be installed if this method returns false.
    /// CEF name: `InitFilter`
    func onFilterInit() -> CEFResponseFilterInitAction
    
    /// Called to filter a chunk of data. Expected usage is as follows:
    ///
    ///  A. Read input data from |data_in| and set |data_in_read| to the number of
    ///     bytes that were read up to a maximum of |data_in_size|. |data_in| will
    ///     be NULL if |data_in_size| is zero.
    ///  B. Write filtered output data to |data_out| and set |data_out_written| to
    ///     the number of bytes that were written up to a maximum of
    ///     |data_out_size|. If no output data was written then all data must be
    ///     read from |data_in| (user must set |data_in_read| = |data_in_size|).
    ///  C. Return RESPONSE_FILTER_DONE if all output data was written or
    ///     RESPONSE_FILTER_NEED_MORE_DATA if output data is still pending.
    ///
    /// This method will be called repeatedly until the input buffer has been
    /// fully read (user sets |data_in_read| = |data_in_size|) and there is no
    /// more input data to filter (the resource response is complete). This method
    /// may then be called an additional time with an empty input buffer if the
    /// user filled the output buffer (set |data_out_written| = |data_out_size|)
    /// and returned RESPONSE_FILTER_NEED_MORE_DATA to indicate that output data is
    /// still pending.
    ///
    /// Calls to this method will stop when one of the following conditions is met:
    ///
    ///  A. There is no more input data to filter (the resource response is
    ///     complete) and the user sets |data_out_written| = 0 or returns
    ///     RESPONSE_FILTER_DONE to indicate that all data has been written, or;
    ///  B. The user returns RESPONSE_FILTER_ERROR to indicate an error.
    ///
    /// Do not keep a reference to the buffers passed to this method.
    /// CEF name: `Filter`
    func filterResponseChunk(inputChunk: UnsafeRawPointer?,
                             ofSize: size_t,
                             intoBuffer: UnsafeMutableRawPointer,
                             ofCapacity: size_t) -> (bytesRead: size_t, bytesWriten: size_t, status: CEFResponseFilterStatus)
    
}

public extension CEFResponseFilter {

    func onFilterInit() -> CEFResponseFilterInitAction {
        return .cancel
    }

    func filterResponseChunk(inputChunk: UnsafeRawPointer?,
                             ofSize: size_t,
                             intoBuffer: UnsafeMutableRawPointer,
                             ofCapacity: size_t) -> (bytesRead: size_t, bytesWriten: size_t, status: CEFResponseFilterStatus) {
        return (0, 0, .error)
    }
    
}

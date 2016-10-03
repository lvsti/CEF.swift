//
//  CEFResponseFilter+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 12. 19..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFResponseFilter_init_filter(ptr: UnsafeMutablePointer<cef_response_filter_t>?) -> Int32 {
    guard let obj = CEFResponseFilterMarshaller.get(ptr) else {
        return 0
    }
    
    let action = obj.onFilterInit()
    return action == .allow ? 1 : 0
}

func CEFResponseFilter_filter(ptr: UnsafeMutablePointer<cef_response_filter_t>?,
                              dataIn: UnsafeMutableRawPointer?,
                              dataInSize: size_t,
                              dataInRead: UnsafeMutablePointer<size_t>?,
                              dataOut: UnsafeMutableRawPointer?,
                              dataOutSize: size_t,
                              dataOutWritten: UnsafeMutablePointer<size_t>?) -> cef_response_filter_status_t {
    guard let obj = CEFResponseFilterMarshaller.get(ptr) else {
        return CEFResponseFilterStatus.error.toCEF()
    }
    
    let (bytesRead, bytesWritten, status) = obj.filterResponseChunk(inputChunk: dataIn!,
                                                                    ofSize: dataInSize,
                                                                    intoBuffer: dataOut!,
                                                                    ofCapacity: dataOutSize)
    
    dataInRead!.pointee = bytesRead
    dataOutWritten!.pointee = bytesWritten
    
    return status.toCEF()
}

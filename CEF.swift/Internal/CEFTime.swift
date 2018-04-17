//
//  CEFTime.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFTimeToSwiftDate(_ cefTime: cef_time_t) -> Date {
    var time: Double = 0;
    var tmpTime = cefTime
    cef_time_to_doublet(&tmpTime, &time)
    return Date(timeIntervalSince1970: time)
}

func CEFTimePtrCreateFromSwiftDate(_ date: Date) -> UnsafeMutablePointer<cef_time_t> {
    let cefTime = UnsafeMutablePointer<cef_time_t>.allocate(capacity: 1)
    CEFTimeSetFromSwiftDate(date, cefTimePtr: cefTime)
    return cefTime
}

func CEFTimePtrRelease(_ ptr: UnsafeMutablePointer<cef_time_t>?) {
    if let ptr = ptr {
        ptr.deallocate()
    }
}

func CEFTimeSetFromSwiftDate(_ date: Date, cefTimePtr ptr: UnsafeMutablePointer<cef_time_t>) {
    cef_time_from_doublet(date.timeIntervalSince1970, ptr)
}


//
//  CEFTime.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 26..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFTimeToNSDate(_ cefTime: cef_time_t) -> NSDate {
    var time: Double = 0;
    var tmpTime = cefTime
    cef_time_to_doublet(&tmpTime, &time)
    return NSDate(timeIntervalSince1970: time)
}

func CEFTimePtrCreateFromNSDate(_ date: NSDate) -> UnsafeMutablePointer<cef_time_t> {
    let cefTime = UnsafeMutablePointer<cef_time_t>.alloc(1)
    CEFTimeSetFromNSDate(date, cefTime: cefTime)
    return cefTime
}

func CEFTimePtrRelease(_ ptr: UnsafeMutablePointer<cef_time_t>) {
    ptr.dealloc(1)
}

func CEFTimeSetFromNSDate(_ date: NSDate, cefTime ptr: UnsafeMutablePointer<cef_time_t>) {
    cef_time_from_doublet(date.timeIntervalSince1970, ptr)
}


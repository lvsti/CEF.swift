//
//  CEFMediaRouterCreateCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFMediaRouteCreateCallback_on_media_route_create_finished(ptr: UnsafeMutablePointer<cef_media_route_create_callback_t>?,
                                                                result: cef_media_route_create_result_t,
                                                                error: UnsafePointer<cef_string_t>?,
                                                                route: UnsafeMutablePointer<cef_media_route_t>?) {
    guard let obj = CEFMediaRouteCreateCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onMediaRouteCreateFinished(result: CEFMediaRouteCreateResult.fromCEF(result),
                                   error: error != nil ? CEFStringToSwiftString(error!.pointee) : nil,
                                   route: CEFMediaRoute.fromCEF(route))
}


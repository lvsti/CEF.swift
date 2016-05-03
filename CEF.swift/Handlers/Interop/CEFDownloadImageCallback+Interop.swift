//
//  CEFDownloadImageCallback+Interop.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

func CEFDownloadImageCallback_on_download_image_finished(ptr: UnsafeMutablePointer<cef_download_image_callback_t>,
                                                         imageURL: UnsafePointer<cef_string_t>,
                                                         statusCode: Int32,
                                                         image: UnsafeMutablePointer<cef_image_t>) {
    guard let obj = CEFDownloadImageCallbackMarshaller.get(ptr) else {
        return
    }
    
    obj.onDownloadImageFinished(NSURL(string: CEFStringToSwiftString(imageURL.memory))!,
                                statusCode: Int(statusCode),
                                image: CEFImage.fromCEF(image))
}

//
//  CEFDownloadImageCallbackBridge.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Method that will be executed when the image download has completed.
/// |image_url| is the URL that was downloaded and |http_status_code| is the
/// resulting HTTP status code. |image| is the resulting image, possibly at
/// multiple scale factors, or empty if the download failed.
public typealias CEFDownloadImageCallbackOnDownloadImageFinishedBlock =
    (url: NSURL, statusCode: Int, image: CEFImage?) -> Void

class CEFDownloadImageCallbackBridge: CEFDownloadImageCallback {
    let block: CEFDownloadImageCallbackOnDownloadImageFinishedBlock
    
    init(block: CEFDownloadImageCallbackOnDownloadImageFinishedBlock) {
        self.block = block
    }
    
    func onDownloadImageFinished(url: NSURL, statusCode: Int, image: CEFImage?) {
        block(url: url, statusCode: statusCode, image: image)
    }
}

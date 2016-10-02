//
//  CEFPDFPrintCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 09. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Callback structure for cef_browser_host_t::PrintToPDF. The functions of this
/// structure will be called on the browser process UI thread.
public protocol CEFPDFPrintCallback {

    /// Method that will be executed when the PDF printing has completed. |path| is
    /// the output path. |ok| will be true (1) if the printing completed
    /// successfully or false (0) otherwise.
    func onPDFPrintFinished(path: String, successfully: Bool)
    
}

public extension CEFPDFPrintCallback {

    func onPDFPrintFinished(path: String, successfully: Bool) {
    }

}


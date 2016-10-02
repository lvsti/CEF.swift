//
//  CEFPrintHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnPrintDialogAction {
    case allow
    case cancel
}

public enum CEFOnPrintJobAction {
    case allow
    case cancel
}

/// Implement this interface to handle printing on Linux. The methods of this
/// class will be called on the browser process UI thread.
public protocol CEFPrintHandler {
    /// Called when printing has started for the specified |browser|. This method
    /// will be called before the other OnPrint*() methods and irrespective of how
    /// printing was initiated (e.g. CefBrowserHost::Print(), JavaScript
    /// window.print() or PDF extension print button).
    func onPrintStart(browser: CEFBrowser)
    
    /// Synchronize |settings| with client state. If |get_defaults| is true then
    /// populate |settings| with the default print settings. Do not keep a
    /// reference to |settings| outside of this callback.
    func onPrintSettings(settings: CEFPrintSettings, defaults: Bool)
    
    /// Show the print dialog. Execute |callback| once the dialog is dismissed.
    /// Return true if the dialog will be displayed or false to cancel the
    /// printing immediately.
    func onPrintDialog(hasSelection: Bool, callback: CEFPrintDialogCallback) -> CEFOnPrintDialogAction
    
    /// Send the print job to the printer. Execute |callback| once the job is
    /// completed. Return true if the job will proceed or false to cancel the job
    /// immediately.
    func onPrintJob(documentName: String, pdfFilePath: String, callback: CEFPrintJobCallback) -> CEFOnPrintJobAction
    
    /// Reset client state related to printing.
    func onPrintReset()

    /// Return the PDF paper size in device units. Used in combination with
    /// CefBrowserHost::PrintToPDF().
    func pdfPaperSizeForDPI(deviceUnitsPerInch: Int) -> NSSize
}

public extension CEFPrintHandler {
    func onPrintStart(browser: CEFBrowser) {
    }

    func onPrintSettings(settings: CEFPrintSettings, defaults: Bool) {
    }
    
    func onPrintDialog(hasSelection: Bool, callback: CEFPrintDialogCallback) -> CEFOnPrintDialogAction {
        return .allow
    }
    
    func onPrintJob(documentName: String, pdfFilePath: String, callback: CEFPrintJobCallback) -> CEFOnPrintJobAction {
        return .allow
    }
    
    func onPrintReset() {
    }

    func pdfPaperSizeForDPI(deviceUnitsPerInch: Int) -> NSSize {
        return NSSize()
    }
}


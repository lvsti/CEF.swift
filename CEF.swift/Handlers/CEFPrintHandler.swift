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

/// Implement this interface to handle printing on Linux. Each browser will have
/// only one print job in progress at a time. The methods of this class will be
/// called on the browser process UI thread.
/// CEF name: `CefPrintHandler`
public protocol CEFPrintHandler {
    /// Called when printing has started for the specified |browser|. This method
    /// will be called before the other OnPrint*() methods and irrespective of how
    /// printing was initiated (e.g. CefBrowserHost::Print(), JavaScript
    /// window.print() or PDF extension print button).
    /// CEF name: `OnPrintStart`
    func onPrintStart(browser: CEFBrowser)
    
    /// Synchronize |settings| with client state. If |get_defaults| is true then
    /// populate |settings| with the default print settings. Do not keep a
    /// reference to |settings| outside of this callback.
    /// CEF name: `OnPrintSettings`
    func onPrintSettings(browser: CEFBrowser, settings: CEFPrintSettings, defaults: Bool)
    
    /// Show the print dialog. Execute |callback| once the dialog is dismissed.
    /// Return true if the dialog will be displayed or false to cancel the
    /// printing immediately.
    /// CEF name: `OnPrintDialog`
    func onPrintDialog(browser: CEFBrowser, hasSelection: Bool, callback: CEFPrintDialogCallback) -> CEFOnPrintDialogAction
    
    /// Send the print job to the printer. Execute |callback| once the job is
    /// completed. Return true if the job will proceed or false to cancel the job
    /// immediately.
    /// CEF name: `OnPrintJob`
    func onPrintJob(browser: CEFBrowser, documentName: String, pdfFilePath: String, callback: CEFPrintJobCallback) -> CEFOnPrintJobAction
    
    /// Reset client state related to printing.
    /// CEF name: `OnPrintReset`
    func onPrintReset(browser: CEFBrowser)

    /// Return the PDF paper size in device units. Used in combination with
    /// CefBrowserHost::PrintToPDF().
    /// CEF name: `GetPdfPaperSize`
    func pdfPaperSize(browser: CEFBrowser, forDeviceUnitsPerInch: Int) -> NSSize
}

public extension CEFPrintHandler {
    func onPrintStarted(browser: CEFBrowser) {
    }

    func onPrintSettings(browser: CEFBrowser, settings: CEFPrintSettings, defaults: Bool) {
    }
    
    func onPrintDialog(browser: CEFBrowser, hasSelection: Bool, callback: CEFPrintDialogCallback) -> CEFOnPrintDialogAction {
        return .allow
    }
    
    func onPrintJob(browser: CEFBrowser, documentName: String, pdfFilePath: String, callback: CEFPrintJobCallback) -> CEFOnPrintJobAction {
        return .allow
    }
    
    func onPrintReset(browser: CEFBrowser) {
    }

    func pdfPaperSize(browser: CEFBrowser, forDeviceUnitsPerInch: Int) -> NSSize {
        return .zero
    }
}


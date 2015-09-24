//
//  PrintHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum OnPrintDialogAction {
    case Allow
    case Cancel
}

extension OnPrintDialogAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

public enum OnPrintJobAction {
    case Allow
    case Cancel
}

extension OnPrintJobAction: BooleanType {
    public var boolValue: Bool { return self == .Allow }
}

/// Implement this interface to handle printing on Linux. The methods of this
/// class will be called on the browser process UI thread.
public protocol PrintHandler {
    /// Synchronize |settings| with client state. If |get_defaults| is true then
    /// populate |settings| with the default print settings. Do not keep a
    /// reference to |settings| outside of this callback.
    func onPrintSettings(settings: PrintSettings, defaults: Bool)
    
    /// Show the print dialog. Execute |callback| once the dialog is dismissed.
    /// Return true if the dialog will be displayed or false to cancel the
    /// printing immediately.
    func onPrintDialog(hasSelection: Bool, callback: PrintDialogCallback) -> OnPrintDialogAction
    
    /// Send the print job to the printer. Execute |callback| once the job is
    /// completed. Return true if the job will proceed or false to cancel the job
    /// immediately.
    func onPrintJob(documentName: String, pdfFilePath: String, callback: PrintJobCallback) -> OnPrintJobAction
    
    /// Reset client state related to printing.
    func onPrintReset()

}

public extension PrintHandler {
    func onPrintSettings(settings: PrintSettings, defaults: Bool) {
    }
    
    func onPrintDialog(hasSelection: Bool, callback: PrintDialogCallback) -> OnPrintDialogAction {
        return .Allow
    }
    
    func onPrintJob(documentName: String, pdfFilePath: String, callback: PrintJobCallback) -> OnPrintJobAction {
        return .Allow
    }
    
    func onPrintReset() {
    }
    
}


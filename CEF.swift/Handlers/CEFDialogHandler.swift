//
//  CEFDialogHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public enum CEFOnFileDialogAction {
    case ShowDefault
    case ShowCustom
}

extension CEFOnFileDialogAction: BooleanType {
    public var boolValue: Bool { return self == .ShowCustom }
}

/// Implement this interface to handle dialog events. The methods of this class
/// will be called on the browser process UI thread.
public protocol CEFDialogHandler {
    
    /// Called to run a file chooser dialog. |mode| represents the type of dialog
    /// to display. |title| to the title to be used for the dialog and may be empty
    /// to show the default title ("Open" or "Save" depending on the mode).
    /// |default_file_path| is the path with optional directory and/or file name
    /// component that should be initially selected in the dialog. |accept_filters|
    /// are used to restrict the selectable file types and may any combination of
    /// (a) valid lower-cased MIME types (e.g. "text/*" or "image/*"),
    /// (b) individual file extensions (e.g. ".txt" or ".png"), or (c) combined
    /// description and file extension delimited using "|" and ";" (e.g.
    /// "Image Types|.png;.gif;.jpg"). |selected_accept_filter| is the 0-based
    /// index of the filter that should be selected by default. To display a custom
    /// dialog return true and execute |callback| either inline or at a later time.
    /// To display the default dialog return false.
    func onFileDialog(browser: CEFBrowser,
                      mode: CEFFileDialogMode,
                      title: String?,
                      defaultPath: String?,
                      acceptFilters: [String],
                      selectedFilterIndex: Int,
                      callback: CEFFileDialogCallback) -> CEFOnFileDialogAction

}

public extension CEFDialogHandler {

    func onFileDialog(browser: CEFBrowser,
                      mode: CEFFileDialogMode,
                      title: String?,
                      defaultPath: String?,
                      acceptFilters: [String],
                      selectedFilterIndex: Int,
                      callback: CEFFileDialogCallback) -> CEFOnFileDialogAction {
        return .ShowDefault
    }
}


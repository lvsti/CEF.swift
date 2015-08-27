//
//  CEFJSDialogCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_jsdialog_callback_t: CEFObject {
}

/// Callback interface used for asynchronous continuation of JavaScript dialog
/// requests.
public class CEFJSDialogCallback: CEFProxy<cef_jsdialog_callback_t> {
    
    /// Continue the JS dialog request. Set |success| to true if the OK button was
    /// pressed. The |user_input| value should be specified for prompt dialogs.
    public func doContinue(success: Bool, userInput: String? = nil) {
        let cefStrPtr: UnsafeMutablePointer<cef_string_t> =
            userInput != nil ? CEFStringPtrCreateFromSwiftString(userInput!) : nil
        defer { CEFStringPtrRelease(cefStrPtr) }
        cefObject.cont(cefObjectPtr, success ? 1 : 0, cefStrPtr)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFJSDialogCallback? {
        return CEFJSDialogCallback(ptr: ptr)
    }

}


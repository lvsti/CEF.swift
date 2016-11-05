//
//  CEFRegisterCDMCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 11. 05..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface to receive notification when CDM registration is
/// complete. The methods of this class will be called on the browser process
/// UI thread.
/// CEF name: `CefRegisterCdmCallback`
public protocol CEFRegisterCDMCallback {
    
    /// Method that will be called when CDM registration is complete. |result|
    /// will be CEF_CDM_REGISTRATION_ERROR_NONE if registration completed
    /// successfully. Otherwise, |result| and |error_message| will contain
    /// additional information about why registration failed.
    /// CEF name: `OnCdmRegistrationComplete`
    func onCDMRegistrationComplete(result: CEFCDMRegistrationError, message: String?)
    
}

public extension CEFRegisterCDMCallback {
    
    func onCDMRegistrationComplete(result: CEFCDMRegistrationError, message: String?) {
    }
    
}

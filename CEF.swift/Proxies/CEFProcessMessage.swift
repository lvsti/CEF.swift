//
//  CEFProcessMessage.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 25..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFProcessMessage {

    public enum Message: String {
        // case evaluateJavascriptRequest = "CSEJSREQ"
        // Message containing the result for a given evaluation
        // case evaluateJavascriptResponse = "CSEJSRES"
        // Message to invoke a stored js function

        // case javascriptCallbackRequest = "CSJSCBREQ"
        // Message to dereference a stored js function
        // case javascriptCallbackDestroyRequest = "CSJSCBDR"
        // Message containing the result of a given js function call
        // case javascriptCallbackResponse = "CSJSCBRES"

        // Message containing a request JSB root objects
        // case javascriptRootObjectRequest = "CSJSROREQ"
        // Message containing the response for the JSB root objects
        // case javascriptRootObjectResponse = "CSJSRORES"
        // Message from the render process to request a method invocation on a bound object

        case javascriptAsyncMethodCallRequest = "CSJSAMCREQ"
        // Message from the browser process containing the result of a bound method invocation
        case javascriptAsyncMethodCallResponse = "CSJSAMCRES"
        // Message that signals a new V8Context has been created

        case onContextCreatedRequest = "CSOCCR"
        // Message that signals a new V8Context has been released
        case onContextReleasedRequest = "CSOCRR"
        // Message from the render process that an element (or nothing) has
        // gotten focus. This message is only sent if specified as an
        // optional message via command line argument when the subprocess is
        // created.

        case onFocusedNodeChanged = "CSOFNC"
        // Message that signals an uncaught exception has occurred
        case onUncaughtException = "CSOUE"
        // Message containing a request/notification that JSB objects have been bound

        case javascriptObjectsBoundInJavascript = "CSJSOBJ"
    }

    public convenience init?(_ message: Message) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(message.rawValue)
        defer { CEFStringPtrRelease(cefStrPtr) }

        self.init(ptr: cef_process_message_create(cefStrPtr))
    }

    /// Create a new CefProcessMessage object with the specified name.
    /// CEF name: `Create`
    public convenience init?(name: String) {
        let cefStrPtr = CEFStringPtrCreateFromSwiftString(name)
        defer { CEFStringPtrRelease(cefStrPtr) }

        self.init(ptr: cef_process_message_create(cefStrPtr))
    }

    /// Returns true if this object is valid. Do not call any other methods if this
    /// function returns false.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if the values of this object are read-only. Some APIs may
    /// expose read-only objects.
    /// CEF name: `IsReadOnly`
    public var isReadOnly: Bool {
        return cefObject.is_read_only(cefObjectPtr) != 0
    }

    /// Returns a writable copy of this object.
    /// CEF name: `Copy`
    public func copy() -> CEFProcessMessage? {
        let cefProcMsg = cefObject.copy(cefObjectPtr)
        return CEFProcessMessage.fromCEF(cefProcMsg)
    }

    /// Returns the message name.
    /// CEF name: `GetName`
    public var name: String {
        let cefNamePtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefNamePtr) }
        
        return CEFStringToSwiftString(cefNamePtr!.pointee)
    }

    /// Returns the list of arguments.
    /// CEF name: `GetArgumentList`
    public var argumentList: CEFListValue? {
        let cefList = cefObject.get_argument_list(cefObjectPtr)
        return CEFListValue.fromCEF(cefList)
    }

}

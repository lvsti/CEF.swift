//
//  CEFV8Utils.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 08..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public struct CEFV8Utils {
    /// Register a new V8 extension with the specified JavaScript extension code and
    /// handler. Functions implemented by the handler are prototyped using the
    /// keyword 'native'. The calling of a native function is restricted to the scope
    /// in which the prototype of the native function is defined. This function may
    /// only be called on the render process main thread.
    ///
    /// Example JavaScript extension code:
    /// <pre>
    ///   // create the 'example' global object if it doesn't already exist.
    ///   if (!example)
    ///     example = {};
    ///   // create the 'example.test' global object if it doesn't already exist.
    ///   if (!example.test)
    ///     example.test = {};
    ///   (function() {
    ///     // Define the function 'example.test.myfunction'.
    ///     example.test.myfunction = function() {
    ///       // Call CefV8Handler::Execute() with the function name 'MyFunction'
    ///       // and no arguments.
    ///       native function MyFunction();
    ///       return MyFunction();
    ///     };
    ///     // Define the getter function for parameter 'example.test.myparam'.
    ///     example.test.__defineGetter__('myparam', function() {
    ///       // Call CefV8Handler::Execute() with the function name 'GetMyParam'
    ///       // and no arguments.
    ///       native function GetMyParam();
    ///       return GetMyParam();
    ///     });
    ///     // Define the setter function for parameter 'example.test.myparam'.
    ///     example.test.__defineSetter__('myparam', function(b) {
    ///       // Call CefV8Handler::Execute() with the function name 'SetMyParam'
    ///       // and a single argument.
    ///       native function SetMyParam();
    ///       if(b) SetMyParam(b);
    ///     });
    ///
    ///     // Extension definitions can also contain normal JavaScript variables
    ///     // and functions.
    ///     var myint = 0;
    ///     example.test.increment = function() {
    ///       myint += 1;
    ///       return myint;
    ///     };
    ///   })();
    /// </pre>
    /// Example usage in the page:
    /// <pre>
    ///   // Call the function.
    ///   example.test.myfunction();
    ///   // Set the parameter.
    ///   example.test.myparam = value;
    ///   // Get the parameter.
    ///   value = example.test.myparam;
    ///   // Call another function.
    ///   example.test.increment();
    /// </pre>
    /// CEF name: `CefRegisterExtension`
    public static func registerExtensionWithName(name: String, code: String, handler: CEFV8Handler? = nil) -> Bool {
        let cefNamePtr = CEFStringPtrCreateFromSwiftString(name)
        let cefCodePtr = CEFStringPtrCreateFromSwiftString(code)
        defer {
            CEFStringPtrRelease(cefNamePtr)
            CEFStringPtrRelease(cefCodePtr)
        }
        let cefHandler = handler?.toCEF()
        return cef_register_extension(cefNamePtr, cefCodePtr, cefHandler) != 0
    }

}

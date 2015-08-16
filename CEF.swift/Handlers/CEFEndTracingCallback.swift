//
//  CEFEndTracingCallback.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 16..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Implement this interface to receive notification when tracing has completed.
// The methods of this class will be called on the browser process UI thread.
///
public protocol CEFEndTracingCallback {
    
    ///
    // Called after all processes have sent their trace data. |tracing_file| is
    // the path at which tracing data was written. The client is responsible for
    // deleting |tracing_file|.
    ///
    func onEndTracingComplete(traceFilePath: String)

}

public extension CEFEndTracingCallback {

    func onEndTracingComplete(traceFilePath: String) {
    }
    
}


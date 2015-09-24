//
//  Task.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Implement this interface for asynchronous task execution. If the task is
/// posted successfully and if the associated message loop is still running then
/// the Execute() method will be called on the target thread. If the task fails
/// to post then the task object may be destroyed on the source thread instead of
/// the target thread. For this reason be cautious when performing work in the
/// task object destructor.
public protocol Task {

    /// Method that will be executed on the target thread.
    func execute()
    
}

public extension Task {
    
    func execute() {
    }
    
}


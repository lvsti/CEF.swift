//
//  CEFLocks.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 15..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

import Foundation

protocol Lock {
    func lock()
    func unlock()
}

final class PThreadLock: Lock {
    private var data: pthread_mutex_t
    
    init() {
        data = pthread_mutex_t()
        _ = withUnsafeMutablePointer(to: &data) { ptr in
            pthread_mutex_init(ptr, nil)
        }
    }
    
    func lock() {
        _ = withUnsafeMutablePointer(to: &data, pthread_mutex_lock)
    }
    
    func unlock() {
        _ = withUnsafeMutablePointer(to: &data, pthread_mutex_unlock)
    }
}

final class SpinLock: Lock {
    private var data = OS_SPINLOCK_INIT

    func lock() {
        withUnsafeMutablePointer(to: &data, OSSpinLockLock)
    }
    
    func unlock() {
        withUnsafeMutablePointer(to: &data, OSSpinLockUnlock)
    }
}

@available(macOS 10.12, *)
final class UnfairLock: Lock {
    private var data = os_unfair_lock()
    
    func lock() {
        withUnsafeMutablePointer(to: &data, os_unfair_lock_lock)
    }
    
    func unlock() {
        withUnsafeMutablePointer(to: &data, os_unfair_lock_unlock)
    }
}


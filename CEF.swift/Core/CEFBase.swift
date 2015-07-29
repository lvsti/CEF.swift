//
//  CEFBase.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 10..
//
//

import Foundation

protocol Lock {
    mutating func lock()
    mutating func unlock()
}

extension pthread_mutex_t: Lock {
    mutating func lock() {
        pthread_mutex_lock(&self)
    }
    
    mutating func unlock() {
        pthread_mutex_unlock(&self)
    }
}


public protocol CEFObject: DefaultInitializable {
    var base: cef_base_t { get set }
}

protocol CEFRefCounting: class {
    func addRef()
    func release() -> Bool
    func hasOneRef() -> Bool
}

protocol CEFProxying {
    typealias ObjectPtrType
    init?(ptr: ObjectPtrType)
}


public class CEFProxy<T : CEFObject>: CEFRefCounting, CEFProxying {
    public typealias ObjectType = T
    public typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: ObjectPtrType
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get { return _cefPtr } set {} }
    var cefObject: ObjectType { get { return _cefPtr.memory } set {} }
    
    public required init?(ptr: ObjectPtrType) {
        if ptr == nil {
            _cefPtr = nil
            return nil
        }
        
        _cefPtr = ptr
    }
    
    deinit {
        release()
    }

    func addRef() {
        _cefPtr.memory.base.add_ref(UnsafeMutablePointer<cef_base_t>(_cefPtr))
    }
    
    func release() -> Bool {
        return _cefPtr.memory.base.release(UnsafeMutablePointer<cef_base_t>(_cefPtr)) != 0
    }
    
    func hasOneRef() -> Bool {
        return _cefPtr.memory.base.has_one_ref(UnsafeMutablePointer<cef_base_t>(_cefPtr)) != 0
    }

    static func fromCEF(ptr: ObjectPtrType) -> Self? {
        return self.init(ptr: ptr)
    }
    
    func toCEF() -> UnsafeMutablePointer<ObjectType> {
        addRef()
        return cefObjectPtr
    }
}


public class CEFHandler: CEFRefCounting {
    var _refCountMutex = pthread_mutex_t()
    var _refCountLock: Lock { get { return _refCountMutex } set {} }
    var _refCount: Int = 0

    init() {
        pthread_mutex_init(&_refCountMutex, nil)
    }

    deinit {
        pthread_mutex_destroy(&_refCountMutex)
    }

    func addRef() {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        ++_refCount
    }
    
    func release() -> Bool {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        --_refCount
        return _refCount == 0
    }
    
    func hasOneRef() -> Bool {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        return _refCount == 1
    }
    
}


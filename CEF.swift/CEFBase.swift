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

protocol CEFBase: class, CEFRefCounting {
    typealias ObjectType : CEFObject
    typealias ObjectPtrType = UnsafeMutablePointer<ObjectType>
    
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get set }
    var cefObject: ObjectType { get set }
    
    func toCEF() -> UnsafeMutablePointer<ObjectType>
}

extension CEFBase {
    func toCEF() -> UnsafeMutablePointer<ObjectType> {
        addRef()
        return cefObjectPtr
    }
}

protocol CEFRefCounting: class {
    func addRef()
    func release() -> Bool
    func hasOneRef() -> Bool
}


protocol CEFProxyRefCounting: CEFRefCounting {
    typealias ObjectType
}

extension CEFProxyRefCounting where Self : CEFBase {
    func addRef() {
        self.cefObject.base.add_ref(&self.cefObject.base)
    }
    
    func release() -> Bool {
        return self.cefObject.base.release(&self.cefObject.base) != 0
    }
    
    func hasOneRef() -> Bool {
        return self.cefObject.base.has_one_ref(&self.cefObject.base) != 0
    }
}


public class CEFProxyBase<T : CEFObject>: CEFBase, CEFProxyRefCounting {
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
    
    static func fromCEF(ptr: ObjectPtrType) -> Self? {
        return self.init(ptr: ptr)
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


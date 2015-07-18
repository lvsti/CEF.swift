//
//  CEFBase.swift
//  cef
//
//  Created by Tamas Lustyik on 2015. 07. 10..
//
//

import Foundation

public protocol CEFObject {
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
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
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


protocol CEFHandlerRefCounting: CEFRefCounting {
    func refCountLock()
    func refCountUnlock()
    var _refCount: Int { get set }
}

extension CEFHandlerRefCounting where Self : CEFBase, Self : CEFObjectLookupAdapter {
    func addRef() {
        refCountLock()
        defer { refCountUnlock() }
        
        ++_refCount
        if _refCount == 1 {
            self.registerSelf()
        }
    }
    
    func release() -> Bool {
        refCountLock()
        defer { refCountUnlock() }
        
        --_refCount
        if _refCount == 0 {
            self.deregisterSelf()
            return true
        }
        
        return false
    }
    
    func hasOneRef() -> Bool {
        refCountLock()
        defer { refCountUnlock() }
        
        return _refCount == 1
    }
}


protocol CEFObjectLookupAdapter {
    func registerSelf()
    func deregisterSelf()
}

protocol CEFObjectLookup {
    typealias ObjectType
    typealias SelfType
    
    static var _registry: [UnsafeMutablePointer<ObjectType>: SelfType] { get set }
    static var _registryMutex: pthread_mutex_t { get set }

    static func lookup(ptr: UnsafeMutablePointer<ObjectType>) -> SelfType?
}

extension CEFObjectLookupAdapter where Self : CEFBase, Self : CEFObjectLookup, Self == Self.SelfType {
    func registerSelf() {
        pthread_mutex_lock(&Self._registryMutex)
        defer { pthread_mutex_unlock(&Self._registryMutex) }
        
        Self._registry[cefObjectPtr] = self
    }
    
    func deregisterSelf() {
        pthread_mutex_lock(&Self._registryMutex)
        defer { pthread_mutex_unlock(&Self._registryMutex) }
        
        Self._registry.removeValueForKey(cefObjectPtr)
    }

    static func lookup(ptr: UnsafeMutablePointer<ObjectType>) -> SelfType? {
        pthread_mutex_lock(&_registryMutex)
        defer { pthread_mutex_unlock(&_registryMutex) }
        
        return _registry[ptr]
    }
}


public class CEFHandlerBase<T : CEFObject>: CEFBase, CEFHandlerRefCounting, CEFObjectLookupAdapter {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: ObjectPtrType
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get { return _cefPtr } set {} }
    var cefObject: ObjectType { get { return _cefPtr.memory } set {} }

    var _refMutex: pthread_mutex_t = pthread_mutex_t()
    var _refCount: Int = 0
    
    func refCountLock() {
        pthread_mutex_lock(&_refMutex)
    }
    
    func refCountUnlock() {
        pthread_mutex_unlock(&_refMutex)
    }

    init(ptr: ObjectPtrType) {
        _cefPtr = ptr
    }

    deinit {
        _cefPtr.dealloc(1)
    }
    
    func registerSelf() {
    }
    
    func deregisterSelf() {
    }
}


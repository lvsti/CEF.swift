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
    var _refCountLock: Lock { get set }
    var _refCount: Int { get set }
}

extension CEFHandlerRefCounting where Self : CEFBase, Self : CEFObjectLookupAdapter {
    func addRef() {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        ++_refCount
        if _refCount == 1 {
            self.registerSelf()
        }
    }
    
    func release() -> Bool {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        --_refCount
        if _refCount == 0 {
            self.deregisterSelf()
            return true
        }
        
        return false
    }
    
    func hasOneRef() -> Bool {
        _refCountLock.lock()
        defer { _refCountLock.unlock() }
        
        return _refCount == 1
    }
}


protocol CEFObjectLookupAdapter {
    func registerSelf()
    func deregisterSelf()
}

extension CEFObjectLookupAdapter where Self : CEFBase, Self : CEFObjectLookup, Self == Self.SelfType {
    func registerSelf() {
        Self._registryLock.lock()
        defer { Self._registryLock.unlock() }
        
        Self._registry[cefObjectPtr] = self
    }
    
    func deregisterSelf() {
        Self._registryLock.lock()
        defer { Self._registryLock.unlock() }
        
        Self._registry.removeValueForKey(cefObjectPtr)
    }
}

protocol CEFObjectLookup {
    typealias ObjectType
    typealias SelfType
    
    static var _registry: [UnsafeMutablePointer<ObjectType>: SelfType] { get set }
    static var _registryLock: Lock { get set }
    
    static func lookup(ptr: UnsafeMutablePointer<ObjectType>) -> SelfType?
}

extension CEFObjectLookup {
    static func lookup(ptr: UnsafeMutablePointer<ObjectType>) -> SelfType? {
        Self._registryLock.lock()
        defer { Self._registryLock.unlock() }
        
        return _registry[ptr]
    }
}


public class CEFHandlerBase<T : CEFObject>: CEFBase, CEFHandlerRefCounting, CEFObjectLookupAdapter {
    typealias ObjectType = T
    typealias ObjectPtrType = UnsafeMutablePointer<T>
    
    private let _cefPtr: ObjectPtrType
    var cefObjectPtr: UnsafeMutablePointer<ObjectType> { get { return _cefPtr } set {} }
    var cefObject: ObjectType { get { return _cefPtr.memory } set {} }

    var _refCountLock: Lock = pthread_mutex_t()
    var _refCount: Int = 0
    
    init(ptr: ObjectPtrType) {
        _cefPtr = ptr
        _cefPtr.memory.base.size = sizeof(ObjectType)
    }

    deinit {
        _cefPtr.dealloc(1)
    }
    
    func registerSelf() {}
    func deregisterSelf() {}
}


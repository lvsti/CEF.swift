//
//  CEFMarshaller.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


public protocol DefaultInitializable {
    init()
}

class CEFMarshallerBase {
    static var _registryLock: Lock = CEFMarshallerBase.createLock()
    static var _registry = Dictionary<UnsafeMutablePointer<cef_base_t>, CEFMarshallerBase>()
    
    static func register(ptr: UnsafeMutablePointer<cef_base_t>, forObject obj: CEFMarshallerBase) {
        _registryLock.lock()
        defer { _registryLock.unlock() }
        
        _registry[ptr] = obj
    }
    
    static func deregister(ptr: UnsafeMutablePointer<cef_base_t>) {
        _registryLock.lock()
        defer { _registryLock.unlock() }
        
        _registry.removeValueForKey(ptr)
    }

    static func lookup(ptr: UnsafeMutablePointer<cef_base_t>) -> CEFMarshallerBase? {
        _registryLock.lock()
        defer { _registryLock.unlock() }
        
        return _registry[ptr]
    }
    
    static func createLock() -> Lock {
        var mutex = pthread_mutex_t()
        pthread_mutex_init(&mutex, nil)
        return mutex
    }
    
    static func destroyLock(lock: Lock) {
        guard var mutex = lock as? pthread_mutex_t else {
            return
        }
        pthread_mutex_destroy(&mutex)
    }
}

class CEFMarshaller<TStruct, TClass where TStruct : CEFObject,
                                          TClass : CEFRefCounting>: CEFMarshallerBase, CEFRefCounting {
    typealias MarshallerType = CEFMarshaller<TStruct, TClass>
    
    var cefStruct: TStruct
    var swiftObj: TClass
    
    static func get(ptr: UnsafeMutablePointer<TStruct>) -> TClass? {
        let basePtr = UnsafeMutablePointer<cef_base_t>(ptr)
        let marshaller:MarshallerType? = lookup(basePtr) as? MarshallerType
        return marshaller?.swiftObj
    }
    
    static func take(ptr: UnsafeMutablePointer<TStruct>) -> TClass? {
        let basePtr = UnsafeMutablePointer<cef_base_t>(ptr)
        let marshaller:MarshallerType? = lookup(basePtr) as? MarshallerType
        if let obj = marshaller?.swiftObj {
            if obj.release() {
                deregister(basePtr)
            }
            return obj
        }
        return nil
    }
    
    static func pass(obj: TClass) -> UnsafeMutablePointer<TStruct> {
        let marshaller = CEFMarshaller(obj: obj)
        
        obj.addRef()
        
        // pointer to the struct?
        let unmanaged = Unmanaged<AnyObject>.passUnretained(marshaller)
        let marshallerPtr = UnsafeMutablePointer<Int8>(unmanaged.toOpaque())
        let structPtr = marshallerPtr.advancedBy(16)
        return UnsafeMutablePointer<TStruct>(structPtr)
    }
    
    init(obj: TClass) {
        pthread_mutex_init(&_refCountMutex, nil)
        
        swiftObj = obj

        cefStruct = TStruct()
        cefStruct.base.size = sizeof(TStruct)
        cefStruct.base.add_ref = CEFMarshaller_addRef
        cefStruct.base.release = CEFMarshaller_release
        cefStruct.base.has_one_ref = CEFMarshaller_hasOneRef

        super.init()
        print("\(self) init\n")
    }
    
    deinit {
        print("\(self) deinit\n")
        pthread_mutex_destroy(&_refCountMutex)
    }
    
    // reference counting
    
    func addRef() {
        swiftObj.addRef()
        _refCountMutex.lock()
        defer { _refCountMutex.unlock() }
        ++_refCount
        self._self = self
    }
    
    func release() -> Bool {
        swiftObj.release()
        _refCountMutex.lock()
        defer { _refCountMutex.unlock() }
        --_refCount
        let shouldRelease = _refCount == 0
        if shouldRelease {
            _self = nil
        }
        return shouldRelease
    }
    
    func hasOneRef() -> Bool {
        _refCountMutex.lock()
        defer { _refCountMutex.unlock() }
        return _refCount == 1
    }
    
    var _refCount: Int = 0
    var _refCountMutex = pthread_mutex_t()
    var _self: MarshallerType? = nil
}


func CEFMarshaller_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let marshaller = CEFMarshallerBase.lookup(ptr) as? CEFRefCounting else {
        return
    }
    marshaller.addRef()
}

func CEFMarshaller_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = CEFMarshallerBase.lookup(ptr) as? CEFRefCounting else {
        return 0
    }
    return marshaller.release() ? 1 : 0
}

func CEFMarshaller_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = CEFMarshallerBase.lookup(ptr) as? CEFRefCounting else {
        return 0
    }
    return marshaller.hasOneRef() ? 1 : 0
}

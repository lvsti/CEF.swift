//
//  Marshaller.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 24..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation


public protocol DefaultInitializable {
    init()
}

protocol CallbackMarshalling {
    mutating func marshalCallbacks()
}


class MarshallerBase {
    static let kCEFMarshallerStructOffset = 16
    
    static func getBaseStructPtrFromMarshaller(marshaller: MarshallerBase) -> UnsafeMutablePointer<cef_base_t> {
        let unmanaged = Unmanaged<AnyObject>.passUnretained(marshaller)
        let marshallerPtr = UnsafeMutablePointer<Int8>(unmanaged.toOpaque())
        let structPtr = marshallerPtr.advancedBy(kCEFMarshallerStructOffset)
        return UnsafeMutablePointer<cef_base_t>(structPtr)
    }
    
    static func getMarshallerFromBaseStructPtr(ptr: UnsafeMutablePointer<cef_base_t>) -> MarshallerBase {
        let rawPtr = UnsafeMutablePointer<Int8>(ptr)
        let marshallerPtr = COpaquePointer(rawPtr.advancedBy(-kCEFMarshallerStructOffset))
        let unmanaged = Unmanaged<MarshallerBase>.fromOpaque(marshallerPtr)
        return unmanaged.takeUnretainedValue()
    }
}

class Marshaller<TClass, TStruct where TStruct : CEFObject, TStruct : CallbackMarshalling>: MarshallerBase, RefCounting {
    typealias InstanceType = Marshaller<TClass, TStruct>
    
    var cefStruct: TStruct
    var swiftObj: TClass
    
    static func get(ptr: UnsafeMutablePointer<TStruct>) -> TClass? {
        guard let marshaller = getMarshallerFromBaseStructPtr(UnsafeMutablePointer<cef_base_t>(ptr)) as? InstanceType else {
            return nil
        }
        return marshaller.swiftObj
    }
    
    static func take(ptr: UnsafeMutablePointer<TStruct>) -> TClass? {
        guard let marshaller = getMarshallerFromBaseStructPtr(UnsafeMutablePointer<cef_base_t>(ptr)) as? InstanceType else {
            return nil
        }
        marshaller.release()
        return marshaller.swiftObj
    }
    
    static func pass(obj: TClass) -> UnsafeMutablePointer<TStruct> {
        let marshaller = Marshaller(obj: obj)
        marshaller.addRef()
        
        return UnsafeMutablePointer<TStruct>(getBaseStructPtrFromMarshaller(marshaller))
    }
    
    required init(obj: TClass) {
        pthread_mutex_init(&_refCountMutex, nil)
        
        swiftObj = obj
        cefStruct = TStruct()

        cefStruct.base.size = strideof(TStruct.self)
        cefStruct.base.add_ref = Marshaller_addRef
        cefStruct.base.release = Marshaller_release
        cefStruct.base.has_one_ref = Marshaller_hasOneRef

        cefStruct.marshalCallbacks()
        
        super.init()

#if DEBUG
        let marshallerPtr = UnsafePointer<Int8>(unsafeAddressOf(self))
        let basePtr = Marshaller.getBasePtr(self)
        let ptr = UnsafePointer<Int8>(basePtr)
        assert(ptr.distanceTo(marshallerPtr) == kCEFMarshallerStructOffset)
        var offset = strideof(size_t)
        while offset < cefStruct.base.size {
            let fptr = UnsafePointer<UnsafePointer<Void>>(ptr.advancedBy(offset))
            assert(fptr.memory != nil, "uninitialized field at offset \(offset) in \(TStruct.self)")
            offset += strideof(UnsafePointer<Void>)
        }
#endif
    }
    
    deinit {
        pthread_mutex_destroy(&_refCountMutex)
    }
    
    // reference counting
    
    func addRef() {
        _refCountMutex.lock()
        defer { _refCountMutex.unlock() }
        ++_refCount
        _self = self
    }
    
    func release() -> Bool {
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
    var _self: InstanceType? = nil
}

func Marshaller_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let marshaller = MarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? RefCounting else {
        return
    }
    marshaller.addRef()
}

func Marshaller_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = MarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? RefCounting else {
        return 0
    }
    return marshaller.release() ? 1 : 0
}

func Marshaller_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = MarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? RefCounting else {
        return 0
    }
    return marshaller.hasOneRef() ? 1 : 0
}

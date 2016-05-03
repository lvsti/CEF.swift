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

protocol CEFCallbackMarshalling {
    mutating func marshalCallbacks()
}


class CEFMarshallerBase {
    static let kCEFMarshallerStructOffset = 16
    
    static func getBaseStructPtrFromMarshaller(marshaller: CEFMarshallerBase) -> UnsafeMutablePointer<cef_base_t> {
        let unmanaged = Unmanaged<AnyObject>.passUnretained(marshaller)
        let marshallerPtr = UnsafeMutablePointer<Int8>(unmanaged.toOpaque())
        let structPtr = marshallerPtr.advancedBy(kCEFMarshallerStructOffset)
        return UnsafeMutablePointer<cef_base_t>(structPtr)
    }
    
    static func getMarshallerFromBaseStructPtr(ptr: UnsafeMutablePointer<cef_base_t>) -> CEFMarshallerBase {
        let rawPtr = UnsafeMutablePointer<Int8>(ptr)
        let marshallerPtr = COpaquePointer(rawPtr.advancedBy(-kCEFMarshallerStructOffset))
        let unmanaged = Unmanaged<CEFMarshallerBase>.fromOpaque(marshallerPtr)
        return unmanaged.takeUnretainedValue()
    }
}

class CEFMarshaller<TClass, TStruct where TStruct : CEFObject, TStruct : CEFCallbackMarshalling>: CEFMarshallerBase, CEFRefCounting {
    typealias InstanceType = CEFMarshaller<TClass, TStruct>
    
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
        let marshaller = CEFMarshaller(obj: obj)
        marshaller.addRef()
        
        return UnsafeMutablePointer<TStruct>(getBaseStructPtrFromMarshaller(marshaller))
    }
    
    required init(obj: TClass) {
        pthread_mutex_init(&_refCountMutex, nil)
        
        swiftObj = obj
        cefStruct = TStruct()

        cefStruct.base.size = strideof(TStruct.self)
        cefStruct.base.add_ref = CEFMarshaller_addRef
        cefStruct.base.release = CEFMarshaller_release
        cefStruct.base.has_one_ref = CEFMarshaller_hasOneRef

        cefStruct.marshalCallbacks()
        
        super.init()

#if DEBUG
        let marshallerPtr = UnsafePointer<Int8>(unsafeAddressOf(self))
        let basePtr = CEFMarshaller.getBasePtr(self)
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
        _refCount += 1
        _self = self
    }
    
    func release() -> Bool {
        _refCountMutex.lock()
        defer { _refCountMutex.unlock() }
        _refCount -= 1
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

func CEFMarshaller_addRef(ptr: UnsafeMutablePointer<cef_base_t>) {
    guard let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting else {
        return
    }
    marshaller.addRef()
}

func CEFMarshaller_release(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting else {
        return 0
    }
    return marshaller.release() ? 1 : 0
}

func CEFMarshaller_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>) -> Int32 {
    guard let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting else {
        return 0
    }
    return marshaller.hasOneRef() ? 1 : 0
}

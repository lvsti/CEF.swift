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
    
    static func getBaseStructPtrFromMarshaller(_ marshaller: CEFMarshallerBase) -> UnsafeMutablePointer<cef_base_t> {
        let unmanaged = Unmanaged<AnyObject>.passUnretained(marshaller)
        return unmanaged.toOpaque().advanced(by: kCEFMarshallerStructOffset).assumingMemoryBound(to: cef_base_t.self)
    }
    
    static func getMarshallerFromBaseStructPtr(_ ptr: UnsafeMutablePointer<cef_base_t>) -> CEFMarshallerBase {
        let marshallerPtr = UnsafeMutableRawPointer(UnsafeMutableRawPointer(ptr)
            .assumingMemoryBound(to: Int8.self)
            .advanced(by: -kCEFMarshallerStructOffset))
        let unmanaged = Unmanaged<CEFMarshallerBase>.fromOpaque(marshallerPtr)
        return unmanaged.takeUnretainedValue()
    }
}

class CEFMarshaller<TClass, TStruct>: CEFMarshallerBase, CEFRefCounting
    where TStruct : CEFObject, TStruct : CEFCallbackMarshalling {
    
    typealias InstanceType = CEFMarshaller<TClass, TStruct>
    
    var cefStruct: TStruct
    var swiftObj: TClass
    
    static func get(_ ptr: UnsafeMutablePointer<TStruct>?) -> TClass? {
        guard let ptr = ptr else { return nil }
        return ptr.withMemoryRebound(to: cef_base_t.self, capacity: 1) { baseStructPtr in
            guard let marshaller = getMarshallerFromBaseStructPtr(baseStructPtr) as? InstanceType else {
                return nil
            }
            return marshaller.swiftObj
        }
    }
    
    static func take(_ ptr: UnsafeMutablePointer<TStruct>?) -> TClass? {
        guard let ptr = ptr else { return nil }
        return ptr.withMemoryRebound(to: cef_base_t.self, capacity: 1) { baseStructPtr in
            guard let marshaller = getMarshallerFromBaseStructPtr(baseStructPtr) as? InstanceType else {
                return nil
            }
            marshaller.release()
            return marshaller.swiftObj
        }
    }
    
    static func pass(_ obj: TClass) -> UnsafeMutablePointer<TStruct> {
        let marshaller = CEFMarshaller(obj: obj)
        marshaller.addRef()
        
        let baseStructPtr = getBaseStructPtrFromMarshaller(marshaller)
        return UnsafeMutableRawPointer(baseStructPtr).assumingMemoryBound(to: TStruct.self)
    }
    
    required init(obj: TClass) {
        pthread_mutex_init(&_refCountMutex, nil)
        
        swiftObj = obj
        cefStruct = TStruct()

        cefStruct.base.size = MemoryLayout<TStruct>.stride
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
        var offset = MemoryLayout<size_t>.stride
        while offset < cefStruct.base.size {
            let fptr = UnsafePointer<UnsafeRawPointer>(ptr.advanced(by: offset))
            assert(fptr.pointee != nil, "uninitialized field at offset \(offset) in \(TStruct.self)")
            offset += MemoryLayout<UnsafeRawPointer>.stride
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
    
    @discardableResult
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

func CEFMarshaller_addRef(ptr: UnsafeMutablePointer<cef_base_t>?) {
    guard
        let ptr = ptr,
        let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting
    else {
        return
    }
    marshaller.addRef()
}

func CEFMarshaller_release(ptr: UnsafeMutablePointer<cef_base_t>?) -> Int32 {
    guard
        let ptr = ptr,
        let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting
    else {
        return 0
    }
    return marshaller.release() ? 1 : 0
}

func CEFMarshaller_hasOneRef(ptr: UnsafeMutablePointer<cef_base_t>?) -> Int32 {
    guard
        let ptr = ptr,
        let marshaller = CEFMarshallerBase.getMarshallerFromBaseStructPtr(ptr) as? CEFRefCounting
    else {
        return 0
    }
    return marshaller.hasOneRef() ? 1 : 0
}

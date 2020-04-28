//
//  CEFMediaSink.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMediaSink {
    /// Returns the ID for this sink.
    /// CEF name: `GetId`
    public var id: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns true if this sink is valid.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns the name of this sink.
    /// CEF name: `GetName`
    public var name: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns the description of this sink.
    /// CEF name: `GetDescription`
    public var description: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns true if this sink accepts content via Cast.
    /// CEF name: `IsCastSink`
    public var isCastSink: Bool {
        return cefObject.is_cast_sink(cefObjectPtr) != 0
    }

    /// Returns true if this sink accepts content via DIAL.
    /// CEF name: `IsDialSink`
    public var isDialSink: Bool {
        return cefObject.is_dial_sink(cefObjectPtr) != 0
    }

    /// Returns true if this sink is compatible with |source|.
    /// CEF name: `IsCompatibleWith`
    public func isCompatible(with source: CEFMediaSource) -> Bool {
        return cefObject.is_compatible_with(cefObjectPtr, source.toCEF()) != 0
    }
}

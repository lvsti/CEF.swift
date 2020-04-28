//
//  CEFMediaSource.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2020. 04. 28..
//  Copyright © 2020. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFMediaSource {
    /// Returns the ID (media source URN or URL) for this source.
    /// CEF name: `GetId`
    public var id: String? {
        let cefStrPtr = cefObject.get_id(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringPtrToSwiftString(cefStrPtr)
    }

    /// Returns true if this source is valid.
    /// CEF name: `IsValid`
    public var isValid: Bool {
        return cefObject.is_valid(cefObjectPtr) != 0
    }

    /// Returns true if this source outputs its content via Cast.
    /// CEF name: `IsCastSource`
    public var isCastSource: Bool {
        return cefObject.is_cast_source(cefObjectPtr) != 0
    }

    /// Returns true if this source outputs its content via DIAL.
    /// CEF name: `IsDialSource`
    public var isDialSource: Bool {
        return cefObject.is_dial_source(cefObjectPtr) != 0
    }
}

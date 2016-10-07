//
//  CEFResourceBundleHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class used to implement a custom resource bundle interface. See CefSettings
/// for additional options related to resource bundle loading. The methods of
/// this class may be called on multiple threads.
/// CEF name: `CefResourceBundleHandler`
public protocol CEFResourceBundleHandler {
    
    /// Called to retrieve a localized translation for the specified |string_id|.
    /// To provide the translation set |string| to the translation string and
    /// return true. To use the default translation return false. Include
    /// cef_pack_strings.h for a listing of valid string ID values.
    /// CEF name: `GetLocalizedString`
    func localizedStringForID(stringID: Int) -> String?

    /// Called to retrieve data for the specified scale independent |resource_id|.
    /// To provide the resource data set |data| and |data_size| to the data pointer
    /// and size respectively and return true. To use the default resource data
    /// return false. The resource data will not be copied and must remain resident
    /// in memory. Include cef_pack_resources.h for a listing of valid resource ID
    /// values.
    /// CEF name: `GetDataResource`
    func dataResourceForID(resourceID: Int) -> (dataBufferPtr: UnsafeMutableRawPointer, dataSize: size_t)?
    
    /// Called to retrieve data for the specified |resource_id| nearest the scale
    /// factor |scale_factor|. To provide the resource data set |data| and
    /// |data_size| to the data pointer and size respectively and return true. To
    /// use the default resource data return false. The resource data will not be
    /// copied and must remain resident in memory. Include cef_pack_resources.h for
    /// a listing of valid resource ID values.
    /// CEF name: `GetDataResourceForScale`
    func dataResourceForID(resourceID: Int, scale: CEFScaleFactor) -> (dataBufferPtr: UnsafeMutableRawPointer, dataSize: size_t)?

}


public extension CEFResourceBundleHandler {
    
    public func localizedStringForID(stringID: Int) -> String? {
        return nil
    }
    
    public func dataResourceForID(resourceID: Int) -> (dataBufferPtr: UnsafeMutableRawPointer, dataSize: size_t)? {
        return nil
    }

    func dataResourceForID(resourceID: Int, scale: CEFScaleFactor) -> (dataBufferPtr: UnsafeMutableRawPointer, dataSize: size_t)? {
        return nil
    }

}


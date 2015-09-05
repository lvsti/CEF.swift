//
//  CEFResourceBundleHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 15..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Class used to implement a custom resource bundle interface. The methods of
/// this class may be called on multiple threads.
public protocol CEFResourceBundleHandler {
    
    /// Called to retrieve a localized translation for the string specified by
    /// |message_id|. To provide the translation set |string| to the translation
    /// string and return true. To use the default translation return false.
    /// Supported message IDs are listed in cef_pack_strings.h.
    func localizedStringForID(stringID: Int) -> String?

    /// Called to retrieve data for the resource specified by |resource_id|. To
    /// provide the resource data set |data| and |data_size| to the data pointer
    /// and size respectively and return true. To use the default resource data
    /// return false. The resource data will not be copied and must remain resident
    /// in memory. Supported resource IDs are listed in cef_pack_resources.h.
    func dataResourceForID(resourceID: Int) -> (dataBufferPtr: UnsafeMutablePointer<Void>, dataSize: size_t)?
    
}


public extension CEFResourceBundleHandler {
    
    public func localizedStringForID(stringID: Int) -> String? {
        return nil
    }
    
    public func dataResourceForID(resourceID: Int) -> (dataBufferPtr: UnsafeMutablePointer<Void>, dataSize: size_t)? {
        return nil
    }
    
}


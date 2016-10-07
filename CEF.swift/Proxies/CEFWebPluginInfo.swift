//
//  CEFWebPluginInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFWebPluginInfo {

    /// Returns the plugin name (i.e. Flash).
    /// CEF name: `GetName`
    public var name: String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the plugin file path (DLL/bundle/library).
    /// CEF name: `GetPath`
    public var path: String {
        let cefStrPtr = cefObject.get_path(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns the version of the plugin (may be OS-specific).
    /// CEF name: `GetVersion`
    public var version: String {
        let cefStrPtr = cefObject.get_version(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }
    
    /// Returns a description of the plugin from the version information.
    /// CEF name: `GetDescription`
    public var description: String {
        let cefStrPtr = cefObject.get_description(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr!.pointee)
    }

}


//
//  CEFWebPluginInfo.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 07..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_web_plugin_info_t: CEFObject {
}

///
// Information about a specific web plugin.
///
public class CEFWebPluginInfo: CEFProxy<cef_web_plugin_info_t> {

    ///
    // Returns the plugin name (i.e. Flash).
    ///
    public func getName() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the plugin file path (DLL/bundle/library).
    ///
    public func getPath() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns the version of the plugin (may be OS-specific).
    ///
    public func getVersion() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }
    
    ///
    // Returns a description of the plugin from the version information.
    ///
    public func getDescription() -> String {
        let cefStrPtr = cefObject.get_name(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFWebPluginInfo? {
        return CEFWebPluginInfo(ptr: ptr)
    }
}


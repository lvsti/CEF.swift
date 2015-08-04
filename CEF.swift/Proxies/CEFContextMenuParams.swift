//
//  CEFContextMenuParams.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

extension cef_context_menu_params_t: CEFObject {
}

public class CEFContextMenuParams: CEFProxy<cef_context_menu_params_t> {
    
    public typealias TypeFlags = CEFContextMenuTypeFlags
    public typealias MediaType = CEFContextMenuMediaType
    public typealias MediaStateFlags = CEFContextMenuMediaStateFlags
    public typealias EditStateFlags = CEFContextMenuEditStateFlags
    
    public func getXCoord() -> Int32 {
        return cefObject.get_xcoord(cefObjectPtr)
    }
    
    public func getYCoord() -> Int32 {
        return cefObject.get_ycoord(cefObjectPtr)
    }

    public func getTypeFlags() -> TypeFlags {
        let cefFlags = cefObject.get_type_flags(cefObjectPtr)
        return TypeFlags.fromCEF(cefFlags)
    }
    
    public func getLinkURL() -> NSURL? {
        let cefURLPtr = cefObject.get_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.memory)
        return NSURL(string: str)
    }

    public func getUnfilteredLinkURL() -> NSURL? {
        let cefURLPtr = cefObject.get_unfiltered_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.memory)
        return NSURL(string: str)!
    }
    
    public func getSourceURL() -> NSURL? {
        let cefURLPtr = cefObject.get_source_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.memory)
        return NSURL(string: str)!
    }
    
    public func hasImageContents() -> Bool {
        return cefObject.has_image_contents(cefObjectPtr) != 0
    }
    
    public func getPageURL() -> NSURL {
        let cefURLPtr = cefObject.get_page_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let str = CEFStringToSwiftString(cefURLPtr.memory)
        return NSURL(string: str)!
    }
    
    public func getFrameURL() -> NSURL {
        let cefURLPtr = cefObject.get_frame_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let str = CEFStringToSwiftString(cefURLPtr.memory)
        return NSURL(string: str)!
    }

    public func getFrameCharset() -> String {
        let cefStrPtr = cefObject.get_frame_charset(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.memory)
    }

    public func getMediaType() -> MediaType {
        let cefType = cefObject.get_media_type(cefObjectPtr)
        return MediaType.fromCEF(cefType)
    }
    
    public func getMediaStateFlags() -> MediaStateFlags {
        let cefFlags = cefObject.get_media_state_flags(cefObjectPtr)
        return MediaStateFlags.fromCEF(cefFlags)
    }
    
    public func getSelectionText() -> String? {
        let cefStrPtr = cefObject.get_selection_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    public func getMisspelledWord() -> String? {
        let cefStrPtr = cefObject.get_misspelled_word(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.memory) : nil
    }
    
    public func getDictionarySuggestions() -> [String]? {
        let cefList = cef_string_list_alloc()
        defer { CEFStringListRelease(cefList) }
        let result = cefObject.get_dictionary_suggestions(cefObjectPtr, cefList)
        return result != 0 ? CEFStringListToSwiftArray(cefList) : nil
    }
    
    public func isEditable() -> Bool {
        return cefObject.is_editable(cefObjectPtr) != 0
    }
    
    public func isSpellCheckEnabled() -> Bool {
        return cefObject.is_spell_check_enabled(cefObjectPtr) != 0
    }

    public func getEditStateFlags() -> EditStateFlags {
        let cefFlags = cefObject.get_edit_state_flags(cefObjectPtr)
        return EditStateFlags.fromCEF(cefFlags)
    }

    // private
    
    override init?(ptr: ObjectPtrType) {
        super.init(ptr: ptr)
    }
    
    static func fromCEF(ptr: ObjectPtrType) -> CEFContextMenuParams? {
        return CEFContextMenuParams(ptr: ptr)
    }
}


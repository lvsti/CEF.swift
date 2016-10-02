//
//  CEFContextMenuParams.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 03..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

public extension CEFContextMenuParams {
    
    /// Returns the X coordinate of the mouse where the context menu was invoked.
    /// Coords are relative to the associated RenderView's origin.
    public var xCoord: Int32 {
        return cefObject.get_xcoord(cefObjectPtr)
    }
    
    /// Returns the Y coordinate of the mouse where the context menu was invoked.
    /// Coords are relative to the associated RenderView's origin.
    public var yCoord: Int32 {
        return cefObject.get_ycoord(cefObjectPtr)
    }

    /// Returns flags representing the type of node that the context menu was
    /// invoked on.
    public var typeFlags: CEFContextMenuTypeFlags {
        let cefFlags = cefObject.get_type_flags(cefObjectPtr)
        return CEFContextMenuTypeFlags.fromCEF(cefFlags)
    }
    
    /// Returns the URL of the link, if any, that encloses the node that the
    /// context menu was invoked on.
    public var linkURL: NSURL? {
        let cefURLPtr = cefObject.get_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.pointee)
        return NSURL(string: str)
    }

    /// Returns the link URL, if any, to be used ONLY for "copy link address". We
    /// don't validate this field in the frontend process.
    public var unfilteredLinkURL: NSURL? {
        let cefURLPtr = cefObject.get_unfiltered_link_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.pointee)
        return NSURL(string: str)!
    }
    
    /// Returns the source URL, if any, for the element that the context menu was
    /// invoked on. Example of elements with source URLs are img, audio, and video.
    public var sourceURL: NSURL? {
        let cefURLPtr = cefObject.get_source_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        if cefURLPtr == nil {
            return nil
        }
        let str = CEFStringToSwiftString(cefURLPtr.pointee)
        return NSURL(string: str)!
    }
    
    /// Returns true if the context menu was invoked on an image which has
    /// non-empty contents.
    public var hasImageContents: Bool {
        return cefObject.has_image_contents(cefObjectPtr) != 0
    }
    
    /// Returns the URL of the top level page that the context menu was invoked on.
    public var pageURL: NSURL {
        let cefURLPtr = cefObject.get_page_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let str = CEFStringToSwiftString(cefURLPtr.pointee)
        return NSURL(string: str)!
    }
    
    /// Returns the URL of the subframe that the context menu was invoked on.
    public var frameURL: NSURL? {
        let cefURLPtr = cefObject.get_frame_url(cefObjectPtr)
        defer { CEFStringPtrRelease(cefURLPtr) }
        let str = CEFStringToSwiftString(cefURLPtr.pointee)
        return NSURL(string: str)
    }

    /// Returns the character encoding of the subframe that the context menu was
    /// invoked on.
    public var frameCharset: String {
        let cefStrPtr = cefObject.get_frame_charset(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return CEFStringToSwiftString(cefStrPtr.pointee)
    }

    /// Returns the type of context node that the context menu was invoked on.
    public var mediaType: CEFContextMenuMediaType {
        let cefType = cefObject.get_media_type(cefObjectPtr)
        return CEFContextMenuMediaType.fromCEF(cefType)
    }
    
    /// Returns flags representing the actions supported by the media element, if
    /// any, that the context menu was invoked on.
    public var mediaStateFlags: CEFContextMenuMediaStateFlags {
        let cefFlags = cefObject.get_media_state_flags(cefObjectPtr)
        return CEFContextMenuMediaStateFlags.fromCEF(cefFlags)
    }
    
    /// Returns the text of the selection, if any, that the context menu was
    /// invoked on.
    public var selectionText: String? {
        let cefStrPtr = cefObject.get_selection_text(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.pointee) : nil
    }
    
    /// Returns the text of the misspelled word, if any, that the context menu was
    /// invoked on.
    public var misspelledWord: String? {
        let cefStrPtr = cefObject.get_misspelled_word(cefObjectPtr)
        defer { CEFStringPtrRelease(cefStrPtr) }
        return cefStrPtr != nil ? CEFStringToSwiftString(cefStrPtr.pointee) : nil
    }
    
    /// Returns true if suggestions exist, false otherwise. Fills in |suggestions|
    /// from the spell check service for the misspelled word if there is one.
    public var dictionarySuggestions: [String]? {
        let cefList = cef_string_list_alloc()
        defer { CEFStringListRelease(cefList) }
        let result = cefObject.get_dictionary_suggestions(cefObjectPtr, cefList)
        return result != 0 ? CEFStringListToSwiftArray(cefList) : nil
    }
    
    /// Returns true if the context menu was invoked on an editable node.
    public var isEditable: Bool {
        return cefObject.is_editable(cefObjectPtr) != 0
    }
    
    /// Returns true if the context menu was invoked on an editable node where
    /// spell-check is enabled.
    public var isSpellCheckEnabled: Bool {
        return cefObject.is_spell_check_enabled(cefObjectPtr) != 0
    }

    /// Returns flags representing the actions supported by the editable node, if
    /// any, that the context menu was invoked on.
    public var editStateFlags: CEFContextMenuEditStateFlags {
        let cefFlags = cefObject.get_edit_state_flags(cefObjectPtr)
        return CEFContextMenuEditStateFlags.fromCEF(cefFlags)
    }

    /// Returns true if the context menu contains items specified by the renderer
    /// process (for example, plugin placeholder or pepper plugin menu items).
    public var isCustomMenu: Bool {
        return cefObject.is_custom_menu(cefObjectPtr) != 0
    }
    
    /// Returns true if the context menu was invoked from a pepper plugin.
    public var isPepperMenu: Bool {
        return cefObject.is_pepper_menu(cefObjectPtr) != 0
    }

}


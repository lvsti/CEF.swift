//
//  CEFMenuID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported menu IDs. Non-English translations can be provided for the
/// IDS_MENU_* strings in CefResourceBundleHandler::GetLocalizedString().
/// CEF name: `cef_menu_id_t`.
public struct CEFMenuID: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }


    /// Navigation.
    /// CEF name: `MENU_ID_BACK`.
    public static let back = CEFMenuID(rawValue: 100)
    /// CEF name: `MENU_ID_FORWARD`.
    public static let forward = CEFMenuID(rawValue: 101)
    /// CEF name: `MENU_ID_RELOAD`.
    public static let reload = CEFMenuID(rawValue: 102)
    /// CEF name: `MENU_ID_RELOAD_NOCACHE`.
    public static let reloadNoCache = CEFMenuID(rawValue: 103)
    /// CEF name: `MENU_ID_STOPLOAD`.
    public static let stopLoad = CEFMenuID(rawValue: 104)

    /// Editing.
    /// CEF name: `MENU_ID_UNDO`.
    public static let undo = CEFMenuID(rawValue: 110)
    /// CEF name: `MENU_ID_REDO`.
    public static let redo = CEFMenuID(rawValue: 111)
    /// CEF name: `MENU_ID_CUT`.
    public static let cut = CEFMenuID(rawValue: 112)
    /// CEF name: `MENU_ID_COPY`.
    public static let copy = CEFMenuID(rawValue: 113)
    /// CEF name: `MENU_ID_PASTE`.
    public static let paste = CEFMenuID(rawValue: 114)
    /// CEF name: `MENU_ID_DELETE`.
    public static let delete = CEFMenuID(rawValue: 115)
    /// CEF name: `MENU_ID_SELECT_ALL`.
    public static let selectAll = CEFMenuID(rawValue: 116)

    /// Miscellaneous.
    /// CEF name: `MENU_ID_FIND`.
    public static let find = CEFMenuID(rawValue: 130)
    /// CEF name: `MENU_ID_PRINT`.
    public static let print = CEFMenuID(rawValue: 131)
    /// CEF name: `MENU_ID_VIEW_SOURCE`.
    public static let viewSource = CEFMenuID(rawValue: 132)

    /// Spell checking word correction suggestions.
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_0`.
    public static let spellcheckSuggestion0 = CEFMenuID(rawValue: 200)
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_1`.
    public static let spellcheckSuggestion1 = CEFMenuID(rawValue: 201)
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_2`.
    public static let spellcheckSuggestion2 = CEFMenuID(rawValue: 202)
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_3`.
    public static let spellcheckSuggestion3 = CEFMenuID(rawValue: 203)
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_4`.
    public static let spellcheckSuggestion4 = CEFMenuID(rawValue: 204)
    /// CEF name: `MENU_ID_SPELLCHECK_SUGGESTION_LAST`.
    public static let spellcheckSuggestionLast = CEFMenuID(rawValue: 204)
    /// CEF name: `MENU_ID_NO_SPELLING_SUGGESTIONS`.
    public static let noSpellingSuggestions = CEFMenuID(rawValue: 205)
    /// CEF name: `MENU_ID_ADD_TO_DICTIONARY`.
    public static let addToDictionary = CEFMenuID(rawValue: 206)

    /// Custom menu items originating from the renderer process. For example,
    /// plugin placeholder menu items.
    /// CEF name: `MENU_ID_CUSTOM_FIRST`.
    public static let customFirst = CEFMenuID(rawValue: 220)
    /// CEF name: `MENU_ID_CUSTOM_LAST`.
    public static let customLast = CEFMenuID(rawValue: 250)

    /// All user-defined menu IDs should come between MENU_ID_USER_FIRST and
    /// MENU_ID_USER_LAST to avoid overlapping the Chromium and CEF ID ranges
    /// defined in the tools/gritsettings/resource_ids file.
    /// CEF name: `MENU_ID_USER_FIRST`.
    public static let userFirst = CEFMenuID(rawValue: 26500)
    /// CEF name: `MENU_ID_USER_LAST`.
    public static let userLast = CEFMenuID(rawValue: 28500)
}

extension CEFMenuID {
    static func fromCEF(_ value: Int32) -> CEFMenuID {
        return CEFMenuID(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}


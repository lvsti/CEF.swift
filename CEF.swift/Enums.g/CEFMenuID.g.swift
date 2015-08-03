//
//  CEFMenuID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// Supported menu IDs. Non-English translations can be provided for the
// IDS_MENU_* strings in CefResourceBundleHandler::GetLocalizedString().
///
public enum CEFMenuID: Int32 {
    case Back = 100
    case Forward = 101
    case Reload = 102
    case ReloadNoCache = 103

    ///
    // Editing.
    ///
    case StopLoad = 104
    case Undo = 110
    case Redo = 111
    case Cut = 112
    case Copy = 113
    case Paste = 114
    case Delete = 115

    ///
    // Miscellaneous.
    ///
    case SelectAll = 116
    case Find = 130
    case Print = 131

    ///
    // Spell checking word correction suggestions.
    ///
    case ViewSource = 132
    case SpellcheckSuggestion0 = 200
    case SpellcheckSuggestion1 = 201
    case SpellcheckSuggestion2 = 202
    case SpellcheckSuggestion3 = 203
    case SpellcheckSuggestion4 = 204
    public static var SpellcheckSuggestionLast: CEFMenuID { get { return CEFMenuID(rawValue: 204)! } }

    case NoSpellingSuggestions = 205

    ///
    // All user-defined menu IDs should come between MENU_ID_USER_FIRST and
    // MENU_ID_USER_LAST to avoid overlapping the Chromium and CEF ID ranges
    // defined in the tools/gritsettings/resource_ids file.
    ///
    case AddToDictionary = 206
    case UserFirst = 26500
    case UserLast = 28500
}

extension CEFMenuID {
    static func fromCEF(value: cef_menu_id_t) -> CEFMenuID {
        return CEFMenuID(rawValue: Int32(value.rawValue))!
    }

    func toCEF() -> cef_menu_id_t {
        return cef_menu_id_t(rawValue: UInt32(rawValue))
    }
}


//
//  CEFMenuID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported menu IDs. Non-English translations can be provided for the
/// IDS_MENU_* strings in CefResourceBundleHandler::GetLocalizedString().
public struct CEFMenuID: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let Back = CEFMenuID(rawValue: 100)
    public static let Forward = CEFMenuID(rawValue: 101)
    public static let Reload = CEFMenuID(rawValue: 102)
    public static let ReloadNoCache = CEFMenuID(rawValue: 103)

    ///
    // Editing.
    ///
    public static let StopLoad = CEFMenuID(rawValue: 104)
    public static let Undo = CEFMenuID(rawValue: 110)
    public static let Redo = CEFMenuID(rawValue: 111)
    public static let Cut = CEFMenuID(rawValue: 112)
    public static let Copy = CEFMenuID(rawValue: 113)
    public static let Paste = CEFMenuID(rawValue: 114)
    public static let Delete = CEFMenuID(rawValue: 115)

    ///
    // Miscellaneous.
    ///
    public static let SelectAll = CEFMenuID(rawValue: 116)
    public static let Find = CEFMenuID(rawValue: 130)
    public static let Print = CEFMenuID(rawValue: 131)

    ///
    // Spell checking word correction suggestions.
    ///
    public static let ViewSource = CEFMenuID(rawValue: 132)
    public static let SpellcheckSuggestion0 = CEFMenuID(rawValue: 200)
    public static let SpellcheckSuggestion1 = CEFMenuID(rawValue: 201)
    public static let SpellcheckSuggestion2 = CEFMenuID(rawValue: 202)
    public static let SpellcheckSuggestion3 = CEFMenuID(rawValue: 203)
    public static let SpellcheckSuggestion4 = CEFMenuID(rawValue: 204)
    public static let SpellcheckSuggestionLast = CEFMenuID(rawValue: 204)
    public static let NoSpellingSuggestions = CEFMenuID(rawValue: 205)

    ///
    // All user-defined menu IDs should come between MENU_ID_USER_FIRST and
    // MENU_ID_USER_LAST to avoid overlapping the Chromium and CEF ID ranges
    // defined in the tools/gritsettings/resource_ids file.
    ///
    public static let AddToDictionary = CEFMenuID(rawValue: 206)
    public static let UserFirst = CEFMenuID(rawValue: 26500)
    public static let UserLast = CEFMenuID(rawValue: 28500)
}

extension CEFMenuID {
    static func fromCEF(value: Int32) -> CEFMenuID {
        return CEFMenuID(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}


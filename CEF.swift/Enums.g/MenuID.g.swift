//
//  MenuID.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// Supported menu IDs. Non-English translations can be provided for the
/// IDS_MENU_* strings in CefResourceBundleHandler::GetLocalizedString().
public struct MenuID: RawRepresentable {
    public let rawValue: Int32
    public init(rawValue: Int32) {
        self.rawValue = rawValue
    }

    public static let Back = MenuID(rawValue: 100)
    public static let Forward = MenuID(rawValue: 101)
    public static let Reload = MenuID(rawValue: 102)
    public static let ReloadNoCache = MenuID(rawValue: 103)

    /// Editing.
    public static let StopLoad = MenuID(rawValue: 104)
    public static let Undo = MenuID(rawValue: 110)
    public static let Redo = MenuID(rawValue: 111)
    public static let Cut = MenuID(rawValue: 112)
    public static let Copy = MenuID(rawValue: 113)
    public static let Paste = MenuID(rawValue: 114)
    public static let Delete = MenuID(rawValue: 115)

    /// Miscellaneous.
    public static let SelectAll = MenuID(rawValue: 116)
    public static let Find = MenuID(rawValue: 130)
    public static let Print = MenuID(rawValue: 131)

    /// Spell checking word correction suggestions.
    public static let ViewSource = MenuID(rawValue: 132)
    public static let SpellcheckSuggestion0 = MenuID(rawValue: 200)
    public static let SpellcheckSuggestion1 = MenuID(rawValue: 201)
    public static let SpellcheckSuggestion2 = MenuID(rawValue: 202)
    public static let SpellcheckSuggestion3 = MenuID(rawValue: 203)
    public static let SpellcheckSuggestion4 = MenuID(rawValue: 204)
    public static let SpellcheckSuggestionLast = MenuID(rawValue: 204)
    public static let NoSpellingSuggestions = MenuID(rawValue: 205)

    /// All user-defined menu IDs should come between MENU_ID_USER_FIRST and
    /// MENU_ID_USER_LAST to avoid overlapping the Chromium and CEF ID ranges
    /// defined in the tools/gritsettings/resource_ids file.
    public static let AddToDictionary = MenuID(rawValue: 206)
    public static let UserFirst = MenuID(rawValue: 26500)
    public static let UserLast = MenuID(rawValue: 28500)
}

extension MenuID {
    static func fromCEF(value: Int32) -> MenuID {
        return MenuID(rawValue: value)
    }

    func toCEF() -> Int32 {
        return rawValue
    }
}


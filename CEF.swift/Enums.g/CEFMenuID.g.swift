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

    public static let back = CEFMenuID(rawValue: 100)
    public static let forward = CEFMenuID(rawValue: 101)
    public static let reload = CEFMenuID(rawValue: 102)
    public static let reloadNoCache = CEFMenuID(rawValue: 103)

    /// Editing.
    public static let stopLoad = CEFMenuID(rawValue: 104)
    public static let undo = CEFMenuID(rawValue: 110)
    public static let redo = CEFMenuID(rawValue: 111)
    public static let cut = CEFMenuID(rawValue: 112)
    public static let copy = CEFMenuID(rawValue: 113)
    public static let paste = CEFMenuID(rawValue: 114)
    public static let delete = CEFMenuID(rawValue: 115)

    /// Miscellaneous.
    public static let selectAll = CEFMenuID(rawValue: 116)
    public static let find = CEFMenuID(rawValue: 130)
    public static let print = CEFMenuID(rawValue: 131)

    /// Spell checking word correction suggestions.
    public static let viewSource = CEFMenuID(rawValue: 132)
    public static let spellcheckSuggestion0 = CEFMenuID(rawValue: 200)
    public static let spellcheckSuggestion1 = CEFMenuID(rawValue: 201)
    public static let spellcheckSuggestion2 = CEFMenuID(rawValue: 202)
    public static let spellcheckSuggestion3 = CEFMenuID(rawValue: 203)
    public static let spellcheckSuggestion4 = CEFMenuID(rawValue: 204)
    public static let spellcheckSuggestionLast = CEFMenuID(rawValue: 204)
    public static let noSpellingSuggestions = CEFMenuID(rawValue: 205)

    /// Custom menu items originating from the renderer process. For example,
    /// plugin placeholder menu items or Flash menu items.
    public static let addToDictionary = CEFMenuID(rawValue: 206)
    public static let customFirst = CEFMenuID(rawValue: 220)

    /// All user-defined menu IDs should come between MENU_ID_USER_FIRST and
    /// MENU_ID_USER_LAST to avoid overlapping the Chromium and CEF ID ranges
    /// defined in the tools/gritsettings/resource_ids file.
    public static let customLast = CEFMenuID(rawValue: 250)
    public static let userFirst = CEFMenuID(rawValue: 26500)
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


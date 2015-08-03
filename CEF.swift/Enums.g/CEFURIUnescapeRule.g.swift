//
//  CEFURIUnescapeRule.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

///
// URI unescape rules passed to CefURIDecode().
///
public struct CEFURIUnescapeRule: OptionSetType {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    ///
    // Don't unescape anything at all.
    ///
    public static let None = CEFURIUnescapeRule(rawValue: 0)

    ///
    // Don't unescape anything special, but all normal unescaping will happen.
    // This is a placeholder and can't be combined with other flags (since it's
    // just the absence of them). All other unescape rules imply "normal" in
    // addition to their special meaning. Things like escaped letters, digits,
    // and most symbols will get unescaped with this mode.
    ///
    public static let Normal = CEFURIUnescapeRule(rawValue: 1)

    ///
    // Convert %20 to spaces. In some places where we're showing URLs, we may
    // want this. In places where the URL may be copied and pasted out, then
    // you wouldn't want this since it might not be interpreted in one piece
    // by other applications.
    ///
    public static let Spaces = CEFURIUnescapeRule(rawValue: 2)

    ///
    // Unescapes various characters that will change the meaning of URLs,
    // including '%', '+', '&', '/', '#'. If we unescaped these characters, the
    // resulting URL won't be the same as the source one. This flag is used when
    // generating final output like filenames for URLs where we won't be
    // interpreting as a URL and want to do as much unescaping as possible.
    ///
    public static let URLSpecialChars = CEFURIUnescapeRule(rawValue: 4)

    ///
    // Unescapes control characters such as %01. This INCLUDES NULLs. This is
    // used for rare cases such as data: URL decoding where the result is binary
    // data. This flag also unescapes BiDi control characters.
    //
    // DO NOT use CONTROL_CHARS if the URL is going to be displayed in the UI
    // for security reasons.
    ///
    public static let ControlChars = CEFURIUnescapeRule(rawValue: 8)

    ///
    // URL queries use "+" for space. This flag controls that replacement.
    ///
    public static let ReplacePlusWithSpace = CEFURIUnescapeRule(rawValue: 16)
}

extension CEFURIUnescapeRule {
    static func fromCEF(value: cef_uri_unescape_rule_t) -> CEFURIUnescapeRule {
        return CEFURIUnescapeRule(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_uri_unescape_rule_t {
        return cef_uri_unescape_rule_t(rawValue: UInt32(rawValue))
    }
}


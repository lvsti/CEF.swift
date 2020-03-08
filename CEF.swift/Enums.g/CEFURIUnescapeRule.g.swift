//
//  CEFURIUnescapeRule.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_types.h.
//

import Foundation

/// URI unescape rules passed to CefURIDecode().
/// CEF name: `cef_uri_unescape_rule_t`.
public struct CEFURIUnescapeRule: OptionSet {
    public let rawValue: UInt32
    public init(rawValue: UInt32) {
        self.rawValue = rawValue
    }


    /// Don't unescape anything at all.
    /// CEF name: `UU_NONE`.
    public static let none = CEFURIUnescapeRule(rawValue: 0)

    /// Don't unescape anything special, but all normal unescaping will happen.
    /// This is a placeholder and can't be combined with other flags (since it's
    /// just the absence of them). All other unescape rules imply "normal" in
    /// addition to their special meaning. Things like escaped letters, digits,
    /// and most symbols will get unescaped with this mode.
    /// CEF name: `UU_NORMAL`.
    public static let normal = CEFURIUnescapeRule(rawValue: 1 << 0)

    /// Convert %20 to spaces. In some places where we're showing URLs, we may
    /// want this. In places where the URL may be copied and pasted out, then
    /// you wouldn't want this since it might not be interpreted in one piece
    /// by other applications.
    /// CEF name: `UU_SPACES`.
    public static let spaces = CEFURIUnescapeRule(rawValue: 1 << 1)

    /// Unescapes '/' and '\\'. If these characters were unescaped, the resulting
    /// URL won't be the same as the source one. Moreover, they are dangerous to
    /// unescape in strings that will be used as file paths or names. This value
    /// should only be used when slashes don't have special meaning, like data
    /// URLs.
    /// CEF name: `UU_PATH_SEPARATORS`.
    public static let pathSeparators = CEFURIUnescapeRule(rawValue: 1 << 2)

    /// Unescapes various characters that will change the meaning of URLs,
    /// including '%', '+', '&', '#'. Does not unescape path separators.
    /// If these characters were unescaped, the resulting URL won't be the same
    /// as the source one. This flag is used when generating final output like
    /// filenames for URLs where we won't be interpreting as a URL and want to do
    /// as much unescaping as possible.
    /// CEF name: `UU_URL_SPECIAL_CHARS_EXCEPT_PATH_SEPARATORS`.
    public static let urlSpecialCharsExceptPathSeparators = CEFURIUnescapeRule(rawValue: 1 << 3)

    /// URL queries use "+" for space. This flag controls that replacement.
    /// CEF name: `UU_REPLACE_PLUS_WITH_SPACE`.
    public static let replacePlusWithSpace = CEFURIUnescapeRule(rawValue: 1 << 4)
}

extension CEFURIUnescapeRule {
    static func fromCEF(_ value: cef_uri_unescape_rule_t) -> CEFURIUnescapeRule {
        return CEFURIUnescapeRule(rawValue: UInt32(value.rawValue))
    }

    func toCEF() -> cef_uri_unescape_rule_t {
        return cef_uri_unescape_rule_t(rawValue: UInt32(rawValue))
    }
}


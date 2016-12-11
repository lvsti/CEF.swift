//
//  CEFCompositionUnderline.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 12. 11..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Structure representing IME composition underline information. This is a thin
/// wrapper around Blink's WebCompositionUnderline class and should be kept in
/// sync with that.
/// CEF name: `cef_composition_underline_t`
public struct CEFCompositionUnderline {
    /// Underline character range.
    /// CEF name: `range`
    public var range: CEFRange
    
    /// Text color.
    /// CEF name: `color`
    public var color: CEFColor
    
    /// Background color.
    /// CEF name: `background_color`
    public var backgroundColor: CEFColor
    
    /// Set to true (1) for thick underline.
    /// CEF name: `thick`
    public var useThickStyle: Bool
}

extension CEFCompositionUnderline {
    func toCEF() -> cef_composition_underline_t {
        return cef_composition_underline_t(range: range.toCEF(),
                                           color: color.toCEF(),
                                           background_color: backgroundColor.toCEF(),
                                           thick: useThickStyle ? 1 : 0)
    }
    
    static func fromCEF(_ value: cef_composition_underline_t) -> CEFCompositionUnderline {
        return CEFCompositionUnderline(range: CEFRange.fromCEF(value.range),
                                       color: CEFColor.fromCEF(value.color),
                                       backgroundColor: CEFColor.fromCEF(value.background_color),
                                       useThickStyle: value.thick != 0)
    }
}

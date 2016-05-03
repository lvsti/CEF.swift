//
//  CEFBoxLayoutSettings.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2016. 05. 03..
//  Copyright © 2016. Tamas Lustyik. All rights reserved.
//

import Foundation

/// Settings used when initializing a CefBoxLayout.
public struct CEFBoxLayoutSettings {
    /// If true (1) the layout will be horizontal, otherwise the layout will be
    /// vertical.
    public var horizontal: Bool
    
    /// Adds additional horizontal space between the child view area and the host
    /// view border.
    public var insideBorderHorizontalSpacing: Int
    
    /// Adds additional vertical space between the child view area and the host
    /// view border.
    public var insideBorderVerticalSpacing: Int
    
    /// Adds additional space around the child view area.
    public var insideBorderInsets: CEFInsets
    
    /// Adds additional space between child views.
    public var betweenChildSpacing: Int
    
    /// Specifies where along the main axis the child views should be laid out.
    public var mainAxisAlignment: CEFMainAxisAlignment
    
    /// Specifies where along the cross axis the child views should be laid out.
    public var crossAxisAlignment: CEFCrossAxisAlignment
    
    /// Minimum cross axis size.
    public var minimumCrossAxisSize: Int
    
    /// Default flex for views when none is specified via CefBoxLayout methods.
    /// Using the preferred size as the basis, free space along the main axis is
    /// distributed to views in the ratio of their flex weights. Similarly, if the
    /// views will overflow the parent, space is subtracted in these ratios. A flex
    /// of 0 means this view is not resized. Flex values must not be negative.
    public var defaultFlex: Int
}

extension CEFBoxLayoutSettings {
    func toCEF() -> cef_box_layout_settings_t {
        return cef_box_layout_settings_t(
            horizontal: horizontal ? 1 : 0,
            inside_border_horizontal_spacing: Int32(insideBorderHorizontalSpacing),
            inside_border_vertical_spacing: Int32(insideBorderVerticalSpacing),
            inside_border_insets: insideBorderInsets.toCEF(),
            between_child_spacing: Int32(betweenChildSpacing),
            main_axis_alignment: mainAxisAlignment.toCEF(),
            cross_axis_alignment: crossAxisAlignment.toCEF(),
            minimum_cross_axis_size: Int32(minimumCrossAxisSize),
            default_flex: Int32(defaultFlex)
        )
    }
    
    static func fromCEF(value: cef_box_layout_settings_t) -> CEFBoxLayoutSettings {
        return CEFBoxLayoutSettings(
            horizontal: value.horizontal == 1,
            insideBorderHorizontalSpacing: Int(value.inside_border_horizontal_spacing),
            insideBorderVerticalSpacing: Int(value.inside_border_vertical_spacing),
            insideBorderInsets: CEFInsets.fromCEF(value.inside_border_insets),
            betweenChildSpacing: Int(value.between_child_spacing),
            mainAxisAlignment: CEFMainAxisAlignment.fromCEF(value.main_axis_alignment),
            crossAxisAlignment: CEFCrossAxisAlignment.fromCEF(value.cross_axis_alignment),
            minimumCrossAxisSize: Int(value.minimum_cross_axis_size),
            defaultFlex: Int(value.default_flex)
        )
    }
}

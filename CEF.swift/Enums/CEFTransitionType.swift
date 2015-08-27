//
//  CEFTransitionType.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 01..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Transition type for a request. Made up of one source value and 0 or more
// qualifiers.
///
public struct CEFTransitionType: RawRepresentable {
    public let rawValue: UInt
    
    public enum Source: UInt8 {
        ///
        // Source is a link click or the JavaScript window.open function. This is
        // also the default value for requests like sub-resource loads that are not
        // navigations.
        ///
        case Link = 0

        ///
        // Source is some other "explicit" navigation action such as creating a new
        // browser or using the LoadURL function. This is also the default value
        // for navigations where the actual type is unknown.
        ///
        case Explicit
        
        ///
        // Source is a subframe navigation. This is any content that is automatically
        // loaded in a non-toplevel frame. For example, if a page consists of several
        // frames containing ads, those ad URLs will have this transition type.
        // The user may not even realize the content in these pages is a separate
        // frame, so may not care about the URL.
        ///
        case AutoSubframe
        
        ///
        // Source is a subframe navigation explicitly requested by the user that will
        // generate new navigation entries in the back/forward list. These are
        // probably more important than frames that were automatically loaded in
        // the background because the user probably cares about the fact that this
        // link was loaded.
        ///
        case ManualSubframe
        
        ///
        // Source is a form submission by the user. NOTE: In some situations
        // submitting a form does not result in this transition type. This can happen
        // if the form uses a script to submit the contents.
        ///
        case FormSubmit
        
        ///
        // Source is a "reload" of the page via the Reload function or by re-visiting
        // the same URL. NOTE: This is distinct from the concept of whether a
        // particular load uses "reload semantics" (i.e. bypasses cached data).
        ///
        case Reload
    }
    
    public struct Flags: OptionSetType {
        public let rawValue: UInt
        public init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        ///
        // Attempted to visit a URL but was blocked.
        ///
        public static let Blocked = Flags(rawValue: 0x00800000)

        ///
        // Used the Forward or Back function to navigate among browsing history.
        ///
        public static let ForwardBack = Flags(rawValue: 0x01000000)
        
        ///
        // The beginning of a navigation chain.
        ///
        public static let ChainStart = Flags(rawValue: 0x10000000)
        
        ///
        // The last transition in a redirect chain.
        ///
        public static let ChainEnd = Flags(rawValue: 0x20000000)
        
        ///
        // Redirects caused by JavaScript or a meta refresh tag on the page.
        ///
        public static let ClientRedirect = Flags(rawValue: 0x40000000)
        
        ///
        // Redirects sent from the server by HTTP headers.
        ///
        public static let ServerRedirect = Flags(rawValue: 0x80000000)
        
        ///
        // Used to test whether a transition involves a redirect.
        ///
        public var isRedirect: Bool { return self.contains(.ClientRedirect) || self.contains(.ServerRedirect) }
    }
    
    public var source: Source { get { return Source(rawValue: UInt8(UInt32(rawValue) & TT_SOURCE_MASK.rawValue))! } }
    public var flags: Flags { get { return Flags(rawValue: UInt(UInt32(rawValue) & TT_QUALIFIER_MASK.rawValue)) } }
    
    public init(rawValue: UInt) {
        self.rawValue = rawValue
    }
    
    static func fromCEF(value: cef_transition_type_t) -> CEFTransitionType {
        return CEFTransitionType(rawValue: UInt(value.rawValue))
    }
}


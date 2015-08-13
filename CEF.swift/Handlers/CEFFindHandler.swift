//
//  CEFFindHandler.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 08. 11..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Foundation

///
// Implement this interface to handle events related to find results. The
// methods of this class will be called on the UI thread.
///
public protocol CEFFindHandler {
    
    ///
    // Called to report find results returned by CefBrowserHost::Find().
    // |identifer| is the identifier passed to Find(), |count| is the number of
    // matches currently identified, |selectionRect| is the location of where the
    // match was found (in window coordinates), |activeMatchOrdinal| is the
    // current position in the search results, and |finalUpdate| is true if this
    // is the last find notification.
    ///
    func onFindResult(browser: CEFBrowser,
                      identifier: CEFFindIdentifier,
                      count: Int,
                      selectionRect: NSRect,
                      currentIndex: Int,
                      isLastUpdate: Bool)

}

public extension CEFFindHandler {
    
    func onFindResult(browser: CEFBrowser,
                      identifier: CEFFindIdentifier,
                      count: Int,
                      selectionRect: NSRect,
                      currentIndex: Int,
                      isLastUpdate: Bool) {
    }

}


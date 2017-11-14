//
//  CEF.swift.h
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 12..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

#import <Cocoa/Cocoa.h>

//! Project version number for CEF.swift.
FOUNDATION_EXPORT double CEFswiftVersionNumber;

//! Project version string for CEF.swift.
FOUNDATION_EXPORT const unsigned char CEFswiftVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <CEF_swift/PublicHeader.h>

@import ChromiumEmbedded;

// from include/cef_application_mac.h
/// Copy of definition from ui/base/cocoa/underlay_opengl_hosting_window.h.
/// Common base class for windows that host a OpenGL surface that renders under
/// the window. Contains methods relating to hole punching so that the OpenGL
/// surface is visible through the window.
@interface UnderlayOpenGLHostingWindow : NSWindow
@end

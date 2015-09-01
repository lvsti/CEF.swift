//
//  cef_application_mac_capi.h
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 19..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

#ifndef cef_application_mac_capi_h
#define cef_application_mac_capi_h

#import <AppKit/AppKit.h>
#import <Cocoa/Cocoa.h>

// Copy of definition from base/message_loop/message_pump_mac.h.
@protocol CrAppProtocol
// Must return true if -[NSApplication sendEvent:] is currently on the stack.
- (BOOL)isHandlingSendEvent;
@end

// Copy of definition from base/mac/scoped_sending_event.h.
@protocol CrAppControlProtocol<CrAppProtocol>
- (void)setHandlingSendEvent:(BOOL)handlingSendEvent;
@end

// Copy of definition from ui/base/cocoa/underlay_opengl_hosting_window.h.
// Common base class for windows that host a OpenGL surface that renders under
// the window. Contains methods relating to hole punching so that the OpenGL
// surface is visible through the window.
@interface UnderlayOpenGLHostingWindow : NSWindow
@end


// All CEF client applications must subclass NSApplication and implement this
// protocol.
@protocol CefAppProtocol<CrAppControlProtocol>
@end


#endif

//
//  AppDelegate.swift
//  CEFDemo
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    func createApplication() {
        NSApplication.sharedApplication()
        NSBundle.mainBundle().loadNibNamed("MainMenu", owner: NSApp, topLevelObjects: nil)
        NSApp.delegate = self
    }
    
    func tryToTerminateApplication(app: NSApplication) {
        let handler = SimpleHandler.instance
        if !handler.isClosing {
            handler.closeAllBrowsers(false)
        }
    }
    
    func applicationShouldTerminate(sender: NSApplication) -> NSApplicationTerminateReply {
        return .TerminateNow
    }

}


//
//  main.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa
import CEFswift

class Client: CEFClient {
    override init() {
        super.init()
    }
}

class BrowserProcessHandler: CEFBrowserProcessHandler {
    let client: Client
    
    override init() {
        client = Client()
        super.init()
    }
    
    override func onContextInitialized() {
        let winInfo = CEFWindowInfo()
        let settings = CEFBrowserSettings()
        
        let cmdLine = CEFCommandLine.getGlobal()
        var url = NSURL(string: "http://www.google.com")!
        if let urlSwitch = cmdLine?.getSwitchValue("url") where !urlSwitch.isEmpty {
            url = NSURL(string: urlSwitch)!
        }
        
        CEFBrowserHost.createBrowser(winInfo, client: client, url: url, settings: settings, requestContext: nil)
    }
}

class SimpleApp: CEFApp {

    let browserProcessHandler: BrowserProcessHandler
    
    override init() {
        browserProcessHandler = BrowserProcessHandler()
        super.init()
    }
    
    override func getBrowserProcessHandler() -> CEFBrowserProcessHandler? {
        return browserProcessHandler
    }
}


class SimpleHandler: CEFClient {
    static var instance = SimpleHandler()
    
    private var _isClosing: Bool = false
    var isClosing: Bool { get { return _isClosing } }
    
    func closeAllBrowsers(force: Bool) {
        
    }
    
    override init() {
        super.init()
    }
}


class SimpleApplication : NSApplication, CefAppProtocol {
    
    var _isHandlingSendEvent: Bool = false
    
    func isHandlingSendEvent() -> Bool {
        return _isHandlingSendEvent
    }
    
    func setHandlingSendEvent(handlingSendEvent: Bool) {
        _isHandlingSendEvent = handlingSendEvent
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sendEvent(event: NSEvent) {
        let stashedIsHandlingSendEvent = _isHandlingSendEvent
        _isHandlingSendEvent = true
        defer { _isHandlingSendEvent = stashedIsHandlingSendEvent }

        super.sendEvent(event)
    }
    
    override func terminate(sender: AnyObject?) {
        let delegate = NSApplication.sharedApplication().delegate as! AppDelegate
        delegate.tryToTerminateApplication(self)
    }
}

let args = CEFMainArgs(arguments: Process.arguments)
let app = SimpleApp()

SimpleApplication.sharedApplication()

let settings = CEFSettings()

CEFInitialize(args, settings: settings, app: app)

let appDelegate = AppDelegate()
appDelegate.createApplication()

CEFRunMessageLoop()
CEFShutdown()

exit(0)


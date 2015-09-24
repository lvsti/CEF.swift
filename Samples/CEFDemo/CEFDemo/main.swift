//
//  main.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa
import CEFswift


class SimpleApp: App, BrowserProcessHandler {

    let client: SimpleHandler
    
    init() {
        client = SimpleHandler.instance
    }
    
    // cefapp
    var browserProcessHandler: BrowserProcessHandler? { return self }
    
    // cefbrowserprocesshandler
    func onContextInitialized() {
        let winInfo = WindowInfo()
        let settings = BrowserSettings()

        let cmdLine = CommandLine.globalCommandLine()
        var url = NSURL(string: "http://www.google.com")!
        if let urlSwitch = cmdLine?.valueForSwitch("url") where !urlSwitch.isEmpty {
            url = NSURL(string: urlSwitch)!
        }
        
        BrowserHost.createBrowser(winInfo, client: client, url: url, settings: settings, requestContext: nil)
    }
}


class SimpleHandler: Client, LifeSpanHandler {
    
    static var instance = SimpleHandler()
    
    private var _browserList = [Browser]()
    private var _isClosing: Bool = false
    var isClosing: Bool { get { return _isClosing } }
    
    // from CEFClient
    var lifeSpanHandler: LifeSpanHandler? {
        return self
    }
    
    // from CEFLifeSpanHandler
    func onAfterCreated(browser: Browser) {
        _browserList.append(browser)
    }
    
    func doClose(browser: Browser) -> Bool {
        if _browserList.count == 1 {
            _isClosing = true
        }
        return false
    }
    
    func onBeforeClose(browser: Browser) {
        for (index, value) in _browserList.enumerate() {
            if value.isSameAs(browser) {
                _browserList.removeAtIndex(index)
                break
            }
        }
        
        if _browserList.isEmpty {
            ProcessUtils.quitMessageLoop()
        }
    }
    
    // new methods
    func closeAllBrowsers(force: Bool) {
        _browserList.forEach { browser in
            browser.host?.closeBrowser(force: force)
        }
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

let args = MainArgs(arguments: Process.arguments)
let app = SimpleApp()

SimpleApplication.sharedApplication()

let settings = Settings()

ProcessUtils.initializeWithArgs(args, settings: settings, app: app)

let appDelegate = AppDelegate()
appDelegate.createApplication()

ProcessUtils.runMessageLoop()
ProcessUtils.shutDown()

exit(0)


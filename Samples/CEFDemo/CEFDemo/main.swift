//
//  main.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa
import CEFswift


class SimpleApp: CEFApp, CEFBrowserProcessHandler {

    let client: SimpleHandler
    
    init() {
        client = SimpleHandler.instance
    }
    
    // cefapp
    var browserProcessHandler: CEFBrowserProcessHandler? { return self }
    
    // cefbrowserprocesshandler
    func onContextInitialized() {
        let winInfo = CEFWindowInfo()
        let settings = CEFBrowserSettings()

        let cmdLine = CEFCommandLine.global
        var url = URL(string: "http://www.google.com")!
        if let urlSwitch = cmdLine?.switchValue(for: "url"), !urlSwitch.isEmpty {
            url = URL(string: urlSwitch)!
        }
        
        _ = CEFBrowserHost.createBrowser(windowInfo: winInfo, client: client, url: url, settings: settings, requestContext: nil)
    }
}


class SimpleHandler: CEFClient, CEFLifeSpanHandler {
    
    static var instance = SimpleHandler()
    
    private var _browserList = [CEFBrowser]()
    private var _isClosing: Bool = false
    var isClosing: Bool { get { return _isClosing } }
    
    // from CEFClient
    var lifeSpanHandler: CEFLifeSpanHandler? {
        return self
    }
    
    // from CEFLifeSpanHandler
    func onAfterCreated(browser: CEFBrowser) {
        _browserList.append(browser)
    }
    
    func onDoClose(browser: CEFBrowser) -> CEFOnDoCloseAction {
        if _browserList.count == 1 {
            _isClosing = true
        }
        return .allow
    }
    
    func onBeforeClose(browser: CEFBrowser) {
        for (index, value) in _browserList.enumerated() {
            if value.isSame(as: browser) {
                _browserList.remove(at: index)
                break
            }
        }
        
        if _browserList.isEmpty {
            CEFProcessUtils.quitMessageLoop()
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
    
    func setHandlingSendEvent(_ handlingSendEvent: Bool) {
        _isHandlingSendEvent = handlingSendEvent
    }

    override init() {
        super.init()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func sendEvent(_ event: NSEvent) {
        let stashedIsHandlingSendEvent = _isHandlingSendEvent
        _isHandlingSendEvent = true
        defer { _isHandlingSendEvent = stashedIsHandlingSendEvent }

        super.sendEvent(event)
    }
    
    override func terminate(_ sender: Any?) {
        let delegate = NSApplication.shared.delegate as! AppDelegate
        delegate.tryToTerminateApplication(app: self)
    }
}

let args = CEFMainArgs(arguments: CommandLine.arguments)
let app = SimpleApp()

_ = SimpleApplication.shared

let settings = CEFSettings()

_ = CEFProcessUtils.initializeMain(with: args, settings: settings, app: app)

let appDelegate = AppDelegate()
appDelegate.createApplication()

CEFProcessUtils.runMessageLoop()
CEFProcessUtils.shutDown()

exit(0)


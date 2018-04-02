//
//  main.swift
//  CEF.swift
//
//  Created by Tamas Lustyik on 2015. 07. 18..
//  Copyright © 2015. Tamas Lustyik. All rights reserved.
//

import Cocoa
import CEFswift

let SingleProcessMode = false

class SimpleApp: CEFApp, CEFBrowserProcessHandler, CEFRenderProcessHandler {

    let client: SimpleHandler
    
    init() {
        client = SimpleHandler.instance
    }
    
    // cefapp
    var browserProcessHandler: CEFBrowserProcessHandler? { return self }
    var renderProcessHandler: CEFRenderProcessHandler? { return self }
    
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

    // renderprocesshandler
    func onContextCreated(browser: CEFBrowser, frame: CEFFrame) {

        if (!SingleProcessMode) {
            // Register an JS handler called "Native"
            let boundObj = CEFBoundObjectHandler(methods: [
                "test1" : { (handler, arguments) -> [String: Any] in
                    return [
                        "b": arguments.int32(at: 0),
                        "kk": arguments.double(at: 2),
                        "a": arguments.string(at: 1) ?? "",
                        "c": "cccccbbbbbaaaaa",
                        "d": [1, 2, "aaaaa"],
                        "e": ["e": "e", "a": 3, "c": "fasf"]
                    ]
                }
                ])
            frame.registerJsHandler(forName: "Native", handler: boundObj)

            // Call the previously registered JS handler
            frame.executeJavaScript(code: "window.Native.test1(5555, '9999', 777.123).then(function(result){ document.body.innerText = JSON.stringify(result) })")
        }
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


class SimpleApplication : CEFApplication {
    override func terminate(_ sender: Any?) {
        let delegate = NSApplication.shared.delegate as! AppDelegate
        delegate.tryToTerminateApplication(app: self)
    }
}

_ = SimpleApplication.shared

var settings = CEFSettings()

// To enable Multi-Process mode, set the useSingleProcess to false and the BrowserSubprocessPath to the CEFHelper.
// The CEFHelper implemnts generic logics for multi-process mode.
// To disable Mutli-Process mode, remove these two settings. This will make the app use the `CEFDemo Helper` (Which has
// no logic, and is different from the CEFHelper)
if (!SingleProcessMode) {
    settings.useSingleProcess = false
    settings.browserSubprocessPath = Bundle.main.bundleURL.appendingPathComponent("Contents/Frameworks/CEFHelper.app/Contents/MacOS/CEFHelper").path
}

// By setting this value, one can use chrome to remote debug the page
settings.remoteDebuggingPort = 8888

var args = CommandLine.arguments
// Use --no-sandbox will prevent some sandbox error
args.append("--no-sandbox")
// To debug the subprocess(Render Process), enable this line to add the flag --renderer-startup-dialog.
// args.append("--renderer-startup-dialog")

_ = CEFProcessUtils.initializeMain(
    with: CEFMainArgs(arguments: args),
    settings: settings,
    app: SimpleApp()
)

let appDelegate = AppDelegate()
_ = NSApplication.shared
Bundle.main.loadNibNamed(NSNib.Name("MainMenu"), owner: NSApp, topLevelObjects: nil)
NSApp.delegate = appDelegate

CEFProcessUtils.runMessageLoop()
CEFProcessUtils.shutDown()

exit(0)


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


class SimpleHandler: CEFClient, CEFLifeSpanHandler, CEFLoadHandler, CEFRequestHandler {
    
    static var instance = SimpleHandler()
    
    private var _router = CEFMessageRouterBrowserSide(config: CEFMessageRouterConfig())!
    private var _token: CEFMessageRouterBrowserSideHandlerToken?
    private var _browserList = [CEFBrowser]()
    private var _isClosing: Bool = false
    var isClosing: Bool { get { return _isClosing } }
    
    // from CEFClient
    var lifeSpanHandler: CEFLifeSpanHandler? {
        return self
    }
    
    var loadHandler: CEFLoadHandler? {
        return self
    }
    
    var requestHandler: CEFRequestHandler? {
        return self
    }
    
    func onProcessMessageReceived(browser: CEFBrowser, processID: CEFProcessID, message: CEFProcessMessage) -> CEFOnProcessMessageReceivedAction {
        return _router.onProcessMessageReceived(browser: browser, processID: processID, message: message)
    }
    
    // from CEFRequestHandler
    func onBeforeBrowse(browser: CEFBrowser, frame: CEFFrame, request: CEFRequest, userGesture: Bool, isRedirect: Bool) -> CEFOnBeforeBrowseAction {
        _router.onBeforeBrowse(browser: browser, frame: frame)
        return .allow
    }
    
    func onRenderProcessTerminated(browser: CEFBrowser, status: CEFTerminationStatus) {
        _router.onRenderProcessTerminated(browser: browser)
    }
    
    // from CEFLifeSpanHandler
    func onAfterCreated(browser: CEFBrowser) {
        _token = _router.addHandler(asFirst: true,
                                    onQuery: { [unowned self] (_, _, queryID, request, _, callback) in
                                        NSLog("JS query: \(queryID) - \(request)")
                                        if request == "catch me" {
                                            callback.reportSuccess(withResponse: "OK")
                                        }
                                        else {
                                            callback.reportFailure(withErrorCode: -1, message: "invalid request")
                                        }
                                        
                                        self._router.removeHandler(withToken: self._token!)
                                        self._token = nil
                                        return .consume
                                    },
                                    onQueryCanceled: { _, _, queryID  in
                                        NSLog("JS query cancelled: \(queryID)")
                                    })
        _browserList.append(browser)
    }
    
    func onDoClose(browser: CEFBrowser) -> CEFOnDoCloseAction {
        if _browserList.count == 1 {
            _isClosing = true
        }
        return .allow
    }
    
    func onBeforeClose(browser: CEFBrowser) {
        _router.onBeforeClose(browser: browser)
        
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
    
    // from CEFLoadHandler
    
    func onLoadEnd(browser: CEFswift.CEFBrowser, frame: CEFswift.CEFFrame, statusCode: Int) {
        if frame.url.host == "example.com" {
            return
        }
        
        let html = """
<html><head><title></title><script>
window.cefQuery({request: 'catch me',
    persistent: false,
    onSuccess: function(response) { console.log('OK: ' + response); },
    onFailure: function(error_code, error_message) {console.log('Error: ' + error_code + ',' + error_message);} });
</script>
</head><body></body></html>
"""
        browser.mainFrame?.loadString(html, withURL: URL(string: "https://example.com")!)
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

#if USE_LEGACY_SANDBOX
let args = CEFMainArgs(arguments: CommandLine.arguments + ["--disable-features=MacV2Sandbox"])
#else
let args = CEFMainArgs(arguments: CommandLine.arguments)
#endif

let app = SimpleApp()

_ = SimpleApplication.shared

let settings = CEFSettings()

_ = CEFProcessUtils.initializeMain(with: args, settings: settings, app: app)

let appDelegate = AppDelegate()
appDelegate.createApplication()

CEFProcessUtils.runMessageLoop()
CEFProcessUtils.shutDown()

exit(0)


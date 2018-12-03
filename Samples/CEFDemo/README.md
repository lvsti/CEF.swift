# CEFDemo

CEF-based applications typically consist of two executables: a regular and a sandboxed helper app. `CEFDemo` demonstrates how you would go about developing these two in Swift, with the help of `CEFswift`.

Project contents:

#### CEFDemo.app

The main user-facing executable. This is basically *your app* that shows the embedded browser for some feature.

#### CEFDemo Helper.app

Chromium spawns a helper application for each of its "tabs" or pages that it loads. In most cases, the helper can be dead simple with few to no moving parts, handing control over to CEF directly. You can find a reference implementation in `main.c` which you can use out-of-the-box. (Why in C? Read on.)

In the rare case that you need to override the default behavior of the render process (e.g. by setting up native JS extensions), you have to provide a non-trivial helper. This is where the SwiftHelper.framework enters the scene.

#### SwiftHelper.framework

Up until Chromium 69 (CEF branch 3497) you could dynamically link `CEFswift.framework` to both executables at build-time. Starting from Chromium 70 (CEF branch 3538), however, Chromium & CEF self-impose a [stricter sandbox](https://bitbucket.org/chromiumembedded/cef/issues/2459/macos-enable-the-macv2sandbox) implementation which requires that the Chromium Embedded framework be linked only after the sandbox has been initialized. Due to CEF.swift's dependency on CEF, it's impossible to use the former without loading the latter, which effectively prevents us from writing the main entry point in Swift.

The workaround is to write the bootstrapping code in C that calls into a pure Swift framework once the sandbox is set up. This framework is called SwiftHelper in the example. The Swift entry point is `HelperMain()` where you can do anything you used to do in `main.swift`, like parsing `CommandLine.arguments` or initializing your custom `App` instance using CEF.swift.

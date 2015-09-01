# CEF.swift

Swift bindings for the [Chromium Embedded Framework](https://bitbucket.org/chromiumembedded/cef/).

### Requirements

Xcode 7 beta, Swift 2.0, CEF3 branch 2357 (or above?)

### How to build

1. fetch this repo
2. grab a binary distribution from [cefbuilds.com]() and shove its contents into the `<repo_root>/External/cef_binary` folder
3. following the instructions in the binary distribution, build the `cefsimple` app
4. now you are ready to compile the CEF.swift framework

### Getting started

Check out the (pretty skinny) CEFDemo app under `Samples/CEFDemo` to get the basic idea of how a CEF-based app should look like. For more inspiration, take a look at the `cefsimple` and `cefclient` apps shipped with the CEF binary distribution.

### Disclaimer

This project is incomplete, untested, and most likely unstable, so **use it at your own risk**. Bug reports and suggestions are welcome though.

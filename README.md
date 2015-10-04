# CEF.swift

Swift bindings for the [Chromium Embedded Framework](https://bitbucket.org/chromiumembedded/cef/).

### Requirements

Xcode 7, Swift 2.0

tools: cmake, jq, p7zip

### How to build

1. fetch this repo
2. switch to the appropriate branch in CEF.swift to match the CEF distribution (see notes below)
3. run `scripts/setup.sh` from the repo root
4. now you are ready to compile the CEF.swift framework

### CEF branches

CEF is developed on multiple branches simultaneously, which differ in API and functionality (see [cefbuilds.com](https://cefbuilds.com)). CEF.swift aims at supporting the current stable and dev release branches; supporting dev trunk is out of scope for now, however. For any CEF branch `NNNN`, the corresponding CEF.swift branch is named `cef_NNNN`.

Currently supported branches: 

- 2357
- 2454

### Getting started

Check out the (pretty skinny) CEFDemo app under `Samples/CEFDemo` to get the basic idea of how a CEF-based app should look like. For more inspiration, take a look at the `cefsimple` and `cefclient` apps shipped with the CEF binary distribution.

### Disclaimer

This project is incomplete, untested, and most likely unstable, so **use it at your own risk**. Bug reports and suggestions are welcome though.

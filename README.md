# CEF.swift

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-brightgreen.svg)](https://github.com/Carthage/Carthage)

Swift bindings for the [Chromium Embedded Framework](https://bitbucket.org/chromiumembedded/cef/).

### Requirements

Xcode 10.1, Swift 4.2 (see notes below)<br/>
Supported target platforms: macOS 10.9+

Required tools: jq, xcpretty<br/>
To set up your environment:

```
$ brew install jq
$ gem install xcpretty
```

### How to build

##### The easy way

You can now build CEF.swift using [Carthage](https://github.com/Carthage/Carthage). Just add the following line to your `Cartfile`:

```
github "lvsti/CEF.swift" "<branch_specifier>"
```

(For the `branch_specifier`, see the notes on branches below.)

Note that the bootstrap build will take quite some time as CEF.swift has to fetch and build external dependencies as well.

##### The oldschool way

1. fetch this repo
2. switch to the appropriate branch in CEF.swift to match the CEF distribution (see notes below)
3. run `scripts/setup.sh` from the repo root
4. now you are ready to compile the CEF.swift framework

### CEF branches

CEF is developed on multiple branches simultaneously, which differ in API and functionality (see [Spotify OpenSource](http://opensource.spotify.com/cefbuilds/index.html) and [ChromeStatus](https://www.chromestatus.com/features)). CEF.swift aims at supporting the current stable release branch and a couple more of earlier releases. For any CEF branch `NNNN`, the corresponding CEF.swift branch is named `cef_NNNN`.

Currently supported branches: 

- 4183 (Chrome 85) [![Build Status](https://travis-ci.org/lvsti/CEF.swift.svg?branch=cef_4183)](https://travis-ci.org/lvsti/CEF.swift) - Swift 4.2
- 4147 (Chrome 84) [![Build Status](https://travis-ci.org/lvsti/CEF.swift.svg?branch=cef_4147)](https://travis-ci.org/lvsti/CEF.swift) - Swift 4.2
- 4103 (Chrome 83) [![Build Status](https://travis-ci.org/lvsti/CEF.swift.svg?branch=cef_4103)](https://travis-ci.org/lvsti/CEF.swift) - Swift 4.2
- 4044 (Chrome 81) [![Build Status](https://travis-ci.org/lvsti/CEF.swift.svg?branch=cef_4044)](https://travis-ci.org/lvsti/CEF.swift) - Swift 4.2
- 3987 (Chrome 80) [![Build Status](https://travis-ci.org/lvsti/CEF.swift.svg?branch=cef_3987)](https://travis-ci.org/lvsti/CEF.swift) - Swift 4.2

Archived branches (not maintained anymore):

- 3904, 3865, 3809, 3770, 3729, 3683, 3626, 3578, 3538 - Swift 4.2
- 3497, 3440, 3396, 3359, 3325, 3282, 3239, 3202, 3163 - Swift 4.1
- 3112, 3071, 3029, 2987, 2924, 2883, 2840, 2785, 2743, 2704 - Swift 3.0
- 2623, 2526, 2454, 2357 - Swift 2.3

### Getting started

Check out the (pretty skinny) CEFDemo app under `Samples/CEFDemo` to get the basic idea of how a CEF-based app should look like. For more inspiration, take a look at the `cefsimple` and `cefclient` apps shipped with the CEF binary distribution.

### If you get stuck

CEF.swift is just a (partial) language wrapper around CEF. Once you can get a webpage to load, you are pretty much set on the integration side. If, later on, you bump into a problem, you should first go and check the official [CEF forum](https://magpcss.org/ceforum/) for guidance unless it is clearly a flaw in the Swift bindings themselves (in which case please create an issue here).

### Disclaimer

This project is incomplete, untested, and most likely unstable, so **use it at your own risk**. Bug reports and suggestions are welcome though.

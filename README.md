# CEF.swift

Swift bindings for the Chromium Embedded Framework.

### How to build

1. fetch this repo
2. grab a binary distribution from [cefbuilds.com]() and shove its contents into `External/cef_binary` folder
3. go to `External/cef_binary` and build the DLL wrapper (`libcef_dll_wrapper.a`) following the instructions there. It should end up in `External/cef_binary/build/Debug/libcef_dll_wrapper.a`
4. now you are ready to build the CEF.swift framework
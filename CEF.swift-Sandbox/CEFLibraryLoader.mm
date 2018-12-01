//
//  CEFLibraryLoader.m
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 11. 22..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

#import "CEFLibraryLoader.h"
#include "include/wrapper/cef_library_loader.h"

static CefScopedLibraryLoader* _libraryLoader;

@implementation CEFLibraryLoader

+ (BOOL)loadLibraryInApp {
    if (!_libraryLoader) {
        _libraryLoader = new CefScopedLibraryLoader();
    }
    return _libraryLoader->LoadInMain();
}

+ (BOOL)loadLibraryInHelper {
    if (!_libraryLoader) {
        _libraryLoader = new CefScopedLibraryLoader();
    }
    return _libraryLoader->LoadInHelper();
}

+ (void)unloadLibrary {
    delete _libraryLoader;
    _libraryLoader = nullptr;
}

@end

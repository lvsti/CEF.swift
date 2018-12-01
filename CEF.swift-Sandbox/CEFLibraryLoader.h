//
//  CEFLibraryLoader.h
//  CEF.swift
//
//  Created by Tamas Lustyik on 2018. 11. 22..
//  Copyright © 2018. Tamas Lustyik. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CEFLibraryLoader : NSObject

+ (BOOL)loadLibraryInApp;
+ (BOOL)loadLibraryInHelper;

+ (void)unloadLibrary;

@end

NS_ASSUME_NONNULL_END

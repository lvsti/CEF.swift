//
//  cef_wrapper_types_ext.h
//  CEF.swift
//
//  Created by Tamas Lustyik on 2019. 05. 06..
//  Copyright © 2019. Tamas Lustyik. All rights reserved.
//

#ifndef cef_wrapper_types_ext_h
#define cef_wrapper_types_ext_h
#pragma once

#include "libcef_dll/wrapper_types.h"

enum WrapperTypeExt {
    WT_EXT_START = WT_LAST + 1,
    WT_EXT_MESSAGE_ROUTER_RENDERER_SIDE
};

#endif

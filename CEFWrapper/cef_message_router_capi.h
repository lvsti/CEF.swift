//
//  cef_message_router_capi.h
//  CEF.swift
//
//  Created by Tamas Lustyik on 2017. 11. 17..
//  Copyright © 2017. Tamas Lustyik. All rights reserved.
//

#ifndef cef_message_router_capi_h
#define cef_message_router_capi_h
#pragma once

#include "include/capi/cef_base_capi.h"
#include "include/capi/cef_process_message_capi.h"

struct _cef_browser_t;
struct _cef_frame_t;
struct _cef_v8context_t;

#ifdef __cplusplus
extern "C" {
#endif
    
typedef struct _cef_message_router_config_t {
    cef_string_t js_query_function;
    cef_string_t js_cancel_function;
} cef_message_router_config_t;

typedef struct _cef_message_router_renderer_side_t {
    ///
    // Base structure.
    ///
    cef_base_ref_counted_t base;

    ///
    // Returns the number of queries currently pending for the specified |browser|
    // and/or |context|. Either or both values may be empty.
    ///
    int(*get_pending_count)(struct _cef_message_router_renderer_side_t* self,
                            struct _cef_browser_t* browser,
                            struct _cef_v8context_t* context);

    // The below methods should be called from other CEF handlers. They must be
    // called exactly as documented for the router to function correctly.
    
    ///
    // Call from CefRenderProcessHandler::OnContextCreated. Registers the
    // JavaScripts functions with the new context.
    ///
    void(*on_context_created)(struct _cef_message_router_renderer_side_t* self,
                              struct _cef_browser_t* browser,
                              struct _cef_frame_t* frame,
                              struct _cef_v8context_t* context);

    ///
    // Call from CefRenderProcessHandler::OnContextReleased. Any pending queries
    // associated with the released context will be canceled and
    // Handler::OnQueryCanceled will be called in the browser process.
    ///
    void(*on_context_released)(struct _cef_message_router_renderer_side_t* self,
                               struct _cef_browser_t* browser,
                               struct _cef_frame_t* frame,
                               struct _cef_v8context_t* context);

    ///
    // Call from CefRenderProcessHandler::OnProcessMessageReceived. Returns true
    // if the message is handled by this router or false otherwise.
    ///
    int(*on_process_message_received)(struct _cef_message_router_renderer_side_t* self,
                                      struct _cef_browser_t* browser,
                                      cef_process_id_t source_process,
                                      struct _cef_process_message_t* message);

} cef_message_router_renderer_side_t;

///
// Create a new router with the specified configuration.
///
CEF_EXPORT cef_message_router_renderer_side_t* cef_message_router_renderer_side_create(const struct _cef_message_router_config_t* config);

#ifdef __cplusplus
}
#endif

#endif /* cef_message_router_capi_h */

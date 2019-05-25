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

// The below classes implement support for routing aynchronous messages between
// JavaScript running in the renderer process and C++ running in the browser
// process. An application interacts with the router by passing it data from
// standard CEF C++ callbacks (OnBeforeBrowse, OnProcessMessageRecieved,
// OnContextCreated, etc). The renderer-side router supports generic JavaScript
// callback registration and execution while the browser-side router supports
// application-specific logic via one or more application-provided Handler
// instances.
//
// The renderer-side router implementation exposes a query function and a cancel
// function via the JavaScript 'window' object:
//
//    // Create and send a new query.
//    var request_id = window.cefQuery({
//        request: 'my_request',
//        persistent: false,
//        onSuccess: function(response) {},
//        onFailure: function(error_code, error_message) {}
//    });
//
//    // Optionally cancel the query.
//    window.cefQueryCancel(request_id);
//
// When |window.cefQuery| is executed the request is sent asynchronously to one
// or more C++ Handler objects registered in the browser process. Each C++
// Handler can choose to either handle or ignore the query in the
// Handler::OnQuery callback. If a Handler chooses to handle the query then it
// should execute Callback::Success when a response is available or
// Callback::Failure if an error occurs. This will result in asynchronous
// execution of the associated JavaScript callback in the renderer process. Any
// queries unhandled by C++ code in the browser process will be automatically
// canceled and the associated JavaScript onFailure callback will be executed
// with an error code of -1.
//
// Queries can be either persistent or non-persistent. If the query is
// persistent than the callbacks will remain registered until one of the
// following conditions are met:
//
// A. The query is canceled in JavaScript using the |window.cefQueryCancel|
//    function.
// B. The query is canceled in C++ code using the Callback::Failure function.
// C. The context associated with the query is released due to browser
//    destruction, navigation or renderer process termination.
//
// If the query is non-persistent then the registration will be removed after
// the JavaScript callback is executed a single time. If a query is canceled for
// a reason other than Callback::Failure being executed then the associated
// Handler's OnQueryCanceled method will be called.
//
// Some possible usage patterns include:
//
// One-time Request. Use a non-persistent query to send a JavaScript request.
//    The Handler evaluates the request and returns the response. The query is
//    then discarded.
//
// Broadcast. Use a persistent query to register as a JavaScript broadcast
//    receiver. The Handler keeps track of all registered Callbacks and executes
//    them sequentially to deliver the broadcast message.
//
// Subscription. Use a persistent query to register as a JavaScript subscription
//    receiver. The Handler initiates the subscription feed on the first request
//    and delivers responses to all registered subscribers as they become
//    available. The Handler cancels the subscription feed when there are no
//    longer any registered JavaScript receivers.
//
// Message routing occurs on a per-browser and per-context basis. Consequently,
// additional application logic can be applied by restricting which browser or
// context instances are passed into the router. If you choose to use this
// approach do so cautiously. In order for the router to function correctly any
// browser or context instance passed into a single router callback must then
// be passed into all router callbacks.
//
// There is generally no need to have multiple renderer-side routers unless you
// wish to have multiple bindings with different JavaScript function names. It
// can be useful to have multiple browser-side routers with different client-
// provided Handler instances when implementing different behaviors on a per-
// browser basis.
//
// This implementation places no formatting restrictions on payload content.
// An application may choose to exchange anything from simple formatted
// strings to serialized XML or JSON data.
//
//
// EXAMPLE USAGE
//
// 1. Define the router configuration. You can optionally specify settings
//    like the JavaScript function names. The configuration must be the same in
//    both the browser and renderer processes. If using multiple routers in the
//    same application make sure to specify unique function names for each
//    router configuration.
//
//    // Example config object showing the default values.
//    CefMessageRouterConfig config;
//    config.js_query_function = "cefQuery";
//    config.js_cancel_function = "cefQueryCancel";
//
// 2. Create an instance of CefMessageRouterBrowserSide in the browser process.
//    You might choose to make it a member of your CefClient implementation,
//    for example.
//
//    browser_side_router_ = CefMessageRouterBrowserSide::Create(config);
//
// 3. Register one or more Handlers. The Handler instances must either outlive
//    the router or be removed from the router before they're deleted.
//
//    browser_side_router_->AddHandler(my_handler);
//
// 4. Call all required CefMessageRouterBrowserSide methods from other callbacks
//    in your CefClient implementation (OnBeforeClose, etc). See the
//    CefMessageRouterBrowserSide class documentation for the complete list of
//    methods.
//
// 5. Create an instance of CefMessageRouterRendererSide in the renderer
// process.
//    You might choose to make it a member of your CefApp implementation, for
//    example.
//
//    renderer_side_router_ = CefMessageRouterRendererSide::Create(config);
//
// 6. Call all required CefMessageRouterRendererSide methods from other
//    callbacks in your CefRenderProcessHandler implementation
//    (OnContextCreated, etc). See the CefMessageRouterRendererSide class
//    documentation for the complete list of methods.
//
// 7. Execute the query function from JavaScript code.
//
//    window.cefQuery({request: 'my_request',
//                     persistent: false,
//                     onSuccess: function(response) { print(response); },
//                     onFailure: function(error_code, error_message) {} });
//
// 8. Handle the query in your Handler::OnQuery implementation and execute the
//    appropriate callback either immediately or asynchronously.
//
//    void MyHandler::OnQuery(int64 query_id,
//                            CefRefPtr<CefBrowser> browser,
//                            CefRefPtr<CefFrame> frame,
//                            const CefString& request,
//                            bool persistent,
//                            CefRefPtr<Callback> callback) {
//      if (request == "my_request") {
//        callback->Continue("my_response");
//        return true;
//      }
//      return false;  // Not handled.
//    }
//
// 9. Notice that the onSuccess callback is executed in JavaScript.

///
// Used to configure the query router. The same values must be passed to both
// CefMessageRouterBrowserSide and CefMessageRouterRendererSide. If using
// multiple router pairs make sure to choose values that do not conflict.
///
typedef struct _cef_message_router_config_t {
    // Name of the JavaScript function that will be added to the 'window' object
    // for sending a query. The default value is "cefQuery".
    cef_string_t js_query_function;

    // Name of the JavaScript function that will be added to the 'window' object
    // for canceling a pending query. The default value is "cefQueryCancel".
    cef_string_t js_cancel_function;
} cef_message_router_config_t;

///
// Callback associated with a single pending asynchronous query. Execute the
// Success or Failure method to send an asynchronous response to the
// associated JavaScript handler. It is a runtime error to destroy a Callback
// object associated with an uncanceled query without first executing one of
// the callback methods. The methods of this class may be called on any
// browser process thread.
///
typedef struct _cef_message_router_browser_side_callback_t {
    ///
    // Base structure.
    ///
    cef_base_ref_counted_t base;

    ///
    // Notify the associated JavaScript onSuccess callback that the query has
    // completed successfully with the specified |response|.
    ///
    void(*success)(struct _cef_message_router_browser_side_callback_t* self,
                   const cef_string_t* response);
    
    ///
    // Notify the associated JavaScript onFailure callback that the query has
    // failed with the specified |error_code| and |error_message|.
    ///
    void(*failure)(struct _cef_message_router_browser_side_callback_t* self,
                   int error_code,
                   const cef_string_t* error_message);
} cef_message_router_browser_side_callback_t;

///
// Implement this interface to handle queries. All methods will be executed on
// the browser process UI thread.
///
typedef struct _cef_message_router_browser_side_handler_t {
    ///
    // Base structure.
    ///
    cef_base_ref_counted_t base;

    ///
    // Executed when a new query is received. |query_id| uniquely identifies the
    // query for the life span of the router. Return true to handle the query
    // or false to propagate the query to other registered handlers, if any. If
    // no handlers return true from this method then the query will be
    // automatically canceled with an error code of -1 delivered to the
    // JavaScript onFailure callback. If this method returns true then a
    // Callback method must be executed either in this method or asynchronously
    // to complete the query.
    ///
    int(*on_query)(struct _cef_message_router_browser_side_handler_t* self,
                   struct _cef_browser_t* browser,
                   struct _cef_frame_t* frame,
                   int64 query_id,
                   const cef_string_t* request,
                   int persistent,
                   struct _cef_message_router_browser_side_callback_t* callback);

    ///
    // Executed when a query has been canceled either explicitly using the
    // JavaScript cancel function or implicitly due to browser destruction,
    // navigation or renderer process termination. It will only be called for
    // the single handler that returned true from OnQuery for the same
    // |query_id|. No references to the associated Callback object should be
    // kept after this method is called, nor should any Callback methods be
    // executed.
    ///
    void(*on_query_canceled)(struct _cef_message_router_browser_side_handler_t* self,
                             struct _cef_browser_t* browser,
                             struct _cef_frame_t* frame,
                             int64 query_id);
} cef_message_router_browser_side_handler_t;

///
// Implements the browser side of query routing. The methods of this class may
// be called on any browser process thread unless otherwise indicated.
///
typedef struct _cef_message_router_browser_side_t {
    ///
    // Base structure.
    ///
    cef_base_ref_counted_t base;

    ///
    // Add a new query handler. If |first| is true it will be added as the first
    // handler, otherwise it will be added as the last handler. Returns true if
    // the handler is added successfully or false if the handler has already been
    // added. Must be called on the browser process UI thread. The Handler object
    // must either outlive the router or be removed before deletion.
    ///
    int(*add_handler)(struct _cef_message_router_browser_side_t* self,
                      struct _cef_message_router_browser_side_handler_t* handler,
                      int first);

    ///
    // Remove an existing query handler. Any pending queries associated with the
    // handler will be canceled. Handler::OnQueryCanceled will be called and the
    // associated JavaScript onFailure callback will be executed with an error
    // code of -1. Returns true if the handler is removed successfully or false
    // if the handler is not found. Must be called on the browser process UI
    // thread.
    ///
    int(*remove_handler)(struct _cef_message_router_browser_side_t* self,
                         struct _cef_message_router_browser_side_handler_t* handler);

    ///
    // Cancel all pending queries associated with either |browser| or |handler|.
    // If both |browser| and |handler| are NULL all pending queries will be
    // canceled. Handler::OnQueryCanceled will be called and the associated
    // JavaScript onFailure callback will be executed in all cases with an error
    // code of -1.
    ///
    void(*cancel_pending)(struct _cef_message_router_browser_side_t* self,
                          struct _cef_browser_t* browser,
                          struct _cef_message_router_browser_side_handler_t* handler);

    ///
    // Returns the number of queries currently pending for the specified |browser|
    // and/or |handler|. Either or both values may be empty. Must be called on the
    // browser process UI thread.
    ///
    int(*get_pending_count)(struct _cef_message_router_browser_side_t* self,
                            struct _cef_browser_t* browser,
                            struct _cef_message_router_browser_side_handler_t* handler);

    // The below methods should be called from other CEF handlers. They must be
    // called exactly as documented for the router to function correctly.

    ///
    // Call from CefLifeSpanHandler::OnBeforeClose. Any pending queries associated
    // with |browser| will be canceled and Handler::OnQueryCanceled will be
    // called. No JavaScript callbacks will be executed since this indicates
    // destruction of the browser.
    ///
    void(*on_before_close)(struct _cef_message_router_browser_side_t* self,
                           struct _cef_browser_t* browser);

    ///
    // Call from CefRequestHandler::OnRenderProcessTerminated. Any pending queries
    // associated with |browser| will be canceled and Handler::OnQueryCanceled
    // will be called. No JavaScript callbacks will be executed since this
    // indicates destruction of the context.
    ///
    void(*on_render_process_terminated)(struct _cef_message_router_browser_side_t* self,
                                        struct _cef_browser_t* browser);

    ///
    // Call from CefRequestHandler::OnBeforeBrowse only if the navigation is
    // allowed to proceed. If |frame| is the main frame then any pending queries
    // associated with |browser| will be canceled and Handler::OnQueryCanceled
    // will be called. No JavaScript callbacks will be executed since this
    // indicates destruction of the context.
    ///
    void(*on_before_browse)(struct _cef_message_router_browser_side_t* self,
                            struct _cef_browser_t* browser,
                            struct _cef_frame_t* frame);

    ///
    // Call from CefClient::OnProcessMessageReceived. Returns true if the message
    // is handled by this router or false otherwise.
    ///
    int(*on_process_message_received)(struct _cef_message_router_browser_side_t* self,
                                      struct _cef_browser_t* browser,
                                      cef_process_id_t source_process,
                                      struct _cef_process_message_t* message);
} cef_message_router_browser_side_t;

///
// Create a new router with the specified configuration.
///
CEF_EXPORT cef_message_router_browser_side_t* cef_message_router_browser_side_create(const struct _cef_message_router_config_t* config);

///
// Implements the renderer side of query routing. The methods of this class must
// be called on the render process main thread.
///
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

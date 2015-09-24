//
//  SchemeHandlerFactory+Interop.g.swift
//  CEF.swift
//
//  This file was generated automatically from cef_scheme.h.
//

import Foundation

extension cef_scheme_handler_factory_t: CEFObject {}

typealias SchemeHandlerFactoryMarshaller = Marshaller<SchemeHandlerFactory, cef_scheme_handler_factory_t>

extension SchemeHandlerFactory {
    func toCEF() -> UnsafeMutablePointer<cef_scheme_handler_factory_t> {
        return SchemeHandlerFactoryMarshaller.pass(self)
    }
}

extension cef_scheme_handler_factory_t: CallbackMarshalling {
    mutating func marshalCallbacks() {
        create = SchemeHandlerFactory_create
    }
}

//
//  Closures.swift
//  EasyList
//
//  Created by Jackson  on 12/09/2022.
//

import Foundation

typealias VoidClosure = () -> Void
typealias Closure<T> = (T) -> Void
typealias ErrorClosure = (Error) -> ()

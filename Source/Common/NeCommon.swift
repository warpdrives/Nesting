//
//  NeCommon.swift
//  Nesting
//
//  Created by ShevaKuilin on 2019/5/21.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import Foundation

private let NE_FROM_MESSAGE = "[**From Nesting**]"
private let NE_ASSERT_CHILDCONTROLLERCOUNT_ERROR = "\(NE_FROM_MESSAGE) The nested viewController needs to contain at least two childControllers, you must have the value of childControllerCount at least greater than 1"

public enum NEAssertType: Int {
    /**
     * @abstract The count of childController is less than 2.
     */
    case childControllerCount
}

/**
 *  Assert
 *
 *  @param type     Type of assert.
 *  @param value    Generics that follow the <Comparable> protocol.
 *
 */
public func ne_assert<T: Comparable>(type: NEAssertType, value: T) {
    switch type {
    case .childControllerCount:
        let minValue: T = 1 as! T
        assert(value > minValue, NE_ASSERT_CHILDCONTROLLERCOUNT_ERROR)
    }
}

/** Format print output
 *
 *  @param message  Output text message. [e.g., "array.first"]
 *  @param file     The path to the file containing this symbol.
 *  @param method   Method name containing this symbol.
 *  @param line     The line number where the symbol appears.
 *
 */
public func ne_print<T>(_ message: T,
                        file: String = #file,
                        method: String = #function,
                        line: Int = #line) {
    #if DEBUG
    print("\n[\((file as NSString).lastPathComponent) \(method)] - [Line \(line)] - \(message)\n")
    #endif
}

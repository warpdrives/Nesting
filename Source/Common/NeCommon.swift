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
    case childControllerCount
}

/**
 *  Assert
 *
 *  @param type     Type of assert
 *  @param value    Generics that follow the <Comparable> protocol
 *
 */
public func ne_assert<T: Comparable>(type: NEAssertType, value: T) {
    switch type {
    case .childControllerCount:
        let minValue: T = 1 as! T
        assert(value > minValue, NE_ASSERT_CHILDCONTROLLERCOUNT_ERROR)
    }
}

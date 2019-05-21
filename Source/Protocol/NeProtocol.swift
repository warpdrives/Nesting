//
//  NeProtocol.swift
//  Nesting
//
//  Created by ShevaKuilin on 2019/5/21.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import UIKit

protocol CreatNested: class {
    /**
     *  Create a low-level container based on UIScrollView.
     *
     *  @param childControllerCount The Count of childControllers in the container.
     *
     */
    func ne_creatContainerScrollView(_ childControllerCount: Int)
}

extension CreatNested where Self : UIViewController {
    func ne_creatContainerScrollView(_ childControllerCount: Int) {
        ne_assert(type: .childControllerCount, value: childControllerCount)
        ne_creatNestedViewController(childControllerCount)
    }
}

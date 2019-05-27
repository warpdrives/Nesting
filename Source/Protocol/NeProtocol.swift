//
//  NeProtocol.swift
//  Nesting
//
//  Created by ShevaKuilin on 2019/5/21.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import UIKit

protocol CreatNested:class{
    /**
     *  Create a low-level container based on UIScrollView.
     *
     *  @param childControllerCount The Count of childControllers in the container.
     *
     */
    func ne_creatContainerScrollView(_ childControllerCount: Int)
    
    var ne_backgroundColor:UIColor {set get}
}

public class CreatNestedProtocolModel {
    
    var ne_backgroundColor:UIColor = UIColor.red
}

extension CreatNested where Self: UIViewController {
    
    func ne_creatContainerScrollView(_ childControllerCount: Int) {
        ne_creatNestedViewController(childControllerCount)
    }

    var ne_backgroundColor: UIColor {
        get {
            return self.ne_getCurrentConfig().ne_backgroundColor
        }
        set {
//class
            self.ne_getCurrentConfig().ne_backgroundColor = newValue
// struct
//            var config = self.ne_getCurrentConfig()
//            config.ne_backgroundColor = newValue
//            NeConfig.default.ne_nestedDict[self.ne_getCurrentVCAddressPointer()] = config
//            self.ne_getCurrentConfig().ne_backgroundColor = newValue
        }
    }

   
}

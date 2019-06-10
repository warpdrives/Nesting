//
//  NeConfig.swift
//  Example
//
//  Created by git burning on 2019/5/26.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import Foundation

class NeConfig {
    private init() {}
    static let `default` = NeConfig()
    
    /// key is vc address pointer
    var ne_nestedDict = [String:CreatNestedProtocolModel]()
}

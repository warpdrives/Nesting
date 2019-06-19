//
//  UEFALeagueCategoryView.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/14.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

@objc public protocol UEFALeagueCategoryViewDelagete {
    /// Click on the category title.
    ///
    /// - Parameter index:  The index of the category title being clicked.
    @objc optional func selectTitleItem(index: Int)
}

class UEFALeagueCategoryView: UIView {
    @objc weak public var delegate: UEFALeagueCategoryViewDelagete?

    private var titles: [String] = []
    private var containerScrollView: UIScrollView! 
    private var lineView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

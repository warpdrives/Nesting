//
//  NeExtension.swift
//  Nesting
//
//  Created by ShevaKuilin on 2019/5/20.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import UIKit

extension UIViewController {
    /// Creat a nested viewController
    public func ne_creatNestedViewController(_ subviewCount: Int) {
        guard subviewCount > 0 else { return }
        
        let scrollSize = CGSize(width: UIScreen.main.bounds.size.width, height:UIScreen.main.bounds.size.height)
        let scrollView = self.ne_scrollView
        scrollView.contentSize = CGSize(width: scrollSize.width * CGFloat(subviewCount), height: scrollSize.height)
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
    }
    
    /// Get scrollView
    private var ne_scrollView: UIScrollView {
        get {
            let scrollView = UIScrollView()
            scrollView.delegate = self as? UIScrollViewDelegate
            scrollView.backgroundColor = .orange
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollsToTop = false
            return scrollView
        }
    }
}

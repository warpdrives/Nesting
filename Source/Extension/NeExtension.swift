//
//  NeExtension.swift
//  Nesting
//
//  Created by ShevaKuilin on 2019/5/20.
//  Copyright © 2019 Warpdrives. All rights reserved.
//

import UIKit

extension UIViewController: CreatNested {
    
    /**
     *  Creat a nested viewController.
     *
     *  @param childControllerCount The Count of childControllers in the nestedViewController.
     *
     */
    func ne_creatNestedViewController(_ childControllerCount: Int){
        ne_assert(type: .childControllerCount, value: childControllerCount)
        
        let scrollSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        let scrollView = self.ne_scrollView
        scrollView.contentSize = CGSize(width: scrollSize.width * CGFloat(childControllerCount), height: scrollSize.height)
        scrollView.frame = self.view.frame
        self.view.addSubview(scrollView)
    }
    
    
   
}

private extension UIViewController {
    // Get scrollView
    private var ne_scrollView: UIScrollView {
        get {
            let scrollView = UIScrollView()
            scrollView.delegate = self as? UIScrollViewDelegate
            scrollView.backgroundColor = self.ne_backgroundColor
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false
            scrollView.scrollsToTop = false
            return scrollView
        }
    }
}

public extension UIViewController{
    
    // Get neConfig
    func ne_getCurrentConfig() -> CreatNestedProtocolModel {
        let address_pointer = self.ne_getCurrentVCAddressPointer()
        print(address_pointer)
        var ne_comment = NeConfig.default.ne_nestedDict[address_pointer]
        if ne_comment == nil {
            ne_comment = CreatNestedProtocolModel()
            NeConfig.default.ne_nestedDict[address_pointer] = ne_comment
        }
        return ne_comment!
    }
    
    //remove neConfig
    func ne_removeConfig() {
        let address_pointer = self.ne_getCurrentVCAddressPointer()
        NeConfig.default.ne_nestedDict.removeValue(forKey: address_pointer)
    }
    
    
    /// Get currentVC address pointer
    ///
    /// - Returns: address pointer String
    func ne_getCurrentVCAddressPointer () -> String {
        let address_pointer = "\(Unmanaged.passUnretained(self).toOpaque())"
        return address_pointer;
    }
}

//
//  ViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/5/20.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        initNestedViewController()
        setNavigationBar()
    }
}

private extension ViewController {
    private func initNestedViewController() {
        /// 1.Prepare your UI controls/components.
        ///
        
        /// Add your viewControllers that needs to be added to the nested viewController to the array.
        let childControllers = [PremierLeagueViewController(),
                                LaLigaViewController(),
                                LegaSerieAViewController(),
                                BundesLigaViewController(),
                                Ligue1ViewController()]
        /// Initialize your bannerView if existed.
        let bannerView = UEFAChampionsLeagueView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: UIScreen.main.bounds.size.width,
                                                               height: 150))
        /// Initialize your categoryView if existed.
        let categoryView = UEFALeagueCategoryView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: 44),
                                                  titles: ["PremierLeague", "LaLiga", "LegaSerieA", "BundesLiga", "Ligue1"])
        /// Set your categoryView's delegate if existed.
        /// - Note: If you set up a delegate, look at the code example from line 74 to line 84.
        categoryView.delegate = self
        /// Create a headerView to add your bannerView and categoryView.
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0,
                                  y: ne_navigationBarHeight,
                                  width: UIScreen.main.bounds.size.width,
                                  height: bannerView.frame.size.height + categoryView.frame.size.height)
        /// Add bannerView & categoryView to headerView.
        headerView.addSubview(bannerView)
        headerView.addSubview(categoryView)
        
        
        /// 2.Use Nesting
        ///
        
        /// Step 1: Set ne_categoryHeight.
        /// - Note: When your categoryView does NOT exist, you can ignore.
        headerView.ne_categoryHeight = categoryView.frame.size.height
        /// Step 2: Creat NestedViewController.
        /// - Note: ⌘ + Click [Jump to Definition] to learn more.
        self.ne_creatNestedContainer(childControllers, headerView) { (offset) in
            /// Step 3: Link with your categoryView if needed.
            categoryView.linkageCategoryTitle(offsetValue: offset.x)
        }
    }
    
    /// Insignificant code.
    private func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toNextVC))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

/// Your categoryView's delegate, here is just an example if needed.
extension ViewController: UEFALeagueCategoryViewDelagete {
    func selectTitleItem(index: Int) {
        /// - Note: Change the scroll offset of a nested view controller.
        ///
        /// - Parameter index:  The index of the childViewController or titleButton in the nested view controller.
        /// Or
        /// You can use the 'func linkageScrollView(offset: CGPoint, animated: Bool)'
        ne_linkageScrollView(index: index, animated: false)
    }
}

private extension ViewController {
    /// Insignificant code.
    @objc private func toNextVC() {
        let nextVC = NextViewController()
        self.show(nextVC, sender: nil)
    }
}

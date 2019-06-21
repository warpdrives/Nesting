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
    
    deinit {
//        NEMonitor.destroy()
//        self.ne_removeConfig()
    }
}

private extension ViewController {
    private func initNestedViewController() {
        /// Create a childControllers array.
        let childControllers = [PremierLeagueViewController(),
                                LaLigaViewController(),
                                LegaSerieAViewController(),
                                BundesLigaViewController(),
                                Ligue1ViewController()]
        /// Initialize bannerView.
        let bannerView = UEFAChampionsLeagueView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: UIScreen.main.bounds.size.width,
                                                               height: 150))
        /// Initialize categoryView.
        let categoryView = UEFALeagueCategoryView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: 44),
                                                  titles: ["PremierLeague", "LaLiga", "LegaSerieA", "BundesLiga", "Ligue1"])
        categoryView.delegate = self
        /// Creat headerView.
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: ne_navigationBarHeight, width: UIScreen.main.bounds.size.width, height: 194)
        /// Add bannerView & categoryView to headerView.
        headerView.addSubview(bannerView)
        headerView.addSubview(categoryView)
        /// Creat NestedViewController.
        self.ne_creatNestedContainer(childControllers, headerView) { (offset) in
            categoryView.linkageCategoryTitle(offsetValue: offset.x)
        }
    }
    
    private func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toNextVC))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

extension ViewController: UEFALeagueCategoryViewDelagete {
    func selectTitleItem(index: Int) {
        /// - Note: Change the scroll offset of a nested view controller.
        ///
        /// - Parameter index:  The index of the childViewController or titleButton in the nested view controller.
        /// Or
        /// You can use the 'func linkageScrollView(offset: CGPoint, animated: Bool)'
        linkageScrollView(index: index, animated: false)
    }
}

private extension ViewController {
    @objc private func toNextVC() {
        let nextVC = NextViewController()
        self.show(nextVC, sender: nil)
    }
}

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
        let childControllers = [PremierLeagueViewController(),
                                LaLigaViewController(),
                                LegaSerieAViewController(),
                                BundesLigaViewController(),
                                Ligue1ViewController()]
        let headerView = UEFAChampionsLeagueView(frame: CGRect(x: 0,
                                                               y: ne_navigationBarHeight,
                                                               width: UIScreen.main.bounds.size.width,
                                                               height: 150))
        self.ne_creatNestedContainer(childControllers, headerView)
    }
    
    private func setNavigationBar() {
        let rightBarButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(toNextVC))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
}

private extension ViewController {
    @objc private func toNextVC() {
        let nextVC = NextViewController()
        self.show(nextVC, sender: nil)
    }
}

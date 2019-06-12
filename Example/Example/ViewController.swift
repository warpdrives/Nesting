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
}

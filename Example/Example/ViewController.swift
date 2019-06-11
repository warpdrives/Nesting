//
//  ViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/5/20.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private var childControllers = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initChildControllers()
        initNestedViewController()
    }
}

private extension ViewController {
    private func initChildControllers() {
        childControllers = [PremierLeagueViewController(),
                            LaLigaViewController(),
                            LegaSerieAViewController(),
                            BundesLigaViewController(),
                            Ligue1ViewController()]
    }
    
    private func initNestedViewController() {
        self.ne_creatNestedContainer(childControllers, nil)
    }
}

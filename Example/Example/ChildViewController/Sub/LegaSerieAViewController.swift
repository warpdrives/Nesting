//
//  LegaSerieAViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class LegaSerieAViewController: LeagueViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

private extension LegaSerieAViewController {
    private func loadData() {
        updateTeam(["Milan",
                    "Inter Milan",
                    "Juventus",
                    "Roma",
                    "Lazio",
                    "Fiorentina",
                    "Napoli",
                    "Sampdoria",
                    "Torino",
                    "Atalanta"])
    }
}

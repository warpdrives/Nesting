//
//  LaLigaViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class LaLigaViewController: LeagueViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

private extension LaLigaViewController {
    private func loadData() {
        updateTeam(["Barcelona",
                    "Athletic Madrid",
                    "Real Madrid",
                    "Valencia",
                    "Sevilla",
                    "Athletic Bilbao",
                    "Real Betis",
                    "Getafe",
                    "Espanyol",
                    "Villarreal"])
    }
}

//
//  Ligue1ViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class Ligue1ViewController: LeagueViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

private extension Ligue1ViewController {
    private func loadData() {
        updateTeam(["Paris Saint-Germain",
                    "Olympique lyonnais",
                    "Marseille",
                    "Bordeaux",
                    "Monaco",
                    "Saint-Étienne",
                    "Montpellier",
                    "Nice",
                    "Toulouse",
                    "Lille"])
    }
}

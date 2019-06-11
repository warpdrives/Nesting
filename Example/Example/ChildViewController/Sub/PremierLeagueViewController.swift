//
//  PremierLeagueViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class PremierLeagueViewController: LeagueViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

private extension PremierLeagueViewController {
    private func loadData() {
        updateTeam(["Manchester City",
                    "Manchester United",
                    "Arsenal",
                    "Chelsea",
                    "Liverpool",
                    "Tottenham Hotspur",
                    "Everton",
                    "Newcastle United",
                    "Southampton",
                    "Leicester City"])
    }
}

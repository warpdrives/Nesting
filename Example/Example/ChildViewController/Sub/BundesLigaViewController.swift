//
//  BundesLigaViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class BundesLigaViewController: LeagueViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

private extension BundesLigaViewController {
    private func loadData() {
        updateTeam(["Bayern München",
                    "Schalke 04",
                    "Stuttgart",
                    "Werder Bremen",
                    "Dortmund",
                    "Mönchengladbach",
                    "Frankfurt",
                    "Wolfsburg",
                    "Leverkusen",
                    "Hannover 96",
                    "Bayern München",
                    "Schalke 04",
                    "Stuttgart",
                    "Werder Bremen",
                    "Dortmund",
                    "Mönchengladbach",
                    "Frankfurt",
                    "Wolfsburg",
                    "Leverkusen",
                    "Hannover 96",
                    "Bayern München",
                    "Schalke 04",
                    "Stuttgart",
                    "Werder Bremen",
                    "Dortmund",
                    "Mönchengladbach",
                    "Frankfurt",
                    "Wolfsburg",
                    "Leverkusen",
                    "Hannover 96"])
    }
}

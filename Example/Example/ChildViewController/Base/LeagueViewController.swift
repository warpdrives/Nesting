//
//  LeagueViewController.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/11.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class LeagueViewController: UIViewController {
    private var tableView: UITableView!
    private var teamNames = [String]()
    
    private let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    private let reuseIdentifier = "TeamNameCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initElement()
        registerCell()
    }
    
    /// Update tableView date
    public func updateTeam(_ date: [String]) {
        teamNames = date
        tableView.reloadData()
    }
}

private extension LeagueViewController {
    private func initElement() {
        tableView = UITableView()
        tableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    private func registerCell() {
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    }
}

extension LeagueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard teamNames.count > 0 && teamNames.count > indexPath.row else { return UITableViewCell() }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) else { return UITableViewCell() }
        cell.textLabel?.text = teamNames[indexPath.row]
        
        return cell
    }
}

extension LeagueViewController: UITableViewDelegate {}

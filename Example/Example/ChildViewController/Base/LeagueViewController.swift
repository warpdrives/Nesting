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
    private var refreshControl: UIRefreshControl!
    private var teamNames = [String]()
    
    private let screenSize = CGSize(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
    private let reuseIdentifier = "TeamCell"
    
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
        tableView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height - ne_navigationBarHeight)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        
        refreshControl = UIRefreshControl()
        refreshControl.tintColor = UIColor(red: 15/255.0, green: 46/255.0, blue: 86/255.0, alpha: 1.0)
        refreshControl.attributedTitle = NSAttributedString(string: "Loading")
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            /// - Note: Since it is just a simple example, nothing is written here.
        }
    }
    
    private func registerCell() {
        tableView.register(TeamCell.classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    }
}

private extension LeagueViewController {
    @objc private func refreshTableView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension LeagueViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teamNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard teamNames.count > 0 && teamNames.count > indexPath.row else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! TeamCell
        cell.updateTeamData(teamNames[indexPath.row])
        cell.selectionStyle = .none
        
        return cell
    }
}

extension LeagueViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

class TeamCell: UITableViewCell {
    private var teamIcon: UIImageView!
    private var teamName: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateTeamData(_ name: String) {
        teamIcon.image = UIImage(named: name)
        teamName.text = name
    }
}

private extension TeamCell {
    private func initElements() {
        teamIcon = UIImageView()
        teamIcon.frame = CGRect(x: 14, y: 5, width: 40, height: 40)
        teamIcon.contentMode = .scaleAspectFit
        self.contentView.addSubview(teamIcon)
        
        teamName = UILabel()
        teamName.font = textLabel?.font
        teamName.frame = CGRect(x: 64,
                                y: teamIcon.center.y - (teamName.font.lineHeight / 2),
                                width: UIScreen.main.bounds.size.width - 78,
                                height: teamName.font.lineHeight)
        self.contentView.addSubview(teamName)
    }
}

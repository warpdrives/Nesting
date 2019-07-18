//
//  NextViewController.swift
//  Example
//
//  Created by git burning on 2019/5/26.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
//        self.ne_backgroundColor = .orange;
//        self.ne_creatContainerScrollView(5) // Test: Creat scrollView
        // Do any additional setup after loading the view.
        initNestedViewController()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    private func initNestedViewController() {
        let childControllers = [PremierLeagueViewController(),
                                LaLigaViewController(),
                                LegaSerieAViewController(),
                                BundesLigaViewController(),
                                Ligue1ViewController()]
        let headerView = UEFAChampionsLeagueView(frame: CGRect(x: 0, y: ne_navigationBarHeight, width: UIScreen.main.bounds.size.width, height: 150))
//        self.ne_creatNestedContainer(childControllers, headerView)
        self.ne_creatNestedContainer(childControllers, headerView, callback: nil)
    }

    deinit {
//        NEMonitor.destroy()
//        self.ne_removeConfig()
        print("\(self.classForCoder) is released!")
    }
}

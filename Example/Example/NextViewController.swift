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
        self.view.backgroundColor = UIColor.white;
        self.ne_backgroundColor = UIColor.orange;
        self.ne_creatContainerScrollView(5) // Test: Creat scrollView
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    deinit {
        self.ne_removeConfig()
    }
}

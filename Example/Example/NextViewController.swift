//
//  NextViewController.swift
//  Example
//
//  Created by git burning on 2019/5/26.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class NextViewController: UIViewController {

    private var _mapTable = NSMapTable<NextViewController, AnyObject>(keyOptions: .weakMemory, valueOptions: .strongMemory)

    var mTempObj:BRTempdeinit?{
        get{
            var  tempObj = _mapTable.object(forKey: self) as?BRTempdeinit
            if tempObj == nil {
                tempObj = BRTempdeinit()
                _mapTable.setObject(tempObj!, forKey: self)
            }
            return tempObj!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white;
//        self.ne_backgroundColor = .orange;
//        self.ne_creatContainerScrollView(5) // Test: Creat scrollView
        // Do any additional setup after loading the view.
        initNestedViewController()
       
        print(self.mTempObj)
        
    }
    
    
    class BRTempdeinit: NSObject {
        
        deinit {
            print("BRTempdeinit 释放了")
        }
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
        ne_printmapMonitorTable()
        //´print("释放了")
        print(self.classForCoder)
//        NEMonitor.destroy()
//        self.ne_removeConfig()
    }
}

private extension NextViewController {
    private func initNestedViewController() {
        /// Create a childControllers array.
        let childControllers = [PremierLeagueViewController(),
                                LaLigaViewController(),
                                LegaSerieAViewController(),
                                BundesLigaViewController(),
                                Ligue1ViewController()]
        /// Initialize bannerView.
        let bannerView = UEFAChampionsLeagueView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: UIScreen.main.bounds.size.width,
                                                               height: 150))
        /// Initialize categoryView.
        let categoryView = UEFALeagueCategoryView(frame: CGRect(x: 0, y: 150, width: UIScreen.main.bounds.size.width, height: 44),
                                                  titles: ["PremierLeague", "LaLiga", "LegaSerieA", "BundesLiga", "Ligue1"])
        categoryView.delegate = self
        /// Creat headerView.
        let headerView = UIView()
        headerView.backgroundColor = .white
        headerView.frame = CGRect(x: 0, y: ne_navigationBarHeight, width: UIScreen.main.bounds.size.width, height: 194)
        /// Add bannerView & categoryView to headerView.
        headerView.addSubview(bannerView)
        headerView.addSubview(categoryView)
        /// Creat NestedViewController.
        self.ne_creatNestedContainer(childControllers, headerView) { (offset) in
            categoryView.linkageCategoryTitle(offsetValue: offset.x)
        }
    }

}

extension NextViewController: UEFALeagueCategoryViewDelagete {
    func selectTitleItem(index: Int) {
        /// - Note: Change the scroll offset of a nested view controller.
        ///
        /// - Parameter index:  The index of the childViewController or titleButton in the nested view controller.
        /// Or
        /// You can use the 'func linkageScrollView(offset: CGPoint, animated: Bool)'
        linkageScrollView(index: index, animated: false)
    }
}

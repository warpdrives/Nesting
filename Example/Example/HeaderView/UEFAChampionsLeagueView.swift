//
//  UEFAChampionsLeagueView.swift
//  Example
//
//  Created by ShevaKuilin on 2019/6/12.
//  Copyright © 2019 Warpdrives Team. All rights reserved.
//

import UIKit

class UEFAChampionsLeagueView: UIView {
    private var themeImageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension UEFAChampionsLeagueView {
    private func initElements() {
        self.backgroundColor = UIColor(red: 15/255.0, green: 46/255.0, blue: 86/255.0, alpha: 1.0)
        
        themeImageView = UIImageView()
        themeImageView.frame = CGRect(x: self.frame.size.width/2 - 40, y: 10, width: 80, height: 80)
        themeImageView.contentMode = .scaleAspectFit
        themeImageView.image = UIImage(named: "UEFAChampionsLeague")?.imageWithColor(color1: .white)
        self.addSubview(themeImageView)
        
        let teams = ["Real Madrid", "Milan", "Liverpool", "Bayern München", "Barcelona", "Inter Milan", "Manchester United", "Juventus"]
        for teamName in teams {
            let teamLogo = UIImage(named: teamName)
            let index: Int = teams.firstIndex(of: teamName) ?? 0
            let logoWidth: CGFloat = self.frame.size.width / CGFloat(teams.count)
            let logoView = UIImageView()
            logoView.frame = CGRect(x: CGFloat(index) * logoWidth, y: self.frame.size.height - logoWidth - 5, width: logoWidth, height: logoWidth)
            logoView.contentMode = .scaleAspectFit
            logoView.image = teamLogo
            self.addSubview(logoView)
        }
    }
}

private extension UIImage {
    func imageWithColor(color1: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        color1.setFill()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(CGBlendMode.normal)
        
        let rect = CGRect(origin: .zero, size: CGSize(width: self.size.width, height: self.size.height))
        context?.clip(to: rect, mask: self.cgImage!)
        context?.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage ?? UIImage()
    }
}

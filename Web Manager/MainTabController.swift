//
//  MainTabController.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 30/10/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit

class MainTabController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barStyle = UIBarStyle.Black
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
    }
}
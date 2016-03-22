//
//  MainNavigationController.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 30/10/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit

class MainNavigationController: UINavigationController, UIViewControllerTransitioningDelegate {
    override func viewDidLoad() {
        UINavigationBar.appearance().translucent = true
        self.navigationBar.barStyle = UIBarStyle.BlackTranslucent
    }
}
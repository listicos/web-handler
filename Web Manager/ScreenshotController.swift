//
//  ScreenshotController.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 02/11/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit

class ScreenshotController: UIViewController {
    
    @IBOutlet weak var screenshot: UIImageView!
    var image:UIImage!
    var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screenshot.image = image
    }
}
//
//  TutorialController.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 02/11/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit

class TutorialController: UIViewController {

    @IBOutlet weak var container: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    var views = [UIViewController]()
    var pages: Int = 3
    var pageViewController: UIPageViewController?
    var currentIndex = 0
    var pageImages: [UIImage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let safariImage = UIImage(named: "Safari")!
        let settingsImage = UIImage(named: "Settings")!
        let adsHandlerImage = UIImage(named: "AdsHandler")!
        pageImages = [settingsImage, safariImage, adsHandlerImage]
        
        for i in 0..<pages {
            if let vc = self.storyboard?.instantiateViewControllerWithIdentifier("ScreenshotController") as? ScreenshotController {
                vc.index = i
                vc.image = pageImages[i]
                views.append(vc)
            }
        }
        pageViewController = self.childViewControllers[0] as? UIPageViewController
        pageViewController!.delegate = self
        pageViewController!.dataSource = self
        pageViewController!.setViewControllers([views[0]], direction: .Forward, animated: true, completion: nil)
        pageControl.numberOfPages = pages
    }
    
    @IBAction func pageControlValueChanged(sender: UIPageControl) {
        if sender.currentPage > currentIndex {
            pageViewController!.setViewControllers([views[sender.currentPage]], direction: .Forward, animated: true, completion: nil)
        } else {
            pageViewController!.setViewControllers([views[sender.currentPage]], direction: .Reverse, animated: true, completion: nil)
        }
        currentIndex = sender.currentPage
    }
}

extension TutorialController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ScreenshotController
        
        let idx = vc.index + 1
        
        if idx < views.count {
            return views[idx]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        let vc = viewController as! ScreenshotController
        
        let idx = vc.index - 1
        if idx >= 0 {
            return views[idx]
        } else {
            return nil
        }
    }
    
    func pageViewController(pageViewController: UIPageViewController, willTransitionToViewControllers pendingViewControllers: [UIViewController]) {
        let vc = pendingViewControllers[0] as! ScreenshotController

        pageControl.currentPage = vc.index
        currentIndex = vc.index
    }
    
}
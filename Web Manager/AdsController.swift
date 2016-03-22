//
//  AdsController.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 30/10/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit
import SafariServices
import SwiftyUserDefaults
import BusyNavigationBar

class AdsController: UIViewController, UITableViewDelegate, UITableViewDataSource, MainCellDelegate {
    @IBOutlet weak var tableView: UITableView!
    let webHandler = WebHandler()
    
    var rows:[String] = [
        NSLocalizedString("Block Ads", comment: ""),
        NSLocalizedString("Block Trackers", comment: ""),
        NSLocalizedString("Block Facebook", comment: ""),
        NSLocalizedString("Block Twitter", comment: ""),
        NSLocalizedString("Block Images", comment: "")
    ]
    
    var rowDescription:[String] = [
        NSLocalizedString("Block major ad distribution channels.", comment: ""),
        NSLocalizedString("Block major trackers, increasing privacy.", comment: ""),
        NSLocalizedString("Block Facebook widgets, like comments, share, like, etc.", comment: ""),
        NSLocalizedString("Block Twitter widgets, like counter, follow, share, etc.", comment: ""),
        NSLocalizedString("Blocks most of the images of the websites.", comment: "")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func loader(){
        let options = BusyNavigationBarOptions()
        options.animationType = .Stripes
        options.color = UIColor.redColor()
        options.alpha = 0.4
        options.barWidth = 20
        options.gapWidth = 30
        options.speed = 1
        options.transparentMaskEnabled = false
        self.navigationController?.navigationBar.start(options)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if !Defaults.hasKey(.isFirstTime) || Defaults[.isFirstTime]{
            webHandler.build()
            SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.listicos.WebManager.Safari") { (error) -> Void in
                
            }
        }
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MainCell") as! MainCell
        let row = rows[indexPath.row]
        if indexPath.row == 0{
            cell.icon.image = UIImage(named: "ads")
            cell.enabled.setOn(Defaults[.ads], animated: true)
        }else if indexPath.row == 1{
            cell.icon.image = UIImage(named: "privacy")
            cell.enabled.setOn(Defaults[.privacy], animated: true)
        }else if indexPath.row == 2{
            cell.icon.image = UIImage(named: "facebook")
            cell.enabled.setOn(Defaults[.facebook], animated: true)
        }else if indexPath.row == 3{
            cell.icon.image = UIImage(named: "twitter")
            cell.enabled.setOn(Defaults[.twitter], animated: true)
        }else if indexPath.row == 4{
            cell.icon.image = UIImage(named: "image")
            cell.enabled.setOn(Defaults[.image], animated: true)
        }
        cell.titleText.text = row
        cell.descriptionText.text = rowDescription[indexPath.row]
        cell.cellDelegate = self
        return cell
    }
    
    func didChangeSwitchState(sender: MainCell, isOn: Bool) {
        let index = tableView.indexPathForCell(sender)!
        loader()
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            if index.row == 0{
                Defaults[.ads] = isOn
            }else if index.row == 1{
                Defaults[.privacy] = isOn
            }else if index.row == 2{
                Defaults[.facebook] = isOn
            }else if index.row == 3{
                Defaults[.twitter] = isOn
            }else if index.row == 4{
                Defaults[.image] = isOn
            }
            
            self.webHandler.build()
            SFContentBlockerManager.reloadContentBlockerWithIdentifier("com.listicos.WebManager.Safari") { (error) -> Void in
                dispatch_async(dispatch_get_main_queue()) {
                    self.navigationController?.navigationBar.stop()
                }
            }
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}
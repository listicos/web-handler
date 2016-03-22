//
//  MoreController.swift
//  AquaUp
//
//  Created by Ruben Velazquez Calva on 29/01/15.
//  Copyright (c) 2015 Ruben Velazquez. All rights reserved.
//

import Foundation
import MessageUI
import UIKit
import iRate

class MoreController:UIViewController, UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate {
    var cellIdentificator = "Cell"
    
    @IBOutlet weak var tableView: UITableView!
    
    var data:[String] = [
        NSLocalizedString("Share",comment:""),
        NSLocalizedString("Rate it",comment:""),
        NSLocalizedString("Contact us",comment:""),
        NSLocalizedString("Version",comment:"")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.topItem?.title = NSLocalizedString("More",comment:"")
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell_ : UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: cellIdentificator)
        cell_.backgroundColor = UIColor.clearColor()

        cell_.textLabel?.textColor = UIColor.whiteColor()
        cell_.textLabel?.font = UIFont(name: "HelveticaNeue-CondensedBold", size: 19)
        cell_.textLabel?.text = data[indexPath.row]
        
        cell_.detailTextLabel?.textColor = UIColor.whiteColor()
        cell_.detailTextLabel?.font = UIFont(name: "HelveticaNeue-LightItalic", size: 16)
        
        switch indexPath.row{
        case 0:
            cell_.detailTextLabel?.text = NSLocalizedString("Share with your family and friends", comment: "")
            break
        case 1:
            cell_.detailTextLabel?.text = NSLocalizedString("Your review is very important to us", comment: "")
            break
        case 2:
            cell_.detailTextLabel?.text = NSLocalizedString("Send us your feedback", comment: "")
            break
        case 3:
            if let text = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
                cell_.detailTextLabel?.text = text
            }
            break
        default:
            break
        }
        
        return cell_
    }
    
    func configuredMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        mailComposerVC.setToRecipients(["listico@me.com"])
        mailComposerVC.setSubject(NSLocalizedString("Contact us", comment: ""))
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let alertController = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check e-mail configuration and try again.", preferredStyle: .Alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            
        }
        alertController.addAction(OKAction)
        self.presentViewController(alertController, animated: true) {
            
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch indexPath.row{
        case 0:
            let cell = tableView.cellForRowAtIndexPath(indexPath)!
            share(sharingText: NSLocalizedString("Hi, I want to share a great app.", comment:"")+" https://goo.gl/AbJJw8", sharingURL: NSURL(string: "https://goo.gl/AbJJw8")!, view: self, sender: cell.viewForFirstBaselineLayout, sharingImage: nil)
            break
        case 1:
            iRate.sharedInstance().promptForRating()
            break
        case 2:
            let mailComposeViewController = configuredMailComposeViewController()
            if MFMailComposeViewController.canSendMail() {
                self.presentViewController(mailComposeViewController, animated: true, completion: nil)
            } else {
                self.showSendMailErrorAlert()
            }
            break
        default:
            break
            
        }
    }
    
    func share(sharingText sharingText: String?, sharingURL: NSURL?, view:UIViewController, sender:UIView, sharingImage: UIImage?) {
        var sharingItems = [AnyObject]()
        
        if let text = sharingText {
            sharingItems.append(text)
        }
        if let image = sharingImage {
            sharingItems.append(image)
        }
        if let url = sharingURL {
            sharingItems.append(url)
        }
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            activityViewController.popoverPresentationController?.sourceView = sender
        }
        
        view.presentViewController(activityViewController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
}
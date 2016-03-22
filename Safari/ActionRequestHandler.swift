//
//  ActionRequestHandler.swift
//  Safari
//
//  Created by Ruben Velazquez Calva on 03/11/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionRequestHandler: NSObject, NSExtensionRequestHandling {

    func beginRequestWithExtensionContext(context: NSExtensionContext) {
        let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.listicos.WebManager")
        let sharedContainerPathLocation = groupUrl?.path
        
        let filePath = sharedContainerPathLocation! + "/baseList.json"
        let fileUrl = NSURL(fileURLWithPath: filePath)
        
        let attachment = NSItemProvider(contentsOfURL: fileUrl)!
        
        let item = NSExtensionItem()
        item.attachments = [attachment]
        
        context.completeRequestReturningItems([item], completionHandler: nil)
    }
    
}

//
//  WebHandle.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 02/11/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import SwiftyJSON
import SwiftyUserDefaults

public class WebHandler:NSObject {
    public func getJSON(name:String) -> [JSON]{
        var jsonResult:[JSON] = []
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "json"){
            let data = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let base = JSON(data: data)
            jsonResult = base.array!
        }
        return jsonResult
    }
    
    public func build(){
        var jsonResult:[JSON] = getJSON("Base")
        
        if Defaults[.facebook]{
            jsonResult += getJSON("Facebook")
        }
        if Defaults[.ads]{
            jsonResult += getJSON("Ads")
        }
        if Defaults[.image]{
            jsonResult += getJSON("Image")
        }
        if Defaults[.privacy]{
            jsonResult += getJSON("Privacy")
        }
        if Defaults[.twitter]{
            jsonResult += getJSON("Twitter")
        }
        
        do{
            let data = try JSON(jsonResult).rawData()
            let fileManager = NSFileManager()
            let groupUrl = NSFileManager.defaultManager().containerURLForSecurityApplicationGroupIdentifier("group.com.listicos.WebManager")
            
            let sharedContainerPathLocation = groupUrl?.path
            
            let baseListPath = sharedContainerPathLocation! + "/baseList.json"
            if !fileManager.fileExistsAtPath(baseListPath) {
                fileManager.createFileAtPath(baseListPath, contents: data, attributes: nil)
            } else {
                data.writeToURL(NSURL(fileURLWithPath: baseListPath), atomically: true)
            }
        }catch{

        }
    }
}
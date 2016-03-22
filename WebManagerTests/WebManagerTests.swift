//
//  WebManagerTests.swift
//  WebManagerTests
//
//  Created by Ruben Velazquez Calva on 3/21/16.
//  Copyright © 2016 Listicos. All rights reserved.
//

import XCTest
import SwiftyUserDefaults

class WebManagerTests: XCTestCase {
    let webHandler = WebHandler()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFacebook() {
        XCTAssert(webHandler.getJSON("Facebook").count > 0, "Facebook does not exist")
    }
    
    func testTwitter() {
        XCTAssert(webHandler.getJSON("Twitter").count > 0, "Twitter does not exist")
    }
    
    func testAds() {
        XCTAssert(webHandler.getJSON("Ads").count > 0, "Ads does not exist")
    }
    
    func testImage() {
        XCTAssert(webHandler.getJSON("Image").count > 0, "Image does not exist")
    }
    
    func testPrivacy() {
        XCTAssert(webHandler.getJSON("Privacy").count > 0, "Privacy does not exist")
    }
    
    func testPerformanceFull() {
        Defaults[.ads] = true
        Defaults[.facebook] = true
        Defaults[.twitter] = true
        Defaults[.privacy] = true
        Defaults[.image] = true
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
    func testPerformanceFacebook() {
        Defaults[.ads] = false
        Defaults[.facebook] = true
        Defaults[.twitter] = false
        Defaults[.privacy] = false
        Defaults[.image] = false
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
    func testPerformanceTwitter() {
        Defaults[.ads] = false
        Defaults[.facebook] = false
        Defaults[.twitter] = true
        Defaults[.privacy] = false
        Defaults[.image] = false
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
    func testPerformanceAds() {
        Defaults[.ads] = true
        Defaults[.facebook] = false
        Defaults[.twitter] = false
        Defaults[.privacy] = false
        Defaults[.image] = false
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
    func testPerformanceImage() {
        Defaults[.ads] = false
        Defaults[.facebook] = false
        Defaults[.twitter] = false
        Defaults[.privacy] = false
        Defaults[.image] = true
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
    func testPerformancePrivacy() {
        Defaults[.ads] = false
        Defaults[.facebook] = false
        Defaults[.twitter] = false
        Defaults[.privacy] = true
        Defaults[.image] = false
        
        self.measureBlock {
            self.webHandler.build()
        }
    }
    
}

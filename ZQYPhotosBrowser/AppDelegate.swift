//
//  AppDelegate.swift
//  ZQYPhotos Browser
//
//  Created by dcj on 16/5/10.
//  Copyright © 2016年 YQ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let view:ViewController = ViewController()
        
        let niv = UINavigationController(rootViewController :view)
        
        window?.rootViewController = niv
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        
        
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        
        
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        
        
    }
    
    func applicationWillTerminate(application: UIApplication) {
        
    }
    
    
}


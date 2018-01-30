//
//  AppDelegate.swift
//  Todoey
//
//  Created by Forrest Anderson on 1/29/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    print("Application did finish launching with options")
    
    // Code for determining the path to our User Defaults file:
    print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    print("Application will Resign Active")
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    print("Application did enter background")
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    print("Application will enter foreground")
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    print("Application did become active")
  }

  func applicationWillTerminate(_ application: UIApplication) {
    print("Application will terminate")
  }


}


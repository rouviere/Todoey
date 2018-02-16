//
//  AppDelegate.swift
//  CoreDataTest
//
//  Created by Forrest Anderson on 1/30/18.
//  Copyright © 2018 Rouviere Media. All rights reserved.
//

import UIKit
import RealmSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // print(Realm.Configuration.defaultConfiguration.fileURL)
    
    do {
      _ = try Realm()  // the underscore is a stand in for let realm
    } catch {
      print("Error initializing new realm \(error)")
    }
  
    return true
  }  

  
 }

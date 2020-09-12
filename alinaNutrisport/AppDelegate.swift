//
//  AppDelegate.swift
//  alinaNutrisport
//
//  Created by Brandon Gonzalez on 18/03/20.
//  Copyright © 2020 Easycode. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarDoneBarButtonItemText = "Listo"
        UserDefaults.standard.set(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Enterede Background")
        UserDefaults.standard.set(true, forKey: "firstTimer")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Terminating app")
        UserDefaults.standard.set(true, forKey: "firstTimer")
    }
    
}


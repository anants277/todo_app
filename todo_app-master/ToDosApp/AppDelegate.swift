//
//  AppDelegate.swift
//  ToDosApp
//
//  Created by Creo Server on 20/12/19.
//  Copyright © 2019 Creo Server. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        // Override point for customization after application launch.
        
        //setting up window
        window = UIWindow(frame: UIScreen.main.bounds)
        //to show the current window and position it in front of all other windows at the same level or lower
        window?.makeKeyAndVisible()
        
        let atdtvc = AllToDosTableViewController(persistenceManager: PersistenceManager.shared)
//        let tvc = TableViewController(persistenceManager: PersistenceManager.shared)
//        window?.rootViewController = UINavigationController(rootViewController: tvc)
        window?.rootViewController = UINavigationController(rootViewController: atdtvc)
        atdtvc.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9210278988, green: 0.8613929152, blue: 0.5923710465, alpha: 1)
        return true
    }

    

}


//
//  AppDelegate.swift
//  testOMG
//
//  Created by Dulin Gleb on 4.3.24..
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow()
        let layout = UICollectionViewFlowLayout()
        window.rootViewController = ViewController(collectionViewLayout: layout)
        window.makeKeyAndVisible()
        
        self.window = window
        
        return true
    }
}


//
//  AppDelegate.swift
//  MovieDB Test Coppel
//
//  Created by Abraham Escamilla Pinelo on 11/02/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        let loginStatus = UserDefaults.getLoginStatus()
//        
//        if loginStatus {
//            //If the user is login send to Main
//            let mainVC = MainViewController()
//            let navVC = UINavigationController(rootViewController: mainVC)
//            navVC.navigationBar.prefersLargeTitles = true
//            
//            UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromLeft) {
//                window.rootViewController = navVC
//                window.makeKeyAndVisible()
//            }
//            
//        } else {
//            //User not login. Send to Login
//            window.rootViewController = LoginViewController()
//            window.makeKeyAndVisible()
//        }
        

        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


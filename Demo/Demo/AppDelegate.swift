//
//  AppDelegate.swift
//  SplashWindow-Example
//
//  Created by Hao Zheng on 4/30/17.
//  Copyright © 2017 Hao Zheng. All rights reserved.
//

import UIKit
import SplashWindow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var splashWindow: SplashWindow = {
        let identifier = "LaunchScreen"
        let vc = UIStoryboard.named(identifier, vc: identifier)
        return SplashWindow.init(window: self.window!,
                                 launchViewController: vc,
                                 success: { authType in
            //auth succeeded closure
        }, logout: { _ in
            //return a loginVC after clicking logout
            return UIStoryboard.named("Login", vc: "LoginViewController")
        })
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let initialVC = UINavigationController(rootViewController: AuthFlowController().authSettingVC)
        /*
         Use your logic to determine whether your app is loggedIn
         initialVC can be any of your viewController, but must make sure if it's loggedIn when showing this VC
         */
        splashWindow.authenticateUser(isLoggedIn: true,
                                      initialVC: initialVC)
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
        splashWindow.showSplashView()
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        
        splashWindow.enteredBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
        /*
         Use your logic to determine whether your app is loggedIn
         
         If you already have some code here in didBecome such as refreshing
         network request or load data from database, if you want to bypass
         these actions before authentication, use self.splashWindow.isAuthenticating:
         
            splashWindow.authenticateUser(isLoggedIn: true)
            guard !splashWindow.isAuthenticating { return }
         */
        
        
        let rootIsLoginVC = window?.rootViewController is LoginViewController
        splashWindow.authenticateUser(isLoggedIn: !rootIsLoginVC)
    }
}


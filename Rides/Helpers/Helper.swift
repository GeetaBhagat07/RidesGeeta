//
//  SpotlexHelper.swift
//  Spotlex
//
//  Created by Mandeep Singh on 1/9/20.
//  Copyright © 2020 Mandeep Singh. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift


struct Helper {
    
    static var shared = Helper()

    
    func setUpApp() {
        
        UINavigationBar.appearance().barTintColor = AppColor.whiteColor
        UINavigationBar.appearance().tintColor = UIColor.white
        
        self.configureSDKS()
        self.rootViewAfterSession()
        
      
    }
    
 
    
    private func configureSDKS() {
        IQKeyboardManager.shared.enable = true
    }
    
    
    func rootViewAfterSession() {
        
        let homeStoryboard = UIStoryboard(name: Storyboards.main, bundle:nil)
        guard let navVC = homeStoryboard.instantiateViewController(withIdentifier: Identifiers.mainNavVC) as? UINavigationController else {
            return
        }
        
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        AppUser.shared.window?.rootViewController = navVC
        AppUser.shared.window?.makeKeyAndVisible()
    }

    func destroySession() {
        
        self.removeLocalValues()
        let mainStoryboard = UIStoryboard(name: Storyboards.main, bundle:nil)
        guard let navVC = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.mainNavVC) as? UINavigationController else {
            return
        }
        guard let homeVC = mainStoryboard.instantiateViewController(withIdentifier: Identifiers.welcomeVC) as? ViewController else {
            return
        }
        navVC.viewControllers = [homeVC]
        
        navVC.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navVC.isNavigationBarHidden = false
        AppUser.shared.window?.rootViewController = navVC
        AppUser.shared.window?.makeKeyAndVisible()
    }
    

    func setSession() {
        UserDefaults.standard.set(true, forKey: DefaultKeys.userToken)
        UserDefaults.standard.synchronize()
    }
    
    private func removeLocalValues() {
        UserDefaults.standard.set(false, forKey: DefaultKeys.userToken)
        UserDefaults.standard.synchronize()
        AppUser.defaults.removeObject(forKey: DefaultKeys.userToken)
        AppUser.defaults.removeObject(forKey: DefaultKeys.session)
    }
}



struct ScreenSize {
    static let screenWidth = UIScreen.main.bounds.size.width
    static let screenHeight = UIScreen.main.bounds.size.height
    static let screenMaxLength = max(ScreenSize.screenWidth, ScreenSize.screenHeight)
}

struct DeviceType {
    static let iPhoneXs = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength >= 812.0
    static let isIPhone12 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.screenMaxLength == 844.0

}

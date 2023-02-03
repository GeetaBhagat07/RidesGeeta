//
//  HelpingVC.swift
//  Sorsr
//
//  Created by user on 31/03/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation
import UIKit
import StoreKit
import SystemConfiguration


class HelpingVC: NSObject {
    
    //MARK:- Variables
    static let shared = HelpingVC()
    
    func delay(seconds:Double, completion: @escaping() -> Void ){
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            completion()
        }
    }
    
    func showAlert(message:String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: AppInfo.APP_NAME, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
                
            }
            alert.addAction(okAction)
            alert.show()
        }
    }
    
    func isInternetConnectionAvailable() -> Bool{
        let status = Reachability().connectionStatus()
        switch status {
        case .unknown, .offline:
            // Show alert if internet not available.
            self.showAlert(message:AlertMessage.lostInternet)
            return false
        default:
            return true
            
        }
    }
}

public extension UIAlertController {
    func show() {
        if #available(iOS 13.0, *) {
            if var topController = UIApplication.shared.keyWindow?.rootViewController  {
                while let presentedViewController = topController.presentedViewController {
                    topController = presentedViewController
                }
                topController.present(self, animated: true, completion: nil)
            }
        }else{
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1  // Swift 3-4: UIWindowLevelAlert + 1
            win.makeKeyAndVisible()
            vc.present(self, animated: true, completion: nil)
        }
    }
}


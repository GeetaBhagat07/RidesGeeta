//
//  DataManager.swift
//  Sorsr
//
//  Created by user on 10/04/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    //Current user's id
    var UserID:String{
        get{
            return UserDefaults.standard.value(forKey: "Userid") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "Userid")
        }
    }
    
    var AuthToken:String{
        get{
            return UserDefaults.standard.value(forKey: "AuthToken") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "AuthToken")
        }
    }
    
    var UserName:String{
        get{
            return UserDefaults.standard.value(forKey: "UserName") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "UserName")
        }
    }
    
    var UserEmail:String{
        get{
            return UserDefaults.standard.value(forKey: "UserEmail") as? String ?? ""
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "UserEmail")
        }
    }
    
    var HideCongratsPopUp:Bool{
        get{
            return UserDefaults.standard.value(forKey: "HideCongratsPopUp") as? Bool ?? false
        }
        set{
            UserDefaults.standard.setValue(newValue, forKey: "HideCongratsPopUp")
        }
    }
    
    
}

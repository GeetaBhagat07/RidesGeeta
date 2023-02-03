//
//  Constant.swift
//  iOSArchitecture
//
//  Created by Amit Shukla on 05/07/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit


typealias KeyValue  =  [String : Any]
typealias ResponseBlock = ((_ isSuccess: Bool, _ message: String) -> Void)

struct AppKeys {
    static let kGoogleClientID = "667053744720-0pi3l8gaf1bsnt4e0d0qmqp5s1b4658j.apps.googleusercontent.com"
    static let googleAdID = "ca-app-pub-3940256099942544/4411468910" //"ca-app-pub-4044559451793576/5425269923"
}

struct AppColor {
    static let backgroundColor       =     UIColor.init(named: "#2E2E39")
    static let yellowColor           =     UIColor.init(named: "#FCDA6A")
    static let lightYellowColor      =     UIColor.init(named: "#FFD300")
    static let whiteColor            =     UIColor.init(named: "#FFFFFF")
    static let grayColor             =     UIColor.init(named: "#707070")
    static let blueColor             =     UIColor.init(named: "#191434")
    static let darkBlueColor         =     UIColor.init(named: "#334698")
    static let newBlueColor          =     UIColor.init(named: "#384097")
    static let newPlaceholderColor   =     UIColor.init(named: "#2F1A55")
    static let greenColor            =     UIColor.init(named: "#41DAA8")
    static let grayNewColor          =     UIColor.init(named: "#9B9B9B")
    static let pinkColor             =     UIColor.init(named: "#E3226D")
    static let ClickBlueColor        =     UIColor.init(named: "#6E73B4")
    static let ClickYellowColor      =     UIColor.init(named: "#FEE335")
    static let DArkYellowColor       =     UIColor.init(named: "#FFB200")
    static let ErrorColor            =     UIColor.init(named: "#FF0000")
    static let goldenColor           =     UIColor.init(named: "#FFB404")
    static let lighGreenColor           =     UIColor.init(named: "#5BD701")
    static let lightPinkColor           =     UIColor.init(named: "#F3006D")
    static let orangeColor           =     UIColor.init(named: "#F45606")
}

struct AlertMessage {
    
    static let noInternetConnection = "No internet connection."
    static let sessionExpire = "Your session has been expired. Please try to login again!"
    
    static let invalidURL               = "Invalid server url"
    static let lostInternet             = "It seems you are offline, Please check your Internet connection."
    static let invalidEmail             = "Please enter a valid email address"
    static let invalidPassword          = "Oops, the password need to be between 6-24 characters."
    static let invalidPhoneNumber       = "Oops! That is an invalid number. Try again."
    static let emptyPhoneNumber         = "Please enter a valid phone number and try again."
    static let limitUsername            = "Oops, the username can't exceed 14 characters."
    static let minLimitUsername         = "Oops, the username must have min 8 characters."
    static let emptyUsername            = "Please enter username."
    static let noCameraAccess           = "Unable to access the Camera";
    static let noGalleryAccess          = "Unable to access the Gallery";
    static let noPhoto                  = "To enable access, go to Settings > Privacy > Photos and turn on Photos access for this app.";
    static let noCamera                 = "To enable access, go to Settings > Privacy > Camera and turn on Camera access for this app.";
    static let futureDate               = "Future date is not allowed."
    static let invalidDate              = "Please enter valid date."
    static let emptyDate                = "Please enter date."
    static let usernameExists           = "User with this username already exists."
    static let settingMsg               = "Notification Alert"
    static let locationMsg              = "Location Alert"
    
    static let enableNotification       = "Please Turn on the Notification to get update every time the Show Starts"
    static let locationAccess           = "MyApp needs access to your location. Turn on Location Services in your device settings."
    static let signOut                  = "Are you sure you want to logout?"

    static let emptyDescrptn             = "Please enter some text."

    static let somethingWentWrong  = "Something went Wrong"

}



struct DefaultKeys {

    static let session                  = "session"
    static let userToken                = "token"
    static let userid                   = "userID"
    static let pushToken                = "pushToken"
    static let Email                    = "email"
    static let Firstname                = "firstname"
    static let Lastname                 = "lastname"

    
}

enum LoginKeys : String {
    case Username
}

struct Storyboards {
    static let main            = "Main"
    
}

struct AppFont {
    static let MuseoSansCyrl_900 = "MuseoSansCyrl-900"

    
    static func MuseoSansCyrl_900(fontSize: CGFloat) -> UIFont {
        return UIFont(name:self.MuseoSansCyrl_900 , size: fontSize)!
    }
    

}

struct AppUser {
    static let defaults            =      UserDefaults.standard
    static let shared              =      UIApplication.shared.delegate as! AppDelegate
}

struct Identifiers {
    static let mainNavVC            = "mainNavigationVC"
    static let welcomeVC            = "ViewController"
    static let vehicleList             = "VehicleListVC"
    static let vehicleDetails          = "VehicleDetailsVC"
}


struct ConstantKeys {
    static let appName                  = "Rides"
    static let cameraMsg                = "Take new photo"
    static let galleryMsg               = "Choose from camera role"
    
    static let camera                   = "Camera"
    static let photo                    = "Photo"
    static let cancel                   = "Cancel"

    static let deviceType               = "iOS"
    static let DD                       = "DD"
    static let MM                       = "MM"
    static let YYYY                     = "YYYY"
    static let dateFormat               = "yyyy-mm-dd"
    static let textViewMaxHeight : CGFloat = 145
}


enum DateEnum : String {
    case edmYYYY = "E, d MMM yyyy HH:mm"
    case edmYY = "E, d MMM yyyy"
    case yyyyMMDD = "yyyy-MM-dd'T'HH:mm:ssZ" // 2020-06-03T10:05:00-07:00
    case HHmm = "yyyy-MM-dd'T'HH:mm" // 2020-06-03T10:05:00-07:00
    case yyyyMmDd = "yyyy-MM-dd"
    case mmmDyyy = "MMMM d, yyyy" //Nov 11, 2020
    case mmDDyyyy = "MM/DD/YYYY" //06/03/2005
}

struct WebServicesApi {
    static let listOfVehicles = "vehicle/random_vehicle"
    
}

struct BaseURL {
    static let base_url_dev = "https://random-data-api.com/api/"
}

struct AppInfo {
    static let APP_NAME = "Rides"
}



public var isBottom: Bool {
    if #available(iOS 11.0, *), let keyWindow = UIApplication.shared.keyWindow, keyWindow.safeAreaInsets.bottom > 0 {
        return true
    }
    return false
}

struct AppInputLengthConstraints {
    struct Minimum {
        static let username = 8
    }
    struct Maximum {
        static let username = 14
    }
}

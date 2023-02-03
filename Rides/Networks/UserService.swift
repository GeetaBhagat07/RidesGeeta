//
//  LoginAPIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//

import Foundation
import UIKit

protocol UserServiceProtocol {
    func doLogin(email: String, password: String, completion:@escaping (Result<Any>) -> Void)
    
}
public class UserService: APIService, UserServiceProtocol {
    func doLogin(email: String, password: String, completion: @escaping (Result<Any>) -> Void) {
        
    }
    
}



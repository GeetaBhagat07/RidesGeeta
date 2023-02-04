//
//  VehicleListVM.swift
//  Rides
//
//  Created by ShanuGeet on 2023-02-01.
//

import Foundation
import UIKit

class VehicleListVM: BaseViewModel {
    
    // MARK: Variables
    var userService: UserServiceProtocol
    var myVehicleList:[VehicleListBase] = []
    
    // MARK: Initialization
    // Putting dependency injection by paasing the service object in constructor and not giving the responsibility for the same
    init(userService: UserServiceProtocol) {
        self.userService = userService
    }
    
 
    
    //MARK:- Webservice
    func getMyVehicleList(size : String?,completion:@escaping()->()){
        APIManager.shared.myVehicleList(size: size) { (response) in
            
            self.myVehicleList = response
            self.myVehicleList = self.myVehicleList.sorted(by: { list1, list2 in
                return list1.vin?.uppercased() ?? "" < list2.vin?.uppercased() ?? ""
            })
            completion()
        }
    }

}

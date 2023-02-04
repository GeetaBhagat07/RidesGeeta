//
//  APIManager.swift
//  Sorsr
//
//  Created by user on 31/03/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation

class APIManager {
    static let shared = APIManager()
    let jsonDecoder = JSONDecoder()
    
    ///API to fetch the list of vehicles
    func myVehicleList(size : String?,completionHandler:@escaping(_ responseData:[VehicleListBase])->()){
        
        WebServices.shared.apiMethodWithoutParamAndBaseUrl(urlComponent:BaseURL.base_url_dev + WebServicesApi.listOfVehicles + (size ?? "1") , httpMethod: HttpMethods.get, authorizationRequired: false) { (responseData, responseError) in
            

            do {
                let responseModel = try self.jsonDecoder.decode([VehicleListBase].self, from: responseData!)
                completionHandler(responseModel)

            } catch {
                let responseModel = try? self.jsonDecoder.decode(MessageBase.self, from: responseData!)
                if responseModel != nil{
                    HelpingVC.shared.showAlert(message: responseModel?.message ?? AlertMessage.somethingWentWrong)
                }
                print(error.localizedDescription)
                print(String(describing: error))
                
            }
        }
        
        
    }
}


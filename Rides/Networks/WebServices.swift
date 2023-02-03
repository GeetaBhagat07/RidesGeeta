//
//  WebServices.swift
//  Sorsr
//
//  Created by user on 31/03/20.
//  Copyright © 2020 aulakh. All rights reserved.
//

import Foundation

class WebServices {
    
    static let shared = WebServices()
    
    /// API method without parameters
    func apiMethodWithoutParam(urlComponent:String,httpMethod:String,authorizationRequired:Bool?, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void){
        if HelpingVC.shared.isInternetConnectionAvailable(){
            let session = URLSession.shared
            let url = URL(string: BaseURL.base_url_dev + urlComponent)!
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if authorizationRequired!{
                request.setValue("Bearer " + DataManager.shared.AuthToken, forHTTPHeaderField: "Authorization")
            }
            let task = session.dataTask(with: request) { data, response, error in
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    completion(data,nil)
                    print(dataString)
                }
                
                if error != nil || data == nil {
                    
                    HelpingVC.shared.showAlert(message: error?.localizedDescription ?? "Server not responding")
                    print("Client error!")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
    }
    
    /// API method with parameters
    func apiMethodWithParameters(urlComponent:String,httpMethod:String,parameters:NSMutableDictionary,authorizationRequired:Bool?, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void){
        
        if HelpingVC.shared.isInternetConnectionAvailable(){
            
            let session = URLSession.shared
            let url = URL(string: BaseURL.base_url_dev + urlComponent)!
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            if authorizationRequired!{
                request.setValue("Bearer " + DataManager.shared.AuthToken, forHTTPHeaderField: "Authorization")
            }
            let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options:JSONSerialization.WritingOptions.prettyPrinted)
            
            let json = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)
            if let json = json {
                print(json)
            }
            request.httpBody = json!.data(using: String.Encoding.utf8.rawValue)
            
            let task = session.dataTask(with: request)  { data, response, error in
                
                //                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                //                    print("Server error!")
                //                    HelpingVC.shared.showAlert(message:Constants.Alert_Messages.somethingWentWrong)
                //                    return
                //                }
                if let response = response as? HTTPURLResponse,response.statusCode == 200{
                    if let data = data, let dataString = String(data: data, encoding: .utf8) {
                        completion(data,nil)
                        print(dataString)
                    }
                }else{
                    HelpingVC.shared.showAlert(message:error?.localizedDescription ?? AlertMessage.somethingWentWrong)
                    return
                }
                
                if error != nil || data == nil {
                    
                    HelpingVC.shared.showAlert(message: error?.localizedDescription ?? "Server not responding")
                    print("Client error!")
                    return
                }
                
                
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
    }
    
    
    func apiMethodWithoutParamAndBaseUrl(urlComponent:String, httpMethod:String, authorizationRequired:Bool?, completion:@escaping (_ data: Data?, _ error: NSError?) -> Void) {
        if HelpingVC.shared.isInternetConnectionAvailable(){
            let session = URLSession.shared
           // var queryURL = urlComponent.replacingOccurrences(of: " ", with: "%20")
           // queryURL = urlComponent.replacingOccurrences(of: " ", with: "+")
            let urlString = urlComponent.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)

            print("URL: \(urlString ?? "Nil")")
            let url = URL(string: urlString!)!
            var request = URLRequest(url: url)
            request.httpMethod = httpMethod
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if authorizationRequired!{
                request.setValue("JWT " +  ("UserSession.userToken" ?? ""), forHTTPHeaderField: "Authorization")
            }
            let task = session.dataTask(with: request) { data, response, error in
                
                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    completion(data,nil)
                    print(dataString)
                }
                
                if error != nil || data == nil {
                    
                    HelpingVC.shared.showAlert(message: error?.localizedDescription ?? "Server not responding")
                    print("Client error!")
                    return
                }
                
                guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                    print("Server error!")
                    return
                }
                
                guard let mime = response.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    return
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                    print(json)
                } catch {
                    print("JSON error: \(error.localizedDescription)")
                }
            }
            
            task.resume()
        }
    }
    
    /// Load Image from url
    func getDataForImage(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    
}

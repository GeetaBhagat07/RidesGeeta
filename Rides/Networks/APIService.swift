//
//  APIManager.swift
//  iOSArchitecture
//
//  Created by Amit on 23/02/18.
//  Copyright © 2018 smartData. All rights reserved.
//
import Foundation
import UIKit

public enum HttpMethod: String {
    case POST
    case GET
    case PUT
    case DELETE
    case PATCH
}

struct File {
    let name: String?
    let filename: String?
    let data: Data?
    init(name: String?, filename: String?, data: Data?) {
        self.name = name
        self.filename = filename
        self.data = data
    }
}

enum Result <T> {
    case success(T)
    case error(String)
    case customError(ErrorBase)

}

public struct Service {
     //We are creating a tuple for HTTP Method and Service URL to avoid the parameters confusion in functions
    typealias config = (method:HttpMethod, path:String, isHeader: Bool)
}

protocol ApiServiceProtocol {
    func startService<T: Decodable>(config: Service.config, parameters: [String: Any]?, files: [File]?, modelType: T.Type, completion: @escaping (Result<T?>) -> Void)
    func buildRequest(with method: HttpMethod, url: URL, parameters: [String: Any]?, files: [File]?) -> URLRequest
    func buildParams(parameters: [String: Any]) -> String
    func handleResponse<T: Decodable>(data: Data, response: URLResponse?, modelType: T.Type, completion: @escaping (Result<T?>) -> Void)
}

public class APIService: NSObject, ApiServiceProtocol {
    /// Start the Service
    /// - Parameter Config:We are defining the HTTP method and the server URL in a tuple
    /// - Parameter parameters: parameters which needs to be send on server while hitting the api
    /// - Parameter files: Multimedia Files which may contain images or videos to be uploaded to server.
    /// - Parameter modelType: Get response in Model after serialization the response from server
    /// - Parameter completion: Call back to update the ViewModel
    func startService<T: Decodable>(config: Service.config, parameters: [String: Any]?, files: [File]?, modelType: T.Type, completion: @escaping (Result<T?>) -> Void) {
        if !isInternetReachable() {
            completion(.error(AlertMessage.noInternetConnection))//lostInternet
            return
        }
        guard let url = URL(string: Config.baseURL + config.path) else { return completion(.error(AlertMessage.invalidURL)) }
        
        print("Request URL", url.absoluteString)
        print("Request Parameters", parameters ?? "")
        var request = self.buildRequest(with: config.method, url: url, parameters: parameters, files: files)
        if config.isHeader {
           // we are checking if header is allowed in the api's, then it would pass in the parameter.
           let headers = self.initializeHeaders()
           request.allHTTPHeaderFields = headers
        }
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return completion(.error(error!.localizedDescription)) }
            guard let data = data else { return completion(.error(error?.localizedDescription ?? "Data not found."))
            }
            self.handleResponse(data: data, response: response, modelType: modelType, completion: completion)
        }
        task.resume()
    }
    
    private func initializeHeaders() -> [String : String] {
       let headers = [
        Keys.auth: self.bearerToken
       ]
       return headers
    }
    
    private var bearerToken : String {

       return "Bearer "
    }
}

extension APIService {
    /// Building the request for Services
    /// - Parameter method: to indicate the desired action to be performed on Server.
    /// - Parameter url: Api URL
    /// - Parameter parameters: parameters which needs to send server along with the api
    /// - Parameter files: Multimedia Files which needs to send server along with the api
    func buildRequest(with method: HttpMethod, url: URL, parameters: [String: Any]?, files: [File]?) -> URLRequest {
        var request: URLRequest?
        switch method {
        case .GET:
            if let params = parameters, params.count > 0 {
                let queryUrl = url.appendingPathComponent("?"+buildParams(parameters: params))
                request = URLRequest(url: queryUrl)
            } else {
                request = URLRequest(url: url)
            }
            request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        case .POST, .PUT, .PATCH: break
            //request = self.buildRequestForMultiMedia(url, method: method, multimediaFiles: files, parameters: parameters)
        default:
            // write code for delete here
            break
        }
       
        request?.httpMethod = method.rawValue
        return request ?? URLRequest(url: url)
    }
    

    
    func buildParams(parameters: [String: Any]) -> String {
        var components: [(String, String)] = []
        for (key, value) in parameters {
            components += self.queryComponents(key, value)
        }
        return (components.map {"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    func queryComponents(_ key: String, _ value: Any) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: Any] {
            for (nestedKey, value) in dictionary {
                components += queryComponents("\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents("\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        return components
    }
    func escape(string: String) -> String {
        if let encodedString = string.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) {
            return encodedString
        }
        return ""
    }
}

extension APIService {
    func handleResponse<T: Decodable>(data: Data, response: URLResponse?, modelType: T.Type, completion: @escaping (Result<T?>) -> Void) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
        //Update this if your server update HttpResponse code in case of error
        let jsonResponse = NSString(data: data, encoding: String.Encoding.ascii.rawValue)
        print("Server Resonse", jsonResponse ?? "")
        switch statusCode {
        case 200 ... 299:
             do {
              let genericModel = try JSONDecoder().decode(modelType, from: data)
              completion(.success(genericModel))
            } catch let error {
              completion(.error(error.localizedDescription))
            }
        case 400 ... 499:
            if statusCode == 401 {
                completion(.error(""))

                DispatchQueue.main.async {
                    // user token has been expired
                    let configAlert: AlertUI = ("", AlertMessage.sessionExpire)
                    
                    UIAlertController.showAlert(configAlert, sender: self, actions: AlertAction.Okk) { (onResponse) in
                        Helper.shared.destroySession()
                    }
                }
            } else {
                do {
                    let genericModel = try JSONDecoder().decode(ErrorBase.self, from: data)
                    completion(.customError(genericModel))
                } catch let error {
                    completion(.error(error.localizedDescription))
                }
            }
        default:
            completion(.error("Error message"))
        }
    }
}

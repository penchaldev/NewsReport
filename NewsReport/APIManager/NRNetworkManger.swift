//
//  WRNetworkManger.swift
//  NewsReport
//
//  Created by Penchal on 15/08/20.
//  Copyright © 2020 senix.com. All rights reserved.
//

import Foundation
import UIKit


class WRNetworkManager: NSObject,URLSessionDelegate {

    static let sharedInstance = WRNetworkManager()
    
    // Configuration
    static var task: URLSessionTask?
    static let session: URLSession = {
        let config = URLSessionConfiguration.default
        if #available(iOS 11.0, *) {
            config.waitsForConnectivity = true
            config.timeoutIntervalForRequest = 60.0
        } else {
            // Fallback on earlier versions
        }
        return URLSession(configuration: config)
    }()
    
 //MARK: - Get SERVICE CALL -
    
static func getServiceCall(completionHandler:@escaping(NewsModel) -> Void){
    
    if !Reachability.isConnectedToNetwork() {
        DispatchQueue.main.async {
            let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow })
            keyWindow?.rootViewController?.showAlert(message: keyNetConnect, title: keyError)
        }
        return
    }
    
    DispatchQueue.global(qos:.userInitiated).async {
        let urlString = "http://newsapi.org/v2/everything?q=bitcoin&from=2020-07-15&sortBy=publishedAt&apiKey=beae3cfddeab4db0bc3fc9490ba48067"

        var request =  URLRequest(url: URL(string:urlString)!)
        request.httpMethod = HTTPMethod.get.rawValue
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
//        print("Final Request:::",request)
        
        task = session.dataTask(with: request, completionHandler: { (responseData, response, responseError) in
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    if let data = responseData, let _ = String(data: data, encoding: .utf8) {
                        do {
                            print("Response data: \(data)")
                          let newsResponse = try JSONDecoder().decode(NewsModel.self, from: data)
//                            print(newsResponse)
                            
                            DispatchQueue.main.async {
                                completionHandler(newsResponse)
                            }
                        }
                        catch let error {
                            print("Parsing Error:\(error)")
                        }
                    }
                case .unautherized:
                    return
                case .failure(_):
                    return
                }
            }
        })
        task?.resume()
    }
}

 static func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String> {
    switch response.statusCode {
        case 200...299: return .success
        case 401: return .unautherized
        case 402...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
    }
  }
 }

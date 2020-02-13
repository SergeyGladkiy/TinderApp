//
//  NetworkService.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NetworkService {
    private let authService: InterfaceAuthService
    
    init(authService: InterfaceAuthService) {
        self.authService = authService
    }
    
    private func getURl(host: String?, path: String, paramse: [String: String]?) -> URL {
        var urlComponents = URLComponents()
        urlComponents.scheme = API.scheme
        urlComponents.host = host
        urlComponents.path = path
        
        if let paramse = paramse {
            urlComponents.queryItems = paramse.map { URLQueryItem(name: $0, value: $1) }
        }
        
        return urlComponents.url!
    }
    
    private func createDataTask(urlRequest: URLRequest, completionHandler: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
            DispatchQueue.main.async {
                completionHandler(data, error)
            }
        }
        return task
    }
}

extension NetworkService: InterfaceNetworkService {
    func request(path: String, paramse: [String : String]?, completion: @escaping (Data?, Error?) -> Void) {
        
        let url = self.getURl(host: API.host, path: path, paramse: paramse)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue(authService.valueToken, forHTTPHeaderField: authService.keyToken)
        let task = createDataTask(urlRequest: urlRequest) { (data, error) in
            completion(data, error)
        }
        task.resume()
    }
    
    
}

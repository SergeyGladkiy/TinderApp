//
//  NetworkDataFetcer.swift
//  TinderApp
//
//  Created by Serg on 13.02.2020.
//  Copyright © 2020 Sergey Gladkiy. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    private let networkService: InterfaceNetworkService
    
    init(networkService: InterfaceNetworkService) {
        self.networkService = networkService
    }
    
    private func decodeJSON<T: Decodable>(type: T.Type, from data: Data) -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let response = try decoder.decode(type, from: data)
            return response
        } catch let error {
            print("decoder error \(error.localizedDescription)")
        }
        
        return nil
    }
    
    private func responseFourZeroOne() {
        print("Meta status: 401, ERROR message: SESSION INVALID. \nP.S. Проверить актулальность X-Auth-Token на сайте Tinder (обновляется раз в одни день). Через иструменты разработчика \"слушать\" сеть до получения core в XHR. В core будет находиться новый токен")
    }
}

extension NetworkDataFetcher: InterfaceDataFetcher {
    
    func getData(response: @escaping (DataTinder?) -> Void) {
        let path = API.path
        
        self.networkService.request(path: path, paramse: nil) { [weak self] (data, urlResponse, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
                return
            }
            
            guard let responseUrl = urlResponse as? HTTPURLResponse else { return }
            if responseUrl.statusCode == 401 {
                self.responseFourZeroOne()
                response(nil)
                return
            }
            
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: TinderResponseWrapped.self, from: data)
            
            response(decoded?.data)
            
        }
    }
    
    func postEventAction(_idUser: String, sNumberUser: Int, action: StateAction) {
        
        var state = ""
        switch action {
        case .plus:
            state = API.like
        case .minus:
            state = API.dislike
        }
        
        var paramse = ["local": "ru"]
        paramse["s_number"] = "\(sNumberUser)"
        let path = state + _idUser
        self.networkService.request(path: path, paramse: paramse) { (data, responseUrl, error)  in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
            }
            
            guard let responseUrl = responseUrl as? HTTPURLResponse else { return }
            _ = "status code: \(responseUrl.statusCode)"
            //print(code)
        }
    }
}

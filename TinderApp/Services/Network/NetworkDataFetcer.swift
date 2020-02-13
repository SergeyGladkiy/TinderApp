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
}

extension NetworkDataFetcher: InterfaceDataFetcher {
    func getData(response: @escaping (DataTinder?) -> Void) {
        let path = API.path
        
        self.networkService.request(path: path, paramse: nil) { [weak self] (data, error) in
            guard let self = self else { return }
            
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                response(nil)
            }
            
            guard let data = data else { return }
            
            let decoded = self.decodeJSON(type: TinderResponseWrapped.self, from: data)
            
            response(decoded?.data)
            
        }
    }
    
}

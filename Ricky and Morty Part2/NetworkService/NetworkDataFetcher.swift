//
//  NetworkDataFetcher.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation

class NetworkDataFetcher: DataFetcher {
    
    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONdata<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void) {
        print(T.self)
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Error is \(error.localizedDescription)")
                completion(nil)
            }
            let decoded = self.decodeJSON(type: T.self, from: data)
            completion(decoded)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("faild to decode JSON", jsonError)
            return nil
        }
    }
}

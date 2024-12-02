//
//  NetworkService.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation

class NetworkService: Networking {
    
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            print("REQUEST - nil")
            return
        }
        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data,response,error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
    
}

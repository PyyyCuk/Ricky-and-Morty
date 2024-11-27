//
//  DataFetcher.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation

protocol DataFetcher {
    func fetchGenericJSONdata<T: Decodable>(urlString: String, completion: @escaping (T?) -> Void)
}

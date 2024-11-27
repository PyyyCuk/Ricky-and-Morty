//
//  Networking.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation

protocol Networking {
    func request(urlString: String, completion: @escaping (Data?, Error?) -> Void)
}

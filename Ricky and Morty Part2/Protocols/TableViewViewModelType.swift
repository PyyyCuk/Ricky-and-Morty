//
//  TableViewViewModelType.swift
//  Ricky Part2
//
//  Created by VanMac on 17.11.2024.
//

import Foundation

protocol TableViewViewModelType {
    func numberOfSection() -> Int
    func selectRow(at IndexPath: IndexPath)
}

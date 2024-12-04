//
//  TableViewViewModelType.swift
//  Ricky Part2
//
//  Created by VanMac on 17.11.2024.
//

import Foundation

protocol TableViewViewModelType {
    func fetchCharacter(completion: @escaping () -> Void)
    func fetchEpisode(completion: @escaping () -> Void)
    func numberOfSection() -> Int
    func selectRow(at indexPath: IndexPath) -> IndexPath
}

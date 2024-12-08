//
//  EpisodeModel.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation


// MARK: - Character
struct Character: Decodable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct CharacterResponse: Decodable {
    let results: [Character]
}


//
//  EpisodeModel.swift
//  Ricky and Morty Part2
//
//  Created by VanMac on 25.11.2024.
//

import Foundation

// MARK: - Episode
struct Episode: Decodable {
    let id: Int?
    let name, airDate, episode: String?
    let characters: [String]?
    let url: String?
    let created: String?
}

struct EpisodesResponse: Decodable {
    let results: [Episode]
}

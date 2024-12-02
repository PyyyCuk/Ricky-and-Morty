//
//  EpisodeTableViewViewModel.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation
import UIKit

class EpisodeTableViewViewModel: TableViewViewModelType {
   
    //MARK: - Внешние зависимости
    var characters: [Character] = []
    var episodes: [Episode] = []
    
    //MARK: - Сеть
    var dataFetcher: DataFetcher
    var networking: Networking
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher(), networking: Networking = NetworkService()) {
        self.dataFetcher = dataFetcher
        self.networking = networking
    }
    
    func fetchCharacter(completion: @escaping () -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        self.dataFetcher.fetchGenericJSONdata(urlString: urlString) { (response: CharacterResponse?) in
            guard let character = response else {
                print("Character JSON - nil")
                return
            }
            self.characters = character.results
            completion()
        }
    }
    
    func fetchEpisode(completion: @escaping () -> Void) {
        let urlString = "https://rickandmortyapi.com/api/episode"
        self.dataFetcher.fetchGenericJSONdata(urlString: urlString) { (response: EpisodesResponse?) in
            guard let episode = response else {
                print("Character JSON - nil")
                return
            }
            self.episodes = episode.results
            completion()
        }
    }
    
    func loadImage(from imageString: String, completion: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: imageString) else {
            completion(nil)
            return
        }
        networking.request(urlString: imageString) { (data, error) in
            if let error = error {
                print("Ошибка загрузки изображения: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
        }
    }
    
    //MARK: - Реализация протокола
    func numberOfSection() -> Int {
        characters.count
    }

}
//    //MARK: - Внешние зависимости
//    var dataFetcher: DataFetcher
//    var networking: Networking
//    
//    //MARK: - Массив эпизодов
//    var characters: [Character] = []
//    
//    init(dataFetcher: DataFetcher = NetworkDataFetcher(), networking: Networking = NetworkService()) {
//        self.dataFetcher = dataFetcher
//        self.networking = networking
//    }
//    
//    func getPerson(completion: @escaping () -> Void) {
//        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else { return }
//        let request = URLRequest(url: url)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            if let result = try? JSONDecoder().decode(CharacterResponse.self, from: data) {
//                self.characters = result.results
//                completion()
//            } else {
//                print("Error decoding JSON: \(String(describing: error))")
//            }
//        }
//        task.resume()
//    }
//    
//    func getPerson(completion: @escaping () -> Void) {
//        let urlString = "https://rickandmortyapi.com/api/character"
//        networking.request(urlString: urlString) { (data, error) in
//            guard let error = error else {
//                print("Error request - \(error?.localizedDescription)")
//                completion()
//                return
//            }
//            
//            guard let data = data else {
//                print("Data request - nil")
//                return
//            }
//            
//            if let result = try? JSONDecoder().decode(CharacterResponse.self, from: data) {
//                self.characters = result.results
//                completion()
//            } else {
//                print("Error decoding JSON: \(String(describing: error))")
//            }
//        }
//        
//    }
//    
//    func getPerson(completion: @escaping () -> Void) {
//        guard let urlString = URL(string:"https://rickandmortyapi.com/api/character") else { return }
//        let url = "https://rickandmortyapi.com/api/character"
//        let request = URLRequest(url: urlString)
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            self.dataFetcher.fetchGenericsJSON(urlString: url) { (response: CharacterResponse?) in
//                guard let character = response else {
//                    print("Character JSON - nil")
//                    return
//                }
//                self.characters = response!.results
//                completion()
//                
//            }
//        }
//        task.resume()
//    }
//            networking.request(urlString: urlString) { (data, error) in
//                guard let error = error, let data = data else {
//                    print("Error request - \(String(describing: error))")
//                    print("Data is nil")
//                    return
//                }
//    
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data else { return }
//            if let result = try? JSONDecoder().decode(CharacterResponse.self, from: data) {
//                self.characters = result.results
//                completion()
//            } else {
//                print("Error decoding JSON: \(String(describing: error))")
//            }
//        }
//        task.resume()
//    }
//    func fetchCharacter(completion: @escaping ([Character]?) -> Void) {
//        let urlString = "https://rickandmortyapi.com/api/character"
//        dataFetcher.fetchGenericsJSON(urlString: urlString) { (response: [Character]?) in
//            guard let response = response else {
//                completion(nil)
//                print("Response nil")
//                return
//            }
//            self.characters = response
//            completion(self.characters)
//        }
//    }
//    func fetchCharacter(completion: @escaping ([Character]?) -> Void) {
//        let urlString = "https://rickandmortyapi.com/api/character"
//        dataFetcher.fetchGenericsJSON(urlString: urlString, completion: completion)
//        viewModel.lo
//    }



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
    var imagePerson: [UIImage] = []
    
    var dataFetcher: DataFetcher
    var networking: Networking
    
    init(dataFetcher: DataFetcher = NetworkDataFetcher(), networking: Networking = NetworkService()) {
        self.dataFetcher = dataFetcher
        self.networking = networking
    }
    //MARK: - Request Characters
    func fetchCharacter(completion: @escaping () -> Void) {
        let urlString = "https://rickandmortyapi.com/api/character"
        self.dataFetcher.fetchGenericJSONdata(urlString: urlString) { (response: CharacterResponse?) in
            guard let character = response else {
                print("Character JSON - nil")
                return
            }
            self.characters = character.results
            
            let dispatchGroup = DispatchGroup() // Создаем DispatchGroup
            
            for character in character.results {
                dispatchGroup.enter() // Входим в группу
                self.loadImage(from: character.image) { (image) in
                    if let image = image {
                        self.imagePerson.append(image)
                    }
                    dispatchGroup.leave() // Выходим из группы после
                }
            }
            // Ждем завершения всех загрузок изображений
            dispatchGroup.notify(queue: .main) {
                completion() // Вызываем completion только после завершения всех загрузок
            }
        }
    }
    //MARK: - Request Episodes
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
    //Загрузка картинки
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        networking.request(urlString: urlString) { (data, error) in
            if let error = error {
                print("Ошибка: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                completion(nil)
                return
            }
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
    }
    
    //MARK: - Реализация протокола
    func numberOfSection() -> Int {
        self.characters.count
    }
    
    func selectRow(at indexPath: IndexPath) -> IndexPath {
        self.selectedIndexPath = indexPath
        return indexPath
    }
    
    //MARK: - Отслеживание состояния кнопки
    
    var heartTapped: Bool = false {
        didSet {
            
        }
    }

}



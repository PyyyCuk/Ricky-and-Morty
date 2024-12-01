//
//  ViewController.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import UIKit

class EpisodeViewController: UIViewController {

    //MARK: - Внешние зависимости
    var viewModel = EpisodeTableViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    //MARK: - static Constant
    
    //MARK: - private properties
    private var tableView: UITableView = {
        let tableView = UITableView()
        // Убираем линии между ячейками
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.register(EpisodeTableViewCell.self, forCellReuseIdentifier: String(describing: EpisodeTableViewCell.self))
        return tableView
    }()
}

extension EpisodeViewController {
    func initialize() {
        viewModel.fetchCharacter {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel.fetchEpisode {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.title = "Episodes"
        
        tableView.dataSource = self
        tableView.delegate = self  
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
            
        ])
        
    }
}

extension EpisodeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 425
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfSection() 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "EpisodeTableViewCell"), for: indexPath) as? EpisodeTableViewCell
        guard let cell = cell else { return UITableViewCell() }
        let character = viewModel.characters[indexPath.row]
        cell.configure(with: character, episodes: viewModel.episodes)
        cell.selectionStyle = .none
        cell.backgroundColor = .white
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = viewModel.selectRow(at: indexPath)
        print(viewModel.selectedIndexPath)
    }
}

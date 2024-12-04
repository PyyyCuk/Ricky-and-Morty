//
//  ViewController.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import UIKit

class EpisodeViewController: UIViewController {

    //MARK: - Внешние зависимости
    var viewModel: TableViewViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = EpisodeTableViewViewModel()
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
        
        guard let viewModel = viewModel else { return }
        
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
        return viewModel?.numberOfSection() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: "EpisodeTableViewCell"), for: indexPath) as? EpisodeTableViewCell
        guard let tableViewCell = cell else { return UITableViewCell() }
        if let viewModel = viewModel as? EpisodeTableViewViewModel {
            let characters = viewModel.characters[indexPath.row]
            tableViewCell.configure(with: characters, episodes: viewModel.episodes)
        }
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        let selectRow = viewModel.selectRow(at: indexPath)
        print(selectRow)
    }
}

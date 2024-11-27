//
//  EpisodesTableViewCell.swift
//  Ricky Part2
//
//  Created by VanMac on 16.11.2024.
//

import Foundation
import UIKit

class EpisodeTableViewCell: UITableViewCell {
    
    //MARK: - Внешние зависимоти
    var viewModel = EpisodeTableViewViewModel()
    
    func configure(with model: Character, episodes: [Episode]) {
        self.labelName.text = model.name
        self.labelLive.text = model.status
        self.labelNameEpisode.text = episodes.randomElement()?.name ?? "name episode - nil"
        self.labelNumEpisode.text = "|" + " " + (episodes.randomElement()?.episode ?? "num episode - nil")
        
        viewModel.loadImage(from: model.image) { (image) in
            self.personImage.image = image
        }
    }
    
    //MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        initialize()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - private Constant
    enum Constant {
        static let offsetImageRight: CGFloat = -35
        static let offsetImageLeft: CGFloat = 35
        
        static let offsetBottomImage: CGFloat = -150
        
        static let sizeNameWidth: CGFloat = 250
        static let sizeNameHeight: CGFloat = 25
        static let offsetNameTop: CGFloat = 8
        static let offestNameLeft: CGFloat = 10
    
        
        static let sizeLiveWitdh: CGFloat = 100
        static let sizeLiveHeight: CGFloat = 25
        static let offsetLiveTop: CGFloat = 5
        
        static let sizeButtonPlayWidth: CGFloat = 35
        static let sizeButtonPlayHeight: CGFloat = 35
        static let offsetButtonPlayTop: CGFloat = 15
        static let offsetButtonPlayLeft: CGFloat = 5
        
        static let sizeEpisodeNameWidth: CGFloat = 115
        static let sizeEpisodeNameHeigh: CGFloat = 35
        static let offsetEpisodeLeft: CGFloat = 10
        static let offsetEpisodeBottom: CGFloat = -2.5
        
        static let sizeNumEpisodeWidth: CGFloat = 75
        static let sizeNumEpisodeHeight: CGFloat = 35
        
        static let sizeHeartButtonWidth: CGFloat = 30
        static let sizeHeartButtonHeight: CGFloat = 30
        static let offsetHertButtonLeft: CGFloat = -10
    }
    
    
    //MARK: - private properties
    private let personImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        image.clipsToBounds = true //Если за пределые выходит - обрезается
        image.layer.cornerRadius = 7
        image.layer.masksToBounds = true
        image.isUserInteractionEnabled = true //Взаимодействие с картинкой
        return image
    }()
    
    private let labelName: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let labelLive: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = CGAffineTransform(scaleX: 1.1, y: 1.3)
        button.setImage(UIImage(systemName: "play.tv"), for: .normal)
        button.tintColor = .black
        button.contentMode = .center
        return button
    }()
    
    private var labelNameEpisode: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font =  .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private var labelNumEpisode: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font =  .systemFont(ofSize: 17)
        label.textAlignment = .left
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .systemCyan
        return button
    }()
    
    
    @objc func heartPressed() {
        viewModel.isHeartTapped.toggle()
        let imageName = viewModel.isHeartTapped ? "heart.fill" : "heart"
        heartButton.setImage(UIImage(systemName: imageName), for: .normal)
        heartButton.tintColor = viewModel.isHeartTapped ? .systemRed : .systemCyan
    }
    
}
extension EpisodeTableViewCell {
    func initialize() {
        
        heartButton.addTarget(self, action: #selector(heartPressed), for: .touchUpInside)
        
        contentView.addSubview(personImage)
        NSLayoutConstraint.activate([
            personImage.topAnchor.constraint(equalTo: contentView.topAnchor),
            personImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constant.offsetBottomImage),
            personImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constant.offsetImageRight),
            personImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constant.offsetImageLeft)
        ])
        
        contentView.addSubview(labelName)
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: personImage.bottomAnchor, constant: Constant.offsetNameTop),
            labelName.leadingAnchor.constraint(equalTo: personImage.leadingAnchor, constant: Constant.offestNameLeft),
            labelName.widthAnchor.constraint(equalToConstant: Constant.sizeNameWidth),
            labelName.heightAnchor.constraint(equalToConstant: Constant.sizeNameHeight)
        ])
        
        contentView.addSubview(labelLive)
        NSLayoutConstraint.activate([
            labelLive.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: Constant.offsetLiveTop),
            labelLive.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            labelLive.widthAnchor.constraint(equalToConstant: Constant.sizeLiveWitdh),
            labelLive.heightAnchor.constraint(equalToConstant: Constant.sizeLiveHeight)
        ])
        
        contentView.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.topAnchor.constraint(equalTo: labelLive.bottomAnchor, constant: Constant.offsetButtonPlayTop),
            playButton.leadingAnchor.constraint(equalTo: labelLive.leadingAnchor, constant: Constant.offsetButtonPlayLeft),
            playButton.widthAnchor.constraint(equalToConstant: Constant.sizeButtonPlayWidth),
            playButton.heightAnchor.constraint(equalToConstant: Constant.sizeButtonPlayHeight)
        ])
        
        contentView.addSubview(labelNameEpisode)
        NSLayoutConstraint.activate([
            labelNameEpisode.topAnchor.constraint(equalTo: playButton.topAnchor, constant: Constant.offsetEpisodeBottom),
            labelNameEpisode.leadingAnchor.constraint(equalTo: playButton.trailingAnchor,constant: Constant.offsetEpisodeLeft),
            labelNameEpisode.widthAnchor.constraint(equalToConstant: Constant.sizeEpisodeNameWidth),
            labelNameEpisode.heightAnchor.constraint(equalToConstant: Constant.sizeEpisodeNameHeigh)
        ])
        
        contentView.addSubview(labelNumEpisode)
        NSLayoutConstraint.activate([
            labelNumEpisode.topAnchor.constraint(equalTo: labelNameEpisode.topAnchor),
            labelNumEpisode.leadingAnchor.constraint(equalTo: labelNameEpisode.trailingAnchor, constant: Constant.offsetEpisodeLeft),
            labelNumEpisode.widthAnchor.constraint(equalToConstant: Constant.sizeNumEpisodeWidth),
            labelNumEpisode.heightAnchor.constraint(equalToConstant: Constant.sizeNumEpisodeHeight)
        ])
        
        contentView.addSubview(heartButton)
        NSLayoutConstraint.activate([
            heartButton.centerYAnchor.constraint(equalTo: labelNumEpisode.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: personImage.trailingAnchor, constant: Constant.offsetHertButtonLeft),
            heartButton.widthAnchor.constraint(equalToConstant: Constant.sizeHeartButtonWidth),
            heartButton.heightAnchor.constraint(equalToConstant: Constant.sizeHeartButtonHeight)
        ])
        
    }
}


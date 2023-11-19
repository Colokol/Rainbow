//
//  GameResultTableViewCell.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 14.11.23.
//

import UIKit

class GameResultTableViewCell: UITableViewCell {

    private let gameNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()

    private let gameTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .black
        return label
    }()

    private let correctPercentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setupView() {
        addSubview(correctPercentLabel)
        addSubview(gameTimeLabel)
        addSubview(gameNumberLabel)

        NSLayoutConstraint.activate([
            gameNumberLabel.topAnchor.constraint(equalTo: topAnchor),
            gameNumberLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            gameTimeLabel.topAnchor.constraint(equalTo: gameNumberLabel.bottomAnchor, constant: 5),
            gameTimeLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            correctPercentLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            correctPercentLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            correctPercentLabel.widthAnchor.constraint(equalToConstant: 100)

        ])
    }


    func configureCell(game: GamesResult, gameNumber: Int) {
        let allscore = Double(game.allScore)
        let gamescore = Double(game.gameScore)
        let percent = (gamescore / allscore) * 100

        gameNumberLabel.text = "Игра номер: \(gameNumber)"
        correctPercentLabel.text = String(format: "Правильных ответов: %.0f%%", percent)
        gameTimeLabel.text = "\(game.levelTime) секунд"
    }


}

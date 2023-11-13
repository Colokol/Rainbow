//
//  MenuView.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit

class MenuView: UIView {

    var onStartButton: (() -> Void)?
    var onStatisticsButton: (() -> Void)?
    var onSettingsButton: (() -> Void)?
    var onResumeButton: (() -> Void)?
    var onRulesButton: (() -> Void)?

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.logoImage)
        return imageView
    }()

    private let rainbowLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 40, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = Constants.nameGame
        return label
    }()

    private let startButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Новая игра", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemRed
        return button
    }()

    private let resumeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Продолжить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemBlue
        return button
    }()

    private let statisticsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.setTitle("Статистика", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22, weight: .medium)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.backgroundColor = .systemGreen
        return button
    }()

    private let settingsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "transmission"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private let rulesButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "questionmark.square"), for: .normal)
        button.tintColor = .black
        return button
    }()

    private var buttonStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
        setConstraints()
        addActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        buttonStackView =  UIStackView(arrangedSubviews: [startButton, resumeButton, statisticsButton])
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.axis = .vertical
        buttonStackView.spacing = 15
        buttonStackView.distribution = .fillEqually

        self.backgroundColor = .lightGray
        self.addSubview(imageView)
        self.addSubview(rainbowLabel)
        self.addSubview(buttonStackView)
        self.addSubview(settingsButton)
        self.addSubview(rulesButton)
    }

// MARK: - Constraints
    private func setConstraints(){
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: self.frame.width * 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 150),

            rainbowLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
            rainbowLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            rainbowLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            rainbowLabel.heightAnchor.constraint(equalToConstant: 130),

            buttonStackView.topAnchor.constraint(equalTo: rainbowLabel.bottomAnchor, constant: 50),
            buttonStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            buttonStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            buttonStackView.bottomAnchor.constraint(equalTo: settingsButton.topAnchor, constant: -30),

            settingsButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            settingsButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50),

            rulesButton.topAnchor.constraint(equalTo: settingsButton.topAnchor),
            rulesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            rulesButton.heightAnchor.constraint(equalToConstant: 50),
            rulesButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    // MARK: - Actions

    private func addActions() {
        startButton.addTarget(self, action: #selector(startButtonPress), for: .touchUpInside)
        resumeButton.addTarget(self, action: #selector(resumeButtonPress), for: .touchUpInside)
        statisticsButton.addTarget(self, action: #selector(statisticsButtonPress), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonPress), for: .touchUpInside)
        rulesButton.addTarget(self, action: #selector(rulesButtonPress), for: .touchUpInside)
    }

    @objc func startButtonPress() {
        onStartButton?()
    }

    @objc func resumeButtonPress() {
        onResumeButton?()
    }

    @objc func statisticsButtonPress() {
        onStatisticsButton?()
    }

    @objc func settingsButtonPress() {
        onSettingsButton?()
    }

    @objc func rulesButtonPress() {
        onRulesButton?()
    }

}


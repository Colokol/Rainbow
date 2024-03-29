//
//  GameViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 14.11.23.
//

import UIKit
import CoreData

final class GameViewController: UIViewController {
    private var levelTime = 0
    private var settingsModel: AppSettings
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var gameModel = GameModel()
    private var gameSpeedTimer: Timer?
    private var levelTimeTimer: Timer?
    private var buttons: [UIButton] = []
    private var completionWorkItem: DispatchWorkItem?

    private let x2SpeedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "speedometer"), for: .normal)
        button.tintColor = .black
        return button
    }()


    init(settings:AppSettings) {
        self.settingsModel = settings
        levelTime = Int(settings.timeGame)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: settingsModel.backgroundColor!)
        title = formattedTime(seconds: Int(settingsModel.timeGame))  
        startGameTime()
        displayNextWords()
        setupButton()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        levelTimeTimer?.invalidate()
        gameSpeedTimer?.invalidate()
    }

    private func setupButton() {
        let pauseButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(pauseButtonPress))

        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonPress))

        let appearance = UINavigationBarAppearance()

        if settingsModel.backgroundColor == "black" {
            appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.white]
            pauseButton.tintColor = .white
            x2SpeedButton.tintColor = .white
            backButton.tintColor = .white
        }else {
            appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24), .foregroundColor: UIColor.black]
            pauseButton.tintColor = .black
            backButton.tintColor = .black
        }

        navigationController?.navigationBar.standardAppearance = appearance
        navigationItem.rightBarButtonItem = pauseButton
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationItem.hidesBackButton = true
        view.addSubview(x2SpeedButton)

        x2SpeedButton.addTarget(self, action: #selector(x2ButtonPress), for: .touchUpInside)

        NSLayoutConstraint.activate([
            x2SpeedButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            x2SpeedButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            x2SpeedButton.heightAnchor.constraint(equalToConstant: 50),
            x2SpeedButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func stopGame() {
        gameSpeedTimer?.invalidate()
        levelTimeTimer?.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            self.saveGameData()
            self.goStatisticsScreen()
        }
    }

    private func goStatisticsScreen(){
        let statisticsVC = StatisticsViewController()
        navigationController?.pushViewController(statisticsVC, animated: false)
    }

    

    private func displayNextWords() {

        if buttons.count > 15 {
            let firstButton = buttons.removeFirst()
            firstButton.removeFromSuperview()
        }

        if settingsModel.staticGameMode {
            let wordButton = createStaticButton()
            view.addSubview(wordButton)
            buttons.append(wordButton)
        }else {
            let wordButton = createWordButton()

            let animator = UIViewPropertyAnimator(duration: 6.0, curve: .linear) {
                wordButton.frame.origin.y = self.view.frame.height
            }
            animator.startAnimation()
            view.addSubview(wordButton)
            buttons.append(wordButton)
        }


        gameModel.allScore += 1
    }

    private func createStaticButton() -> UIButton {
        buttons.forEach {
            $0.removeFromSuperview()
            buttons = []
        }
        
        let wordButton = UIButton(frame: CGRect(x: (view.bounds.width - 170) / 2 , y: (view.bounds.height - 50) / 2, width: 170, height: 50))
        wordButton.layer.cornerRadius = 10
        wordButton.setTitle(Constants.colorNames.randomElement(), for: .normal)
        wordButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: CGFloat(settingsModel.letterSize))
        wordButton.setTitleColor(.white, for: .normal)
        wordButton.addTarget(self, action: #selector(correctTap), for: .touchUpInside)

        if settingsModel.backgroundActive {
            wordButton.backgroundColor = Constants.color.randomElement()
        }else {
            wordButton.setTitleColor(Constants.color.randomElement(), for: .normal)
        }
        
        return wordButton
    }

    private func createWordButton() -> UIButton {

        let randomX = CGFloat.random(in: 10...(view.frame.width - 170))

        let wordButton = UIButton(frame: CGRect(x: randomX, y: 90, width: 170, height: 50))
        wordButton.layer.cornerRadius = 10
        wordButton.setTitle(Constants.colorNames.randomElement(), for: .normal)
        wordButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: CGFloat(settingsModel.letterSize))
        wordButton.setTitleColor(.white, for: .normal)
        wordButton.addTarget(self, action: #selector(correctTap), for: .touchUpInside)

        if settingsModel.backgroundActive {
            wordButton.backgroundColor = Constants.color.randomElement()
        }else {
            wordButton.setTitleColor(Constants.color.randomElement(), for: .normal)
        }
        return wordButton
    }

    private func formattedTime(seconds:Int) -> String {
        let timeInterval = TimeInterval(seconds)

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]
        formatter.zeroFormattingBehavior = .pad

        return formatter.string(from: timeInterval) ?? ""
    }

    private func saveGameData() {
        let gameStat = GamesResult(context: self.context)
        gameStat.allScore = Int64(gameModel.allScore)
        gameStat.gameScore = Int64(gameModel.gameScore)
        gameStat.levelTime = Int64(settingsModel.timeGame)
        gameStat.gameSpeed = Int64(settingsModel.wordChangeSpeed)
        try? context.save()
    }
}

 // MARK: - Actions
extension GameViewController {

    @objc func pauseButtonPress(){
        gameModel.timerPause.toggle()
        if gameModel.timerPause {
            gameSpeedTimer?.invalidate()
            levelTimeTimer?.invalidate()
        }else {
            displayNextWords()
            startGameTime()
        }
    }

    @objc func backButtonPress() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func correctTap(sender: UIButton) {
        guard settingsModel.checkAnswer else {return}
        gameModel.gameScore += 1
        sender.isEnabled = false

        sender.setTitle("Верно", for: .normal)
        sender.backgroundColor = .systemGreen
    }

    @objc func x2ButtonPress(){
        gameSpeedTimer?.invalidate()
        gameSpeedTimer = Timer.scheduledTimer(timeInterval: TimeInterval(settingsModel.wordChangeSpeed) / 2, target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
        x2SpeedButton.isEnabled = false
    }

}

// MARK: - Timer
extension GameViewController {
    
    func startTime() {
        gameSpeedTimer = Timer.scheduledTimer(timeInterval: TimeInterval(settingsModel.wordChangeSpeed), target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
    }

    func startGameTime() {
        startTime()

        levelTimeTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else {return}
            if self.levelTime >= 0 {
                self.title = formattedTime(seconds: levelTime)
                self.levelTime -= 1
            }else {
                self.title = "Время вышло"
                self.stopGame()
            }
        }
    }

    @objc func gameTime() {
        if  levelTime >= 0 {
            displayNextWords()
        }
    }
}

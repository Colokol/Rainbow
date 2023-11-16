//
//  GameViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 14.11.23.
//

import UIKit
import CoreData

final class GameViewController: UIViewController {

    let configaa: (Int,Int,Bool) = (120,2,true)

    private let settingsModel: GameConfig
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var gameModel = GameModel(levelTime: 12)
    private var timer: Timer?
    private var buttons: [UIButton] = []
    private var completionWorkItem: DispatchWorkItem?


    private let x2SpeedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "speedometer"), for: .normal)
        button.tintColor = .black
        return button
    }()

    init() {
        self.settingsModel = GameConfig(config: configaa)
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray

        startTime()
        setupButton()
    }

    private func setupButton() {

        let pauseButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"),
                                          style: .plain,
                                          target: self,
                                          action: #selector(pauseButtonPress))
        pauseButton.tintColor = .black
        navigationItem.rightBarButtonItem = pauseButton

        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonPress))
        backButton.tintColor = .black

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
        timer?.invalidate()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6){
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

        let wordButton = createWordButton()

        let animator = UIViewPropertyAnimator(duration: 6.0, curve: .linear) {
            wordButton.frame.origin.y = self.view.frame.height
        }
        animator.startAnimation()

        view.addSubview(wordButton)
        buttons.append(wordButton)
        gameModel.allScore += 1
    }

    private func createWordButton() -> UIButton {

        let randomX = CGFloat.random(in: 10...(view.frame.width - 150))

        let wordButton = UIButton(frame: CGRect(x: randomX, y: 90, width: 150, height: 50))
        wordButton.layer.cornerRadius = 10
        wordButton.setTitle(Constants.colorNames.randomElement(), for: .normal)
        wordButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 16)
        wordButton.setTitleColor(.white, for: .normal)
        wordButton.backgroundColor = Constants.color.randomElement()
        wordButton.addTarget(self, action: #selector(correctTap), for: .touchUpInside)
        return wordButton
    }

    private func formattedTime(seconds:Int) -> String {
        let timeInterval = TimeInterval(seconds)

        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.minute, .second]

        return formatter.string(from: timeInterval) ?? ""
    }

    private func saveGameData() {
        let gameStat = GamesResult(context: self.context)
        gameStat.allScore = Int64(gameModel.allScore)
        gameStat.gameScore = Int64(gameModel.gameScore)
        gameStat.levelTime = Int64(settingsModel.levelTime)
        try? context.save()
    }
}

 // MARK: - Actions
extension GameViewController {

    @objc func pauseButtonPress(){
        gameModel.timerPause.toggle()
        gameModel.timerPause ? timer?.invalidate() : startTime()
    }

    @objc func backButtonPress() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func correctTap(sender: UIButton) {
        gameModel.gameScore += 1

        sender.setTitle("Верно", for: .normal)
        sender.backgroundColor = .systemGreen
    }

    @objc func x2ButtonPress(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(settingsModel.wordChangeSpeed / 2), target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
        x2SpeedButton.isEnabled = false
    }

}

// MARK: - Timer
extension GameViewController {
    
    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(settingsModel.wordChangeSpeed), target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
    }

    @objc func gameTime() {
        if gameModel.levelTime >= 0 {
            title = formattedTime(seconds: gameModel.levelTime)
            gameModel.levelTime -= 1

            displayNextWords()
        }else {
            stopGame()
        }
    }
}

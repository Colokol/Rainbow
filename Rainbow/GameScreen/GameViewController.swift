//
//  GameViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 14.11.23.
//

import UIKit
import CoreData

final class GameViewController: UIViewController {

    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var gameScore = 0
    var allScore = 0
    private var timer:Timer?
    private var levelTime = 6
    private var timerPause = false
    private var buttons: [UIButton] = []

    private let x2SpeedButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "speedometer"), for: .normal)
        button.tintColor = .black
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        startTime()
        setupButton()
    }

    private func setupButton() {

        let pauseButton = UIBarButtonItem(image: UIImage(systemName: "pause.fill"), style: .plain, target: self, action: #selector(pauseButtonPress))
        pauseButton.tintColor = .black
        navigationItem.rightBarButtonItem = pauseButton

        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: self, action: #selector(backButtonPress))
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationItem.hidesBackButton = true

        x2SpeedButton.addTarget(self, action: #selector(x2ButtonPress), for: .touchUpInside)
        view.addSubview(x2SpeedButton)
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

        let wordButton = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        let randomX = CGFloat.random(in: 100...(view.frame.width - wordButton.frame.width))

        wordButton.frame = CGRect(x: randomX, y: 90, width: 150, height: 50)
        wordButton.layer.cornerRadius = 10
        wordButton.addTarget(self, action: #selector(tap), for: .touchUpInside)
        wordButton.setTitle("Слово", for: .normal)
        wordButton.backgroundColor = .red

        let animator = UIViewPropertyAnimator(duration: 6.0, curve: .linear) {
            wordButton.frame.origin.y = self.view.frame.height
        }
        animator.startAnimation()

        allScore += 1
        view.addSubview(wordButton)
        buttons.append(wordButton)
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
        gameStat.allScore = Int64(allScore)
        gameStat.gameScore = Int64(gameScore)
        gameStat.levelTime = 120
        try? context.save()
    }



    @objc func pauseButtonPress(){
        timerPause.toggle()
        timerPause ? timer?.invalidate() : startTime()
    }

    @objc func backButtonPress() {
        navigationController?.popToRootViewController(animated: true)
    }

    @objc func tap(sender: UIButton) {
        gameScore += 1
        print(gameScore)

        sender.setTitle("Угадано", for: .normal)
        sender.backgroundColor = .systemGreen
    }

    @objc func x2ButtonPress(){
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
        x2SpeedButton.isEnabled = false
    }

}

// MARK: - Timer
extension GameViewController {
    
    func startTime() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(gameTime), userInfo: nil, repeats: true)
    }

    @objc func gameTime() {
        if levelTime >= 0 {
            title = formattedTime(seconds: levelTime)
            levelTime -= 1

            displayNextWords()
        }else {
            stopGame()
        }
    }
}

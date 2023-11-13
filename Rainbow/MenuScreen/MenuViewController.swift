//
//  MenuViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit

class MenuViewController: UIViewController {

    private var menuView: MenuView {self.view as! MenuView}

    override func loadView() {
        self.view = MenuView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setActions()
    }

    // MARK: - Actions

    private func setActions() {
        menuView.onStartButton = { [weak self] in self?.startButtonPress()  }
        menuView.onResumeButton = { print("Продолжить")}
        menuView.onSettingsButton = { [weak self] in self?.settingsButtonPress()  }
        menuView.onStatisticsButton = { [weak self] in self?.statisticsButtonPress()  }
        menuView.onRulesButton = { [weak self] in self?.rulesButtonPress() }
    }

        // Настройка переходов на  экраны
    //Экран Игры
    @objc func startButtonPress() {
//        let gameViewController =  //название vc
//        navigationController?.pushViewController(gameViewController, animated: true)
        print("Играть")
    }

    //Экран Настроек
    @objc func settingsButtonPress() {
            //        let gameViewController =  //название vc
            //        navigationController?.pushViewController(gameViewController, animated: true)
        print("Настройки")
    }

    // Экран Статистики
    @objc func statisticsButtonPress() {
            //        let gameViewController =  //название vc
            //        navigationController?.pushViewController(gameViewController, animated: true)
        print("Статистика")
    }

    @objc func rulesButtonPress() {
        print("Правила")
    }
}

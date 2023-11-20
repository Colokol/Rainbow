    //
    //  MenuViewController.swift
    //  Rainbow
    //
    //  Created by Uladzislau Yatskevich on 10.11.23.
    //

import UIKit
import CoreData

class MenuViewController: UIViewController {

    var settings: AppSettings?
    private var menuView: MenuView {self.view as! MenuView}
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func loadView() {
        self.view = MenuView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setActions()
    }

    override func viewWillAppear(_ animated: Bool) {
        loadSettings()
    }

    private func loadSettings(){
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        do{
            let data = try self.context.fetch(request)
            DispatchQueue.main.async {
                self.settings = data[0]
            }
        }catch {
            print("Error load data")
        }
    }

        // MARK: - Actions

    private func setActions() {
        menuView.onStartButton = { [weak self] in self?.startButtonPress()  }
        menuView.onResumeButton = { print("Продолжить")}
        menuView.onSettingsButton = { [weak self] in self?.settingsButtonPress()  }
        menuView.onStatisticsButton = { [weak self] in self?.statisticsButtonPress()  }
        menuView.onRulesButton = { [weak self] in self?.rulesButtonPress() }
    }

        //Экран Игры
    @objc func startButtonPress() {
        guard let settings else {return}
        let gameViewController =  GameViewController(settings: settings)
        navigationController?.pushViewController(gameViewController, animated: true)
    }

        //Экран Настроек
    @objc func settingsButtonPress() {
        guard let settings else {return}
        let settingsViewController = SettingsViewController(settings: settings)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }

        // Экран Статистики
    @objc func statisticsButtonPress() {
        let statisticsViewController = StatisticsViewController()
        navigationController?.pushViewController(statisticsViewController, animated: true)
    }

        // Экран правил
    @objc func rulesButtonPress() {
        let helpViewController = HelpViewController()
        navigationController?.pushViewController(helpViewController, animated: true)
    }

}

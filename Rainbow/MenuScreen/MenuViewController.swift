//
//  MenuViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit
import CoreData

class MenuViewController: UIViewController {

    private var menuView: MenuView {self.view as! MenuView}
    var settings: AppSettings?

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
            print("Error")
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

        // Настройка переходов на  экраны
    //Экран Игры
    @objc func startButtonPress() {
        let gameViewController =  GameViewController(settings: settings!)
        navigationController?.pushViewController(gameViewController, animated: true)
    }

    //Экран Настроек
    @objc func settingsButtonPress() {
            let settingsViewController = SettingsViewController()
            navigationController?.pushViewController(settingsViewController, animated: true)
    }

    // Экран Статистики
    @objc func statisticsButtonPress() {
        let statisticsVC = StatisticsViewController()
        navigationController?.pushViewController(statisticsVC, animated: true)
    }

    @objc func rulesButtonPress() {

            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "GamesResult")
            let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

            do {
                try context.execute(batchDeleteRequest)
                try context.save()
            } catch {
                print("Failed to delete data: \(error)")
            }
            }
}

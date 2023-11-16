//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    var settingsView = SettingsView()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var settings: AppSettings?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        
//        settingsView = SettingsView(settings:settings!)
        view = settingsView

        showNavigationBar()
        setActions()

    }

    private func setActions() {
        settingsView.gameTimeSlider.addTarget(self, action: #selector(sliderChange(sender:)), for: .valueChanged)
        settingsView.changeRateSlider.addTarget(self, action: #selector(sliderChange(sender:)), for: .valueChanged)
    }

    @objc func sliderChange(sender: UISlider){
        switch sender {
            case settingsView.gameTimeSlider:
                settingsView.numberGameTime.text = String(Int(sender.value))
                settings?.timeGame = Int16(sender.value) * 60
            case settingsView.changeRateSlider:
                settingsView.numberChangeRate.text = String(Int(sender.value))
                settings?.wordChangeSpeed = Int16(sender.value)
            default:
                print(sender.value)
        }
    }

    private func loadSettings(){
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        do {
            let data = try self.context.fetch(request)
            if let settings = data.first {
                DispatchQueue.main.async {
                    self.settings = settings
                }
            } else {
                    // Создать новые настройки, если они отсутствуют
            }
        } catch {
            print("Error: \(error)")
        }
    }

    func showNavigationBar() {
        title = "Настройки"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]
        navigationController?.navigationBar.standardAppearance = appearance
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonTapped))
        
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    private func saveSettings() {
        do {
            try self.context.save()
        } catch {
            print("Error saving settings: \(error)")
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
    }
}

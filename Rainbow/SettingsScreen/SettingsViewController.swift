//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let settingsView = SettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = settingsView
        showNavigationBar()
        setActions()
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
    
    private func setActions() {
        settingsView.onCheckTaskChanged = { [weak self] isOn in self?.checkTaskChangedPress() }
        settingsView.onGameTimeChanged = { [weak self] gameTime in self?.gameTimeChangedPress()  }
        settingsView.onChangeRateChanged = { [weak self] changeRate in self?.changeRateChangedPress()  }
    }
    
    func gameTimeChangedPress() {
        print("Изменено значение время игры")
    }
    
    @objc func changeRateChangedPress() {
        print("Скорость смены заданий изменена")
    }
    
    @objc func checkTaskChangedPress() {
        print("Switch игра с проверкой заданий изменена")
    }

}

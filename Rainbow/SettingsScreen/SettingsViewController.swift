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
    let settingsModel:AppSettings

    init(settings:AppSettings) {
        self.settingsModel = settings
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
        view = settingsView

        showNavigationBar()

        setActions()
        setSettingsValue(settings: settingsModel)
    }

    func setSettingsValue(settings:AppSettings){
        settingsView.numberChangeRate.text = String(settings.wordChangeSpeed)
        settingsView.changeRateSlider.value = Float(settings.wordChangeSpeed)
        settingsView.gameTimeSlider.value = Float(settings.timeGame / 60)
        settingsView.numberGameTime.text = String(settings.timeGame / 60)
        settingsView.checkTaskSwitch.isOn = settings.checkAnswear
        settingsView.letterBaseSwitch.isOn = settings.backgroundActive
        settingsView.lettersLabel.font = .systemFont(ofSize: CGFloat(settings.letterSize))
        settingsView.sizeStepper.value = Double(settings.letterSize)

        switch settings.backgroundColor {
            case "white":
                settingsView.backgroundColorSC.selectedSegmentIndex = 0
            case "systemGray6":
                settingsView.backgroundColorSC.selectedSegmentIndex = 1
            default:
                settingsView.backgroundColorSC.selectedSegmentIndex = 2
        }

    }

    private func setActions() {
        settingsView.gameTimeSlider.addTarget(self, action: #selector(sliderChange(sender:)), for: .valueChanged)
        settingsView.changeRateSlider.addTarget(self, action: #selector(sliderChange(sender:)), for: .valueChanged)
        settingsView.checkTaskSwitch.addTarget(self, action: #selector(switchValueChanged(sender:)), for: .valueChanged)
        settingsView.letterBaseSwitch.addTarget(self, action: #selector(switchValueChanged(sender:)), for: .valueChanged)
        settingsView.sizeStepper.addTarget(self, action: #selector(sizeStepperTap(sender:)), for: .valueChanged)
        settingsView.backgroundColorSC.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
        settingsView.positionSC.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
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

    @objc func switchValueChanged(sender:UISwitch) {
        switch sender {
            case settingsView.checkTaskSwitch:
                settings?.checkAnswear = sender.isOn
            case settingsView.letterBaseSwitch:
                settings?.backgroundActive = sender.isOn
            default:
                print(sender.isOn)
        }
    }

    @objc func sizeStepperTap(sender:UIStepper){
        settingsView.lettersLabel.font = .systemFont(ofSize: sender.value)
        settings?.letterSize = Int16(sender.value)
    }

    @objc func segmentChanged(_ sender: UISegmentedControl){
        switch sender {
            case settingsView.backgroundColorSC:
                switch sender.selectedSegmentIndex{
                    case 0: settings?.backgroundColor = "white"
                            print("0")
                    case 1: settings?.backgroundColor = "systemGray6"
                        print("1")

                    case 2: settings?.backgroundColor = "black"
                        print("2")

                    default:
                        settings?.backgroundColor = "systemGray6"
                }
            case settingsView.positionSC:
                print(sender.selectedSegmentIndex)
            default:
                print("error segment switch")
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

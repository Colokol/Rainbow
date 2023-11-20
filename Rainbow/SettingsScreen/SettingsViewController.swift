//
//  SettingsViewController.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    var settings: AppSettings?
    private var settingsView = SettingsView()
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private let settingsModel:AppSettings
    private var selectedColors: Set<UIColor> = []

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

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveSettings()
    }

    // MARK: - Configuration View

    func setSettingsValue(settings:AppSettings){
        settingsView.numberChangeRate.text = String(settings.wordChangeSpeed)
        settingsView.changeRateSlider.value = Float(settings.wordChangeSpeed)
        settingsView.gameTimeSlider.value = Float(settings.timeGame / 60)
        settingsView.numberGameTime.text = String(settings.timeGame / 60)
        settingsView.checkTaskSwitch.isOn = settings.checkAnswer
        settingsView.letterBaseSwitch.isOn = settings.backgroundActive
        settingsView.lettersLabel.font = .systemFont(ofSize: CGFloat(settings.letterSize))
        settingsView.sizeStepper.value = Double(settings.letterSize)
        settingsView.positionSC.selectedSegmentIndex = settings.staticGameMode ? 1 : 0
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
        settingsView.colorButtons.forEach { button in
            button.addTarget(self, action: #selector(colorButtonTapped(_:)), for: .touchUpInside)
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


    // MARK: -  Actions

    @objc func sliderChange(sender: UISlider){
        switch sender {
            case settingsView.gameTimeSlider:
                settingsView.numberGameTime.text = String(Int(sender.value))
                settings?.timeGame = Int16(sender.value) 
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
                settings?.checkAnswer = sender.isOn
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
                    case 1: settings?.backgroundColor = "systemGray6"
                    case 2: settings?.backgroundColor = "black"
                    default:
                        print("error segment switch")
                }
            case settingsView.positionSC:
                switch sender.selectedSegmentIndex {
                    case 0 : settings?.staticGameMode = false
                    case 1 : settings?.staticGameMode = true
                    default: settings?.staticGameMode = true
                }
            default:
                print("error segment switch")
        }
    }

    @objc func colorButtonTapped(_ sender: UIButton){
        sender.isSelected.toggle()
        if let color = sender.backgroundColor {
            if sender.isSelected {
                selectedColors.insert(color)
            } else {
                selectedColors.remove(color)
            }
            if sender.isSelected {
                sender.setImage(UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .selected)
            } else {
                sender.setImage(nil, for: .normal)
            }
        }

    }

    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }

    // MARK: -  Core Data

    private func loadSettings(){
        let request: NSFetchRequest<AppSettings> = AppSettings.fetchRequest()
        do {
            let data = try self.context.fetch(request)
            if let settings = data.first {
                DispatchQueue.main.async {
                    self.settings = settings
                }
            }
        } catch {
            print("Error: \(error)")
        }
    }

    private func saveSettings() {
        do {
            try self.context.save()
        } catch {
            print("Error saving settings: \(error)")
        }
    }

}


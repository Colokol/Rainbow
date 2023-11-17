//
//  SettingsView.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

class SettingsView: UIView {
    var appSettings: AppSettings?
    
    var onGameTimeChanged: ((Float) -> Void)?
    var onChangeRateChanged: ((Float) -> Void)?
    var onCheckTaskChanged: ((Bool) -> Void)?
    
    let gameTimeLabel = UILabel(text: "время игры, мин")
    let gameTimeSlider = UISlider(maximumValue: 20, value: 10)
    let numberGameTime = UILabel(text: "10")
    
    let changeRateLabel = UILabel(text: "скорость смены заданий, сек")
    let changeRateSlider = UISlider(maximumValue: 4, value: 2)
    let numberChangeRate = UILabel(text: "2")
    
    let checkTaskLabel = UILabel(text: "игра с проверкой заданий")
    let checkTaskSwitch = UISwitch()
    
    let lettersColor = UILabel(text: "цвета букв")
    let colors: [UIColor] = [
        UIColor(red: 0.86, green: 0.08, blue: 0.24, alpha: 1.0),
        UIColor(red: 0.00, green: 0.75, blue: 1.00, alpha: 1.0),
        UIColor(red: 0.31, green: 0.88, blue: 0.47, alpha: 1.0),
        UIColor(red: 0.58, green: 0.00, blue: 0.83, alpha: 1.0),
        UIColor(red: 1.00, green: 0.55, blue: 0.00, alpha: 1.0),
        UIColor(red: 1.00, green: 0.08, blue: 0.58, alpha: 1.0),
        UIColor(red: 1.00, green: 0.92, blue: 0.16, alpha: 1.0),
        UIColor.black,
        UIColor(red: 0.46, green: 0.50, blue: 0.23, alpha: 1.0),
        UIColor(red: 0.65, green: 0.16, blue: 0.16, alpha: 1.0),
        UIColor.gray,
        UIColor(red: 0.06, green: 0.32, blue: 0.73, alpha: 1.0)
    ]
    var colorButtons: [UIButton] = []
    var selectedColors: Set<UIColor> = []
    var lettersColorStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    let sizeLettersLabel = UILabel(text: "размер букв")
    
    let sizeStepper: UIStepper = {
        let sizeStepper = UIStepper()
        sizeStepper.minimumValue = 10
        sizeStepper.maximumValue = 26
        sizeStepper.stepValue = 1
        sizeStepper.value = 15
        return sizeStepper
    }()
    
    let lettersLabel = UILabel(text: "Аа")
    
    let letterBaseLabel = UILabel(text: "подложка для букв")
    let letterBaseSwitch = UISwitch()
    
    var backgroundColorLabel = UILabel(text: "цвет фона")
    let backgroundColorSC: UISegmentedControl = {
        let backgroundColorSC = UISegmentedControl()
        backgroundColorSC.insertSegment(withTitle: "Белый", at: 0, animated: false)
        backgroundColorSC.insertSegment(withTitle: "Серый", at: 1, animated: false)
        backgroundColorSC.insertSegment(withTitle: "Черный", at: 2, animated: false)
        backgroundColorSC.selectedSegmentIndex = 0
        return backgroundColorSC
    }()
    
    var positionLabel = UILabel(text: "расположение слова на экране")
    let positionSC: UISegmentedControl = {
        let positionSC = UISegmentedControl()
        positionSC.insertSegment(withTitle: "Случайное", at: 0, animated: false)
        positionSC.insertSegment(withTitle: "По центру", at: 1, animated: false)
        positionSC.selectedSegmentIndex = 0
        return positionSC
    }()

    required init(settings:AppSettings) {
        super.init(frame: CGRect())
        self.appSettings = settings
        setViews()
        setConstraints()
    }

    init() {
        super.init(frame: CGRect())
        setViews()
        setConstraints()
    }
    
    func setViews() {
        backgroundColor = .systemGray6
        
        backgroundColorLabel.textAlignment = .left
        positionLabel.textAlignment = .left
        addActions()
    }
    
    private func setupColorButtons() -> UIStackView {
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 10
        
        let firstRow = UIStackView()
        firstRow.axis = .horizontal
        firstRow.distribution = .fillEqually
        firstRow.spacing = 8
        
        let secondRow = UIStackView()
        secondRow.axis = .horizontal
        secondRow.distribution = .fillEqually
        secondRow.spacing = 8
        
        for i in 0..<12 {
            let button = UIButton()
            button.backgroundColor = colors[i]
            button.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button.widthAnchor.constraint(equalToConstant: 30).isActive = true
            button.layer.cornerRadius = 15
            button.clipsToBounds = true
            button.addTarget(self, action: #selector(colorButtonTapped), for: .touchUpInside)
            
            if i < 6 {
                firstRow.addArrangedSubview(button)
            } else {
                secondRow.addArrangedSubview(button)
            }
            
            colorButtons.append(button)
        }
        
        verticalStackView.addArrangedSubview(firstRow)
        verticalStackView.addArrangedSubview(secondRow)
        
        return verticalStackView
    }
    
    
    // MARK: - Constraints
    func setConstraints() {
        
        // Создание стеков для каждой настройки с горизонтальной ориентацией
        let gameTimeStack = UIStackView(
            views: [gameTimeLabel, gameTimeSlider, numberGameTime]
        )
        
        let changeRateStack = UIStackView(
            views: [changeRateLabel, changeRateSlider, numberChangeRate]
        )
        
        let checkTaskStack = UIStackView(
            views: [checkTaskLabel, checkTaskSwitch]
        )
        
        let lettersColorStack = UIStackView(
            views: [lettersColor, lettersColorStack]
        )
        
        let sizeLettersStack = UIStackView(
            views: [sizeLettersLabel, sizeStepper, lettersLabel]
        )
        
        let lettersBaseStack = UIStackView(
            views: [letterBaseLabel, letterBaseSwitch]
        )
        
        let backgroundColorSСStack: UIStackView = {
            let backgroundColorSСStack = UIStackView(views: [backgroundColorLabel ,backgroundColorSC])
            backgroundColorSСStack.axis = .vertical
            backgroundColorSСStack.alignment = .fill
            return backgroundColorSСStack
        }()
        
        let positionSCStack: UIStackView = {
            let positionSCStack = UIStackView(views: [positionLabel, positionSC])
            positionSCStack.axis = .vertical
            positionSCStack.alignment = .fill
            return positionSCStack
        }()
        
        let colorButtonStack = setupColorButtons()
        lettersColorStack.addArrangedSubview(colorButtonStack)
        addSubview(lettersColorStack)
        
        // Создание общего вертикального стека для объединения всех настроек
        let settingsStack: UIStackView = {
            let settingsStack = UIStackView(
                views: [gameTimeStack, changeRateStack, checkTaskStack, lettersColorStack, sizeLettersStack, lettersBaseStack, backgroundColorSСStack, positionSCStack])
            settingsStack.axis = .vertical
            settingsStack.alignment = .fill
            settingsStack.backgroundColor = .clear
            return settingsStack
        }()
        
        addSubview(settingsStack)
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка constraints для settingsStack
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            settingsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
        
        // Установка ширины для слайдеров
        gameTimeSlider.widthAnchor.constraint(equalToConstant: 110).isActive = true
        changeRateSlider.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    private func addActions() {
        gameTimeSlider.addTarget(self, action: #selector(gameTimeSliderChanged), for: .valueChanged)
        changeRateSlider.addTarget(self, action: #selector(changeRateSliderChanged), for: .valueChanged)
        checkTaskSwitch.addTarget(self, action: #selector(checkTaskSwitchChanged), for: .valueChanged)
    }
    
    @objc private func gameTimeSliderChanged(_ sender: UISlider) {
        numberGameTime.text = String(format: "%.0f", sender.value)
        onGameTimeChanged?(sender.value)
    }
    
    @objc private func changeRateSliderChanged(_ sender: UISlider) {
        numberChangeRate.text = String(format: "%.0f", sender.value)
        onChangeRateChanged?(sender.value)
    }
    
    @objc private func checkTaskSwitchChanged(_ sender: UISwitch) {
        onCheckTaskChanged?(sender.isOn)
    }
    
    
    @objc private func colorButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sender.isSelected {
            sender.setImage(UIImage(systemName: "checkmark")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .selected)
        } else {
            sender.setImage(nil, for: .normal)
        }
        
        // Дополнительная логика при выборе цвета
    }
}

//import SwiftUI
//
//struct SettingsViewProvider: PreviewProvider {
//    static var previews: some View {
//        ContainerView().edgesIgnoringSafeArea(.all)
//    }
//
//    struct ContainerView: UIViewRepresentable {
//        let view = SettingsView()
//
//        func makeUIView(context: UIViewRepresentableContext<SettingsViewProvider.ContainerView>) -> some UIView {
//            return view
//        }
//
//        func updateUIView(_ uiView: UIViewType, context: Context) { }
//    }
//
//}

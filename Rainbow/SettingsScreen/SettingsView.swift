//
//  SettingsView.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

class SettingsView: UIView {
    
    let gameTimeLabel = UILabel(text: "время игры, мин", font: .systemFont(ofSize: 18))
    let gameTimeSlider = UISlider(maximumValue: 20, value: 10)
    let numberGameTime = UILabel(text: "10", font: .systemFont(ofSize: 18))
    
    let changeRateLabel = UILabel(text: "скорость смены заданий, сек", font: .systemFont(ofSize: 18))
    let changeRateSlider = UISlider(maximumValue: 4, value: 2)
    let numberChangeRate = UILabel(text: "2", font: .systemFont(ofSize: 18))
    
    let checkTaskLabel = UILabel(text: "игра с проверкой заданий", font: .systemFont(ofSize: 18))
    let checkTaskSwitch = UISwitch()
    
    let sizeLettersLabel = UILabel(text: "размер букв", font: .systemFont(ofSize: 18))
    let sizeStepper = UIStepper()
    let lettersLabel = UILabel(text: "Аа", font: .systemFont(ofSize: 18))
    
    let letterBaseLabel = UILabel(text: "подложка для букв", font: .systemFont(ofSize: 18))
    let letterBaseSwitch = UISwitch()
    
    var backgroundColorLabel = UILabel(text: "цвет фона", font: .systemFont(ofSize: 18))
    let backgroundColorSC = UISegmentedControl()
    
    var positionLabel = UILabel(text: "расположение слова на экране", font: .systemFont(ofSize: 18))
    let positionSC = UISegmentedControl()
    
    init() {
        super.init(frame: CGRect())
        setViews()
        setConstraints()
    }
    
    func setViews() {
        backgroundColor = .systemGray6
        
        checkTaskLabel.numberOfLines = 0
        changeRateLabel.numberOfLines = 0
        
        sizeStepper.minimumValue = 10
        sizeStepper.maximumValue = 36
        sizeStepper.stepValue = 1
        
        backgroundColorSC.insertSegment(withTitle: "Белый", at: 0, animated: false)
        backgroundColorSC.insertSegment(withTitle: "Серый", at: 1, animated: false)
        backgroundColorSC.insertSegment(withTitle: "Черный", at: 1, animated: false)
        backgroundColorSC.selectedSegmentIndex = 0
        backgroundColorLabel.textAlignment = .left
        
        positionSC.insertSegment(withTitle: "Случайное", at: 0, animated: false)
        positionSC.insertSegment(withTitle: "По центру", at: 1, animated: false)
        positionSC.selectedSegmentIndex = 0
        positionLabel.textAlignment = .left
    }
    
    // MARK: - Constraints
    func setConstraints() {
        // Создание стеков для каждой настройки с горизонтальной ориентацией
        let gameTimeStack = UIStackView(
            views: [gameTimeLabel, gameTimeSlider, numberGameTime],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 8,
            alignment: .center
        )
        
        let changeRateStack = UIStackView(
            views: [changeRateLabel, changeRateSlider, numberChangeRate],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 8,
            alignment: .center
        )
        
        let checkTaskStack = UIStackView(
            views: [checkTaskLabel, checkTaskSwitch],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 8,
            alignment: .center
        )
        
        let sizeLettersStack = UIStackView(
            views: [sizeLettersLabel, sizeStepper, lettersLabel],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 8,
            alignment: .center
        )
        
        let lettersBaseStack = UIStackView(
            views: [letterBaseLabel, letterBaseSwitch],
            axis: .horizontal,
            distribution: .equalSpacing,
            spacing: 8,
            alignment: .center
        )
        
        let backgroundColorSСStack = UIStackView(
            views: [backgroundColorLabel ,backgroundColorSC],
            axis: .vertical,
            distribution: .equalSpacing,
            spacing: 10,
            alignment: .fill
        )
        
        let positionSCStack = UIStackView(
            views: [positionLabel, positionSC],
            axis: .vertical,
            distribution: .equalSpacing,
            spacing: 10,
            alignment: .fill
        )
        
        // Создание общего вертикального стека для объединения всех настроек
        let settingsStack = UIStackView(
            views: [gameTimeStack, changeRateStack, checkTaskStack, sizeLettersStack, lettersBaseStack, backgroundColorSСStack, positionSCStack],
            axis: .vertical,
            distribution: .equalSpacing,
            spacing: 50,
            alignment: .fill
        )
        
        // Создание подложки
        let backgroundViewForGameTimeStack = UIView()
        backgroundViewForGameTimeStack.backgroundColor = .white
        backgroundViewForGameTimeStack.layer.cornerRadius = 15
        
        let backgroundViewForChangeRateStack = UIView()
        backgroundViewForChangeRateStack.backgroundColor = .white
        backgroundViewForChangeRateStack.layer.cornerRadius = 15
        
        let backgroundViewForcheckTaskStack = UIView()
        backgroundViewForcheckTaskStack.backgroundColor = .white
        backgroundViewForcheckTaskStack.layer.cornerRadius = 15
        
        let backgroundViewForSizeLettersStack = UIView()
        backgroundViewForSizeLettersStack.backgroundColor = .white
        backgroundViewForSizeLettersStack.layer.cornerRadius = 15
        
        let backgroundViewForletterBaseStack = UIView()
        backgroundViewForletterBaseStack.backgroundColor = .white
        backgroundViewForletterBaseStack.layer.cornerRadius = 15
        
        let backgroundViewForColorSСStackS = UIView()
        backgroundViewForColorSСStackS.backgroundColor = .white
        backgroundViewForColorSСStackS.layer.cornerRadius = 15
        
        let backgroundViewForPositionSCStack = UIView()
        backgroundViewForPositionSCStack.backgroundColor = .white
        backgroundViewForPositionSCStack.layer.cornerRadius = 15

        addSubview(backgroundViewForGameTimeStack)
        addSubview(backgroundViewForChangeRateStack)
        addSubview(backgroundViewForcheckTaskStack)
        addSubview(backgroundViewForSizeLettersStack)
        addSubview(backgroundViewForletterBaseStack)
        addSubview(backgroundViewForColorSСStackS)
        addSubview(backgroundViewForPositionSCStack)
        addSubview(settingsStack)
        
        backgroundViewForChangeRateStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForGameTimeStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForcheckTaskStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForSizeLettersStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForletterBaseStack.translatesAutoresizingMaskIntoConstraints = false
        backgroundColorSC.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForColorSСStackS.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForPositionSCStack.translatesAutoresizingMaskIntoConstraints = false
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        // Установка constraints для подложки
        NSLayoutConstraint.activate([
            backgroundViewForGameTimeStack.topAnchor.constraint(equalTo: gameTimeStack.topAnchor, constant: -20),
            backgroundViewForGameTimeStack.leadingAnchor.constraint(equalTo: gameTimeStack.leadingAnchor, constant: -20),
            backgroundViewForGameTimeStack.trailingAnchor.constraint(equalTo: gameTimeStack.trailingAnchor, constant: 20),
            backgroundViewForGameTimeStack.bottomAnchor.constraint(equalTo: gameTimeStack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backgroundViewForChangeRateStack.topAnchor.constraint(equalTo: changeRateStack.topAnchor, constant: -20),
            backgroundViewForChangeRateStack.leadingAnchor.constraint(equalTo: changeRateStack.leadingAnchor, constant: -20),
            backgroundViewForChangeRateStack.trailingAnchor.constraint(equalTo: changeRateStack.trailingAnchor, constant: 20),
            backgroundViewForChangeRateStack.bottomAnchor.constraint(equalTo: changeRateStack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backgroundViewForcheckTaskStack.topAnchor.constraint(equalTo: checkTaskStack.topAnchor, constant: -20),
            backgroundViewForcheckTaskStack.leadingAnchor.constraint(equalTo: checkTaskStack.leadingAnchor, constant: -20),
            backgroundViewForcheckTaskStack.trailingAnchor.constraint(equalTo: checkTaskStack.trailingAnchor, constant: 20),
            backgroundViewForcheckTaskStack.bottomAnchor.constraint(equalTo: checkTaskStack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backgroundViewForSizeLettersStack.topAnchor.constraint(equalTo: sizeLettersStack.topAnchor, constant: -20),
            backgroundViewForSizeLettersStack.leadingAnchor.constraint(equalTo: sizeLettersStack.leadingAnchor, constant: -20),
            backgroundViewForSizeLettersStack.trailingAnchor.constraint(equalTo: sizeLettersStack.trailingAnchor, constant: 20),
            backgroundViewForSizeLettersStack.bottomAnchor.constraint(equalTo: sizeLettersStack.bottomAnchor, constant: 20)
        ])
        
        
        NSLayoutConstraint.activate([
            backgroundViewForletterBaseStack.topAnchor.constraint(equalTo: lettersBaseStack.topAnchor, constant: -20),
            backgroundViewForletterBaseStack.leadingAnchor.constraint(equalTo: lettersBaseStack.leadingAnchor, constant: -20),
            backgroundViewForletterBaseStack.trailingAnchor.constraint(equalTo: lettersBaseStack.trailingAnchor, constant: 20),
            backgroundViewForletterBaseStack.bottomAnchor.constraint(equalTo: lettersBaseStack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backgroundViewForColorSСStackS.topAnchor.constraint(equalTo: backgroundColorSСStack.topAnchor, constant: -20),
            backgroundViewForColorSСStackS.leadingAnchor.constraint(equalTo: backgroundColorSСStack.leadingAnchor, constant: -20),
            backgroundViewForColorSСStackS.trailingAnchor.constraint(equalTo: backgroundColorSСStack.trailingAnchor, constant: 20),
            backgroundViewForColorSСStackS.bottomAnchor.constraint(equalTo: backgroundColorSСStack.bottomAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            backgroundViewForPositionSCStack.topAnchor.constraint(equalTo: positionSCStack.topAnchor, constant: -20),
            backgroundViewForPositionSCStack.leadingAnchor.constraint(equalTo: positionSCStack.leadingAnchor, constant: -20),
            backgroundViewForPositionSCStack.trailingAnchor.constraint(equalTo: positionSCStack.trailingAnchor, constant: 20),
            backgroundViewForPositionSCStack.bottomAnchor.constraint(equalTo: positionSCStack.bottomAnchor, constant: 20)
        ])
        
        // Установка constraints для settingsStack
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            settingsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ])
        
        // Установка ширины для слайдеров
        gameTimeSlider.widthAnchor.constraint(equalToConstant: 150).isActive = true
        changeRateSlider.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI

struct SettingsViewProvider: PreviewProvider {
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewRepresentable {
        let view = SettingsView()
        
        func makeUIView(context: UIViewRepresentableContext<SettingsViewProvider.ContainerView>) -> some UIView {
            return view
        }
        
        func updateUIView(_ uiView: UIViewType, context: Context) { }
    }
    
}

//
//  SettingsView.swift
//  Rainbow
//
//  Created by Валентина Попова on 13.11.2023.
//

import UIKit

class SettingsView: UIView {
    
    let settingsLabel = UILabel(text: "Настройки", font: .systemFont(ofSize: 30))
    let backButton = UIButton(type: .system)
    let gameTimeLabel = UILabel(text: "время игры, мин", font: .systemFont(ofSize: 18))
    let gameTimeSlider = UISlider(maximumValue: 20, value: 10)
    let numberGameTime = UILabel(text: "10", font: .systemFont(ofSize: 18))
    let changeRateLabel = UILabel(text: "скорость смены заданий, сек", font: .systemFont(ofSize: 18))
    let changeRateSlider = UISlider(maximumValue: 4, value: 2)
    let numberChangeRate = UILabel(text: "2", font: .systemFont(ofSize: 18))
    let letterBaseLabel = UILabel(text: "подложка для букв", font: .systemFont(ofSize: 18))
    let letterBaseSwitch = UISwitch()
    
    init() {
        super.init(frame: CGRect())
        setViews()
        setConstraints()
    }
    
    func setViews() {
        backgroundColor = .lightGray
        backButton.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
        backButton.tintColor = .black
        changeRateLabel.numberOfLines = 0 // ??
    }
    
    func setConstraints() {
        // Создание стеков для каждой настройки с горизонтальной ориентацией
        let titleStack = UIStackView(arrangedSubviews: [backButton, settingsLabel])
        titleStack.axis = .horizontal
        titleStack.distribution = .fill
        titleStack.alignment = .center
        titleStack.spacing = 8
        
        let gameTimeStack = UIStackView(arrangedSubviews: [gameTimeLabel, gameTimeSlider, numberGameTime])
        gameTimeStack.axis = .horizontal
        gameTimeStack.distribution = .equalSpacing
        gameTimeStack.alignment = .center
        gameTimeStack.spacing = 8
        
        let changeRateStack = UIStackView(arrangedSubviews: [changeRateLabel, changeRateSlider, numberChangeRate])
        changeRateStack.axis = .horizontal
        changeRateStack.distribution = .equalSpacing
        changeRateStack.alignment = .center
        changeRateStack.spacing = 8
        
        let letterBaseStack = UIStackView(arrangedSubviews: [letterBaseLabel, letterBaseSwitch])
        letterBaseStack.axis = .horizontal
        letterBaseStack.distribution = .equalSpacing
        letterBaseStack.alignment = .center
        letterBaseStack.spacing = 8
        
        // Создание общего вертикального стека для объединения всех настроек
        let settingsStack = UIStackView(arrangedSubviews: [titleStack, gameTimeStack, changeRateStack, letterBaseStack])
        settingsStack.axis = .vertical
        settingsStack.distribution = .equalSpacing
        settingsStack.alignment = .fill
        settingsStack.spacing = 20
        
        // Добавление стека на view и установка constraints
        addSubview(settingsStack)
        settingsStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            settingsStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            settingsStack.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            settingsStack.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
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

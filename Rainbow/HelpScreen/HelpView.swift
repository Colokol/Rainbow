//
//  HelpView.swift
//  Rainbow
//
//  Created by Vadim Zhelnov on 16.11.23.
//

import UIKit
class HelpView:UIView{
    // MARK: - UI Components
    let titleLabel:UILabel = {
        let label = UILabel()
        label.text = "ПРАВИЛА ИГРЫ"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        label.textColor = #colorLiteral(red: 0.7453480363, green: 0.1811536551, blue: 0.4145424068, alpha: 1)
        return label
    }()
    let firstParagraphLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.halfTextColorChange(fullText: "\n На экране в случайном месте появляется слово, обозначающее цвет, например: написано «синий»:", changeText: "синий")
        label.numberOfLines = 0
        return label
    }()
    let offSubstrateLabel:UILabel = {
        let label = UILabel()
        label.text = "подложка выключена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let onSubstrateLabel:UILabel = {
        let label = UILabel()
        label.text = "подложка включена"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    let colorLabelWithoutBackground:UILabel = {
        let label = UILabel()
        label.text = "синий"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = #colorLiteral(red: 0.3273850083, green: 0.8701838851, blue: 0.1311967969, alpha: 1)
        return label
    }()
    let colorLabelWithBackground:UILabel = {
        let label = UILabel()
        label.text = "синий"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.textColor = #colorLiteral(red: 0.9999999404, green: 1, blue: 1, alpha: 1)
        label.backgroundColor = #colorLiteral(red: 0.3273850083, green: 0.8701838851, blue: 0.1311967969, alpha: 1)
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    let secondParagraphLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .left
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.halfTextColorChange(fullText: "Нужно произнести вслух цвет слова (если опция «подложка для букв» выключена) или цвет фона, на котором написано слово (если опция «подложка для букв» включена): говорим «зеленый». \n\n В игре можно изменять скорость от 1x до 5x. А так же длительность игры.", changeText: "говорим «зеленый»")
        label.numberOfLines = 0
        return label
    }()
    
   
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9725490212, green: 0.9725490212, blue: 0.9725490212, alpha: 1)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Setup
    private func setupView(){
        self.addSubview(titleLabel)
        self.addSubview(firstParagraphLabel)
        self.addSubview(offSubstrateLabel)
        self.addSubview(onSubstrateLabel)
        self.addSubview(colorLabelWithoutBackground)
        self.addSubview(colorLabelWithBackground)
        self.addSubview(secondParagraphLabel)
       
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        firstParagraphLabel.translatesAutoresizingMaskIntoConstraints = false
        offSubstrateLabel.translatesAutoresizingMaskIntoConstraints = false
        onSubstrateLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabelWithoutBackground.translatesAutoresizingMaskIntoConstraints = false
        colorLabelWithBackground.translatesAutoresizingMaskIntoConstraints = false
        secondParagraphLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 35),
            titleLabel.widthAnchor.constraint(equalToConstant: 225),
            titleLabel.heightAnchor.constraint(equalToConstant: 21),
            
            firstParagraphLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            firstParagraphLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 26),
            firstParagraphLabel.widthAnchor.constraint(equalToConstant: 263),
            firstParagraphLabel.heightAnchor.constraint(equalToConstant: 165),
            
            offSubstrateLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 190),
            offSubstrateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 12),
            offSubstrateLabel.widthAnchor.constraint(equalToConstant: 118),
            offSubstrateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            onSubstrateLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 190),
            onSubstrateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 157),
            onSubstrateLabel.widthAnchor.constraint(equalToConstant: 118),
            onSubstrateLabel.heightAnchor.constraint(equalToConstant: 20),
            
            colorLabelWithoutBackground.topAnchor.constraint(equalTo: self.topAnchor,constant: 220),
            colorLabelWithoutBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 28),
            colorLabelWithoutBackground.widthAnchor.constraint(equalToConstant: 95.22),
            colorLabelWithoutBackground.heightAnchor.constraint(equalToConstant: 26),
            
            colorLabelWithBackground.topAnchor.constraint(equalTo: self.topAnchor,constant: 220),
            colorLabelWithBackground.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 167),
            colorLabelWithBackground.widthAnchor.constraint(equalToConstant: 95.22),
            colorLabelWithBackground.heightAnchor.constraint(equalToConstant: 26),
            
            secondParagraphLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 286),
            secondParagraphLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 26),
            secondParagraphLabel.widthAnchor.constraint(equalToConstant: 258),
            secondParagraphLabel.heightAnchor.constraint(equalToConstant: 303),
        ])
    }
 
}
extension UILabel {
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.attributedText = attribute
    }
}

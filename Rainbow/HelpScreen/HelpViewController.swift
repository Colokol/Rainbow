//
//  HelpViewController.swift
//  Rainbow
//
//  Created by Vadim Zhelnov on 16.11.23.
//

import UIKit
class HelpViewController:UIViewController{
    // MARK: - UI Components
    
        let helpView = HelpView()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.8000000119, green: 0.8000000119, blue: 0.8000000119, alpha: 1)
        title = "Помощь"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "vector"), style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 30)!]
        setupView()
    }
    //MARK: - UI Setup
    
    private func setupView(){
        view.addSubview(helpView)
        
        helpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helpView.topAnchor.constraint(equalTo: view.topAnchor,constant: 160),
            helpView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 40),
            helpView.widthAnchor.constraint(equalToConstant: 298),
            helpView.heightAnchor.constraint(equalToConstant: 589)
        ])
    }
}

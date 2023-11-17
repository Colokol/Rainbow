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
        view.backgroundColor = .systemGray4
        title = "Помощь"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: self,action: #selector(backButtonPress))
        navigationItem.leftBarButtonItem?.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 30)!]
        setupView()
    }
    //MARK: - UI Setup
    @objc func backButtonPress() {
        navigationController?.popToRootViewController(animated: true)
    }

    private func setupView(){
        view.addSubview(helpView)
        
        helpView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            helpView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            helpView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            helpView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            helpView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        ])
    }
}

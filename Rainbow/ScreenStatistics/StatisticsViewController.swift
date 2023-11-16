//
//  StatisticsViewController.swift
//  Rainbow
//
//  Created by Дмитрий on 16.11.2023.
//

import UIKit

class StatisticsViewController: UIViewController {

    let tableStatistics = UITableView()

    let clearButton: UIButton = {
        let button = UIButton()

        button.setTitle("Очистить статистику", for: .normal)
        button.backgroundColor = .cyan
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Статистика"
        
        let buttonBack = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"), style: .plain, target: self, action: nil)
        navigationController?.navigationItem.leftBarButtonItem = buttonBack

        tableStatistics.delegate = self
        tableStatistics.dataSource = self
        tableStatistics.register(UITableViewCell.self, forCellReuseIdentifier: "CellSample")
        view.addSubview(tableStatistics)

        view.addSubview(clearButton)

        NSLayoutConstraint.activate([
            clearButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80),
            clearButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableStatistics.frame = view.bounds
    }
}


extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellSample", for: indexPath)

        cell.textLabel?.text = "345"
        return cell
    }
    

}









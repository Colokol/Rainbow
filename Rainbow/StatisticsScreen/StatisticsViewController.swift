//
//  StatisticsViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 14.11.23.
//

import UIKit
import CoreData

class StatisticsViewController: UIViewController {

    var gameResult:[GamesResult] = []
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext


    let tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "arrowshape.backward.fill"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(backButtonPress))
        backButton.tintColor = .black

        navigationItem.leftBarButtonItem = backButton
        navigationController?.navigationItem.hidesBackButton = true

        configureTableView()
        loadData()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GameResultTableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
    }

    private func loadData(){

            let request: NSFetchRequest<GamesResult> = GamesResult.fetchRequest()
            do{
                let data = try self.context.fetch(request)
                DispatchQueue.main.async {

                    self.gameResult = data.reversed()
                    self.tableView.reloadData()
                }
            }catch {
                print("Error")
            }
    }

    @objc func backButtonPress() {
        navigationController?.popToRootViewController(animated: true)
    }

}

// MARK: - TableView Method

extension StatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameResult.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? GameResultTableViewCell else {return UITableViewCell()}
        let numberGame = gameResult.count - indexPath.row
        cell.configureCell(game: gameResult[indexPath.row], gameNumber: numberGame)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

}

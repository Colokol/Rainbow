//
//  MenuViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit

class MenuViewController: UIViewController {

  //  private var mainView: MenuView {self.view as! MenuView}

    override func loadView() {
        self.view = MenuView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

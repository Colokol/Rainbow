//
//  MenuViewController.swift
//  Rainbow
//
//  Created by Uladzislau Yatskevich on 10.11.23.
//

import UIKit

class MenuViewController: UIViewController {

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: Constants.logoImage)
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setConstraints()
    }

    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(imageView)
    }


}

// MARK: - Constraints
extension MenuViewController {

    private func setConstraints(){
        NSLayoutConstraint.activate([

            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: view.frame.width * 0.8),
            imageView.heightAnchor.constraint(equalToConstant: 150)

        ])
    }

}

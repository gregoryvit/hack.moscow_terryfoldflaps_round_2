//
//  ProfileViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet private weak var label: UILabel!

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Configure

private extension ProfileViewController {

    func setupInitialState() {
        view.backgroundColor = ColorName.main
        navigationController?.applyDarkBarStyle()
        label.text = "Профиль".localized()
    }

}

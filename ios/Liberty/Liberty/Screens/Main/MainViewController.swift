//
//  MainViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Configure

private extension MainViewController {

    func setupInitialState() {
        view.backgroundColor = ColorName.main
        navigationController?.applyDarkBarStyle()
    }

}

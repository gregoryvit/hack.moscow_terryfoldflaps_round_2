//
//  ChatViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 26/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialState()
    }

}

// MARK: - Configure

private extension ChatViewController {

    func setupInitialState() {
        view.backgroundColor = ColorName.main
        navigationController?.applyDarkBarStyle()
    }

}

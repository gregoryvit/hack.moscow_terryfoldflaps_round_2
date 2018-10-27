//
//  PersonView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

final class PersonView: DesignableView {

    // MARK: - IBOutlets

    @IBOutlet private weak var personIconImageView: UIImageView!
    @IBOutlet private weak var personName: UILabel!
    @IBOutlet private weak var personPosition: UILabel!
    @IBOutlet private weak var retryButton: UIButton!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

}

// MARK: - Configure

private extension PersonView {

    func setupInitialState() {

    }

}

// MARK: - Actions

private extension PersonView {

    @IBAction func retryButtonDidPressed(_ sender: Any) {
    }

}

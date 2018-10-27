//
//  PersonView.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import AlamofireImage

final class PersonView: DesignableView {

    // MARK: - Constants

    private struct Constants {
        static let containerCornerRadius: CGFloat = 6.0

        // Colors
        static let shadowColor: UIColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 1.0)
        static let shadowOpacity: Float = 0.25
        static let shadowOffset: CGSize = CGSize(width: 0.0, height: 20.0)
        static let shadowRadius: CGFloat = 50.0
    }


    // MARK: - IBOutlets

    @IBOutlet private weak var personIconImageView: UIImageView!
    @IBOutlet private weak var personIconContainer: UIView!
    @IBOutlet private weak var personName: UILabel!
    @IBOutlet private weak var personPosition: UILabel!
    @IBOutlet private weak var retryButton: UIButton!

    // MARK: - UIView

    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialState()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInitialState()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - Configure

    func configure(viewModel: PersonViewModel) {
        personName.text = viewModel.personName
        personPosition.text = viewModel.personPosition
        downloadPersonIcon(urlString: viewModel.personIconUrl)
    }

}

// MARK: - Configure

private extension PersonView {

    func setupInitialState() {
        configureContainerView()
        configureLabels()
        configureImageView()
    }

    func configureContainerView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = Constants.containerCornerRadius
        view.layer.masksToBounds = true

        view.dropShadow(color: Constants.shadowColor,
                        opacity: Constants.shadowOpacity,
                        offSet: Constants.shadowOffset,
                        radius: Constants.shadowRadius,
                        scale: true)
    }

    func configureLabels() {
        personName.textColor = .black
        personName.font = UIFont.systemFont(ofSize: 16.0, weight: .medium)
        personName.text = nil

        personPosition.textColor = .black
        personPosition.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        personPosition.text = nil
    }

    func configureImageView() {
        personIconImageView.contentMode = .scaleAspectFill
        personIconImageView.layer.cornerRadius = personIconImageView.frame.height / 2
        personIconImageView.layer.masksToBounds = true
        personIconContainer.backgroundColor = ColorName.iconPlaceholder
        personIconContainer.layer.cornerRadius = personIconContainer.frame.height / 2
        personIconContainer.layer.masksToBounds = true
    }

}

// MARK: - Help Methods

private extension PersonView {

    func downloadPersonIcon(urlString: String?) {
        guard let url = URL(string: urlString ?? "") else { return }
        personIconImageView.af_setImage(withURL: url)
    }

}

// MARK: - Actions

private extension PersonView {

    @IBAction func retryButtonDidPressed(_ sender: Any) {
    }

}

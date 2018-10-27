//
//  FakeViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit

class FakeViewController: UIViewController {

    @IBOutlet private weak var blackTransparentView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        blackTransparentView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        blackTransparentView.alpha = 0
        blackTransparentView.isUserInteractionEnabled = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    @IBAction func tapOnOpenButton(_ sender: Any) {
        let detailsView = DetailsViewController()
        detailsView.modalTransitionStyle = .coverVertical
        detailsView.modalPresentationStyle = .overCurrentContext
        detailsView.onDismiss = { [weak self] in
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.blackTransparentView.alpha = 0
            }
        }
        present(detailsView, animated: true, completion: nil)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.blackTransparentView.alpha = 1
        }
    }

}

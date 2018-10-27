//
//  FakeViewController.swift
//  Liberty
//
//  Created by Vlad Krupenko on 27/10/2018.
//  Copyright © 2018 Olferuk. All rights reserved.
//

import UIKit
import CoreLocation

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
        let zeroCell: DetailsTableCellType = .person(generateTestPerson())
        let firstCell: DetailsTableCellType = .store(generateTestStores(), "Продается в магазинах")
        let reviewCell: DetailsTableCellType = .bestReview(generateTestReview())
        let secondCell: DetailsTableCellType = .social(generateTestSocials(), "Социальные сети")
        let thirdCell: DetailsTableCellType = .makeFriends
        let booksCell: DetailsTableCellType = .similarBooks(generateTestBooks(), "Похожие книги")
        let changeProfile: DetailsTableCellType = .changeProfile
        detailsView.configure(with: [zeroCell, firstCell, reviewCell, secondCell, thirdCell, booksCell, changeProfile])

        present(detailsView, animated: true, completion: nil)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.blackTransparentView.alpha = 1
        }
    }

}

// MARK: - Private Methods

private extension FakeViewController {

    func generateTestStores() -> [StoreViewModel] {
        let model1 = StoreViewModel(id: "1", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fbb/NpM3VBu1nL4.jpg", price: "2 465 ₽", position: nil, deliveryAvailable: true)
        let model2 = StoreViewModel(id: "2", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc2/MbRM76AF4mE.jpg", price: "2 765 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        let model3 = StoreViewModel(id: "3", name: "", iconUrl: "https://pp.userapi.com/c849324/v849324177/a7fc9/iipk0jdZX0M.jpg", price: "2 832 ₽", position: CLLocationCoordinate2D(latitude: 0, longitude: 0), deliveryAvailable: true)
        return [model1, model2, model3]
    }

    func generateTestSocials() -> [SocialViewModel] {
        let model1 = SocialViewModel(name: "Twitter", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b54/TnEfxqSiPhs.jpg")
        let model2 = SocialViewModel(name: "Instagram", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b46/gRJwvj69hMM.jpg")
        let model3 = SocialViewModel(name: "Facebook", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b4d/qxyrgyBoUag.jpg")
        let model4 = SocialViewModel(name: "Vk", iconUrl: "https://pp.userapi.com/c849036/v849036177/a7b5b/xtCAzOXxMEg.jpg")
        return [model1, model2, model3, model4]
    }

    func generateTestPerson() -> PersonDetailsViewModel {
        return PersonDetailsViewModel(avatarUrl: nil, name: "Григорий Бернгардт", work: "Surf Studio", position: "iOS Lead", description: "Занимаюсь iOS разработкой последние 6 лет. За это время поработал с большим кол-вом проектов в разного рода компаниях, стартапах, фрилансе и крупных аутсорсинговых компаниях. Сейчас возглавляю отдел iOS разработки в небольшой, но классной студии Surf.", website: "berngardt.ru")
    }

    func generateTestReview() -> ReviewViewModel {
        return ReviewViewModel(authorAvatar: nil, authorName: "Костик Ртуть", reviewSource: "ozon.ru", reviewText: "На редкость элегантное издание Тэффи. Приятные на ощупь белые плотные страницы. Хорошая подборка рассказов. Замечательно и остроумно. Книга небольшая, на вечер-другой, но выполнена очень приятно, если сомневаетесь, брать ли — хочу развеять ваши сомнения. Своих денег стоит.")
    }

    func generateTestBooks() -> [SimilarBookViewModel] {
        let book1 = SimilarBookViewModel(coverImageUrl: nil, name: "Гормоны счастья. Приучите свой мозг вырабатывать что-то там я просто не заню настоящего названия", authorName: "Бройнинг Лоретта Грациано")
        let book2 = SimilarBookViewModel(coverImageUrl: nil, name: "Дизайн привычных вещей", authorName: "Норман Дональд")
        let book3 = SimilarBookViewModel(coverImageUrl: nil, name: "Психология искусства", authorName: "Иржи Кулка")
        return [book1, book2, book3]
    }
}

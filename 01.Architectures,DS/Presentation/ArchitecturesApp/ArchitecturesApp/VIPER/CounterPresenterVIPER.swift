//
//  CounterPresenterVIPER.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation

protocol CounterPresenterProtocol: AnyObject {
    var interactor: CounterInteractorInputProtocol? { get set }
    var router: CounterRouterProtocol? { get set }

    func incrementButtonTapped()
}

// presenter protocol -> actions called from View
// interactor protocol -> what to call in interactor
class CounterPresenterVIPER: CounterPresenterProtocol, CounterInteractorOutputProtocol, ObservableObject {
    var interactor: CounterInteractorInputProtocol?
    var router: CounterRouterProtocol?

    @Published var countLabel: String = "0"

    func incrementButtonTapped() {
        print("3️⃣VIPER: presenter incrementButtonTapped")
        interactor?.incrementAndSave()
    }

    func countDidUpdate(to count: Int) {
        print("3️⃣VIPER: presenter present result: \(count)")
        countLabel = "\(count)"
    }
}

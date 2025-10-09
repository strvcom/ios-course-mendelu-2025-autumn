//
//  CounterInteractorVIPER.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation

protocol CounterInteractorInputProtocol: AnyObject {
    var presenter: CounterInteractorOutputProtocol? { get set }

    func incrementAndSave()
}

protocol CounterInteractorOutputProtocol: AnyObject {
    func countDidUpdate(to count: Int)
}

class CounterInteractorVIPER: CounterInteractorInputProtocol {
    weak var presenter: CounterInteractorOutputProtocol?

    private var counter = CounterEntityVIPER(count: 0)

    func incrementAndSave() {
        print("3️⃣VIPER: interactor incrementAndSave")
        counter.count += 1
        print("3️⃣VIPER: interactor pass result into presenter")
        presenter?.countDidUpdate(to: counter.count)
    }
}

//
//  CounterInteractorVIP.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation

protocol CounterBusinessLogic: AnyObject {
    func incrementCounter()
}

class CounterInteractorVIP: CounterBusinessLogic {
    var presenter: CounterPresentationLogic?

    private var counter = CounterEntityVIP(count: 0)

    func incrementCounter() {
        print("4️⃣VIP: interactor incrementCounter")
        counter.count += 1
        print("4️⃣VIP: interactor pass result into presenter")
        presenter?.presentCount(count: counter.count)
    }
}

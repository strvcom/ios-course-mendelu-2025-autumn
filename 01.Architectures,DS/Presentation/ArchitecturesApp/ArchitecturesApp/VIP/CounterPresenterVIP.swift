//
//  CounterPresenterVIP.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation

protocol CounterPresentationLogic: AnyObject {
    func presentCount(count: Int)
}

class CounterPresenterVIP: CounterPresentationLogic, ObservableObject {
    @Published var countText: String = "0"

    func presentCount(count: Int) {
        print("4️⃣VIP: presenter present result: \(count)")
        self.countText = "\(count)"
    }
}

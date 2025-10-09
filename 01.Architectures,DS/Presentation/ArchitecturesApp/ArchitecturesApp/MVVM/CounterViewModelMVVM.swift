//
//  CounterViewModelMVVM.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import Foundation

class CounterViewModelMVVM: ObservableObject {
    @Published private(set) var count: Int = 0

    var countDisplay: String {
        "\(count)"
    }

    func incrementCounter() {
        print("2️⃣MVVM: incrementCounter")
        count += 1
    }
}

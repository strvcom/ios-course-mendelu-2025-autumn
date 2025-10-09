//
//  CounterView.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

struct CounterViewMVVM: View {
    @StateObject private var viewModel = CounterViewModelMVVM()

    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.countDisplay)
                .font(.system(size: 80, weight: .bold))

            Button("Increment") {
                print("2️⃣MVVM: button tap")
                viewModel.incrementCounter()
            }
        }
        .navigationTitle("MVVM")
    }
}

struct CounterViewMVVM_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterViewMVVM()
        }
    }
}

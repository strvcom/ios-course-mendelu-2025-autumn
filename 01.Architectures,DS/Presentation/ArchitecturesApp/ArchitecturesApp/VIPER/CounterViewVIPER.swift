//
//  CounterViewVIPER.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

struct CounterViewVIPER: View {
    @ObservedObject var presenter: CounterPresenterVIPER

    var body: some View {
        VStack(spacing: 30) {
            Text(presenter.countLabel)
                .font(.system(size: 80, weight: .bold))

            Button("Increment") {
                print("3️⃣VIPER: button tap")
                presenter.incrementButtonTapped()
            }
        }
        .navigationTitle("VIPER")
    }
}

struct CounterViewVIPER_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterRouterVIPER.createModule()
        }
    }
}

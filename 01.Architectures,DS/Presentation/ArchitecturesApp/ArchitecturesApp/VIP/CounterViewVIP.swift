//
//  CounterViewVIP.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

struct CounterViewVIP: View {
    var interactor: CounterBusinessLogic?
    @ObservedObject var presenter: CounterPresenterVIP

    var body: some View {
        VStack(spacing: 30) {
            Text(presenter.countText)
                .font(.system(size: 80, weight: .bold))

            Button("Increment") {
                print("4️⃣VIP: button tap")
                interactor?.incrementCounter()
            }
        }
        .navigationTitle("VIP")
    }
}

struct CounterViewVIP_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterRouterVIP.assembleModule()
        }
    }
}

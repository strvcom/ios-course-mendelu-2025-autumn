//
//  CounterViewMVC.swift
//  ArchitecturesApp
//
//  Created by Martin Vidovic on 04.10.2025.
//

import SwiftUI

struct CounterViewMVC: View {
    @State private var count: Int = 0

    var body: some View {
        VStack(spacing: 30) {
            Text("\(count)")
                .font(.system(size: 80, weight: .bold))

            Button("Increment") {
                incrementCounter()
            }
        }
        .navigationTitle("MVC")
    }

    private func incrementCounter() {
        print("1️⃣MVC: incrementCounter")
        count += 1
    }
}

struct CounterViewMVC_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CounterViewMVC()
        }
    }
}

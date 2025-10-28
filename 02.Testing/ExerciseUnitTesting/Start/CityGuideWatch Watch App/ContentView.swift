//
//  ContentView.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import SwiftUI

struct ContentView: View {
    private let container = DIContainer.shared

    var body: some View {
        ListView(
            viewModel: MapPlacesViewModel(
                dataManager: container.resolve(),
                locationManager: container.resolve()
            ),
            container: container
        )
    }
}

#Preview {
    //ContentView()
}

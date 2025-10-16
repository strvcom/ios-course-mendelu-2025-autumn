//
//  ListView.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import SwiftUI

struct ListView: View {
    private let viewModel: MapPlacesViewModel
    private let connector: PhoneConnecting
    private let container: DIContainer

    init(
        viewModel: MapPlacesViewModel,
        container: DIContainer
    ) {
        self.viewModel = viewModel
        connector = container.resolve()
        self.container = container
    }
    
    var body: some View {
        NavigationStack {
            TimelineView(.periodic(from: .now, by: 5)) { context in
                List(viewModel.state.mapPlaces) { mapPlace in
                    NavigationLink(mapPlace.name) {
                        DetailView(mapPlace: mapPlace)
                    }
                }
            }
            .navigationTitle("Places")

        }
        .onAppear() {
            viewModel.fetchMapPlaces()
        }
        .task {
            // could be improved?
            await startPeriodicViewUpdates()
        }
        
    }
    
    func startPeriodicViewUpdates() async {
        while true {
            try? await Task.sleep(nanoseconds: 5_000_000_000)
            viewModel.fetchMapPlaces()
        }
    }
}

#Preview {
    ListView(
        viewModel: MapPlacesViewModel(
            dataManager: DIContainer.shared.resolve(),
            locationManager: DIContainer.shared.resolve()
        ),
        container: DIContainer.shared
    )
}

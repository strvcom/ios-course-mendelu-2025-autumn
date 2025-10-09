//
//  ListView.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import SwiftUI

struct ListView: View {
    var viewModel: MapPlacesViewModel
    var connector: PhoneConnecting

    init(viewModel: MapPlacesViewModel) {
        self.viewModel = viewModel
        connector = DIContainer.shared.resolve()
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
    ListView(viewModel: .init())
}

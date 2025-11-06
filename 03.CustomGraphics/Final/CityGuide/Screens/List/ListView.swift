//
//  MapPlacesView.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//

import SwiftUI

struct ListView: View {
    @State private var viewModel: MapPlacesViewModel
    @State private var isNewPlaceViewPresented = false
    @EnvironmentObject var container: DIContainer

    init(
        viewModel: MapPlacesViewModel
    ) {
        self.viewModel = viewModel
    }
        
    var body: some View {
        NavigationStack{
            List {
                ForEach(viewModel.state.mapPlaces) { mapPlace in
                    NavigationLink(
                        mapPlace.name,
                        destination: DetailView(
                            viewModel: DetailViewModel(
                                place: mapPlace,
                                dataManager: container.resolve(),
                                apiManager: container.resolve()
                            )
                        )
                    )
                    .listRowBackground(Colors.Contrast.gray200)
                    .swipeActions {
                        Button(role: .destructive) {
                            viewModel.removePlace(place: mapPlace)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        .tint(Colors.Functional.delete)
                    }
                }
            }
            .foregroundStyle(Colors.primary)
            .scrollContentBackground(.hidden)
            .background(Colors.background)
            .onAppear() {
                viewModel.fetchMapPlaces()
                if viewModel.state.mapPlaces.isEmpty {
                    viewModel.fetchSampleData()
                }
            }
            .navigationTitle("Places")
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing){
                    Button(action: {
                        isNewPlaceViewPresented.toggle()
                    }) {
                        Label("Add Place", systemImage: "plus")
                            .labelStyle(.iconOnly)
                    }
                    .accessibilityIdentifier(.listViewAddNewPlaceButton)
                }
            }
            .sheet(isPresented: $isNewPlaceViewPresented) {
                NavigationStack {
                    NewMapPlaceView(
                        isViewPresented: $isNewPlaceViewPresented,
                        viewModel: viewModel
                    )
                }
            }
        }
    }
}

#Preview {
    ListView(
        viewModel: MapPlacesViewModel(
            dataManager: DIContainer.shared.resolve(),
            locationManager: DIContainer.shared.resolve()
        )
    )
}

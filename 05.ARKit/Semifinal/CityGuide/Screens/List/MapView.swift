//
//  MapView.swift
//  CityGuide
//
//  Created by David Procházka on 26.03.2025.
//

import SwiftUI
import MapKit

struct MapView: View {
    @State private var viewModel: MapPlacesViewModel
    @State private var isDetailPresented = false
    @State private var isNewPlaceViewPresented = false

    @EnvironmentObject var container: DIContainer
    private var connector: WatchConnecting

    init(
        viewModel: MapPlacesViewModel,
        connector: WatchConnecting
    ) {
        self.viewModel = viewModel
        self.connector = connector
    }

    var body: some View {
        NavigationStack{
            ZStack(alignment: .bottom) {
                mapView

                VStack {
                    Spacer()

                    addPointButton
                }
            }
            .toolbarTitleDisplayMode(.inline)
            .sheet(isPresented: $isDetailPresented) {
                if let selectedPlace = viewModel.state.selectedPlace {
                    detailView(selectedPlace: selectedPlace)
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
            .onAppear() {
                viewModel.fetchMapPlaces()
                viewModel.syncLocation()

                Task {
                    await viewModel.startPeriodicLocationUpdate()
                }
            }
            .navigationTitle("Map")
        }
    }
}

private extension MapView {
    var mapView: some View {
        Map(
            position: $viewModel.state.mapCameraPosition,
            interactionModes: [.pan, .zoom]
        ) {
            ForEach(viewModel.state.mapPlaces) { place in
                Annotation(
                    "",
                    coordinate: place.coordinates
                ) {
                    VStack {
                        PinView {
                            Text(place.type.symbol)
                        }
                        .frame(width: 30)

                        VStack {
                            Text(place.name)
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .accessibilityIdentifier(.mapViewAnnotationTitle)

                            Text(place.style.name)
                                .font(.footnote)
                        }
                        .padding(5.0)
                        .background(.white.opacity(0.8))
                        .clipShape(RoundedRectangle(cornerRadius: 5.0), style: FillStyle())
                    }
                    .accessibilityElement(children: .contain)
                    .accessibilityIdentifier(.mapViewAnnotationContent)
                    .onTapGesture {
                        viewModel.state.selectedPlace = place
                        isDetailPresented = true
                    }
                }
            }
        }
        .accessibilityIdentifier(.mapViewMap)
        .clipShape(RoundedRectangle(cornerRadius: 50))
        .ignoresSafeArea(edges: .bottom)
    }

    var addPointButton: some View {
        Button("Add Point") {
            isNewPlaceViewPresented.toggle()
        }
        .buttonStyle(.primary)
        .padding()
    }

    @ViewBuilder
    func detailView(selectedPlace: MapPlace) -> some View {
        NavigationStack {
            // VM je private, takze potrebuji kontruktor a konstruktor nemuze prevzit Binding
            DetailView(
                viewModel: DetailViewModel(
                    place: selectedPlace,
                    dataManager: container.resolve(),
                    apiManager: container.resolve()
                )
            )
            .presentationDetents([.fraction(0.3), .medium, .large])
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading){
                    Button("Close") {
                        isDetailPresented = false
                    }
                }

                ToolbarItemGroup(placement: .topBarTrailing){
                    Button("Send") {
                        connector.sendMapPlace(mapPlace: selectedPlace)
                    }
                }
            }
        }
    }
}

#Preview {
    MapView(
        viewModel: MapPlacesViewModel(
            dataManager: DIContainer.shared.resolve(),
            locationManager: DIContainer.shared.resolve(),
        ),
        connector: DIContainer.shared.resolve()
    )
}

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
    @State var isDetailPresented = false
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
            Map(
                position: $viewModel.state.mapCameraPosition,
                interactionModes: [.pan, .zoom]
            ) {
                ForEach(viewModel.state.mapPlaces) { place in
                    Annotation(
                        "",
                        coordinate: place.coordinates
                    ) {
                        ZStack {
                            Circle()
                                .fill(.white.opacity(0.5))
                                .stroke(.white.opacity(0.8), lineWidth: 2.0)
                                .frame(width: 36)
                            Text(place.type.symbol)
                            VStack {
                                Text(place.name)
                                    .font(.footnote)
                                    .fontWeight(.semibold)
                                Text(place.style.name)
                                    .font(.footnote)
                            }
                            .padding(5.0)
                            .background(.white.opacity(0.8))
                            .clipShape(RoundedRectangle(cornerRadius: 5.0), style: FillStyle())
                            .offset(y: 40)
                        }
                        .onTapGesture {
                            viewModel.state.selectedPlace = place
                            isDetailPresented = true
                        }
                    }
                }
            }
            .sheet(isPresented: $isDetailPresented) {
                if let selectedPlace = viewModel.state.selectedPlace {
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

#Preview {
    MapView(
        viewModel: MapPlacesViewModel(
            dataManager: DIContainer.shared.resolve(),
            locationManager: DIContainer.shared.resolve(),
        ),
        connector: DIContainer.shared.resolve()
    )
}

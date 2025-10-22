//
//  NewMapPlaceView.swift
//  CityGuide
//
//  Created by David Procházka on 09.04.2025.
//

import SwiftUI
import CoreLocation
import PhotosUI

struct NewMapPlaceView: View {
    @Binding var isViewPresented: Bool
    @State var viewModel: MapPlacesViewModel
    
    @State private var placeName: String = ""
    @State private var placeLocation: CLLocationCoordinate2D = .init()
    @State private var placeStyle: ArchitecturalStyle = .Baroque
    @State private var placeType: LocationType = .Historical
    @State private var placeImage: UIImage = UIImage(named: "empty") ?? UIImage()
    @State private var selectedImage: PhotosPickerItem?

    var body: some View {
        Form {
            Section(content: {
                TextField("", text: $placeName)
                    .foregroundStyle(Colors.primary)
            }, header: {
                Text("Name of place")
            }, footer: {
                HStack {
                    Text("Latitude: \(placeLocation.latitude)")
                    Spacer()
                    Text("Longitude: \(placeLocation.longitude)")
                }
            })
            .foregroundStyle(Colors.Contrast.gray800)
            .listRowBackground(Colors.Contrast.gray200)

            Section("Details") {
                Picker(selection: $placeStyle) {
                    ForEach(ArchitecturalStyle.allCases) { option in
                        Text(option.name)
                    }
                } label: {
                    Text("Architectural style")
                        .foregroundStyle(Colors.primary)
                }
                .pickerStyle(.menu)
                
                Picker(selection: $placeType) {
                    ForEach(LocationType.allCases) { option in
                        Text(option.name)
                    }
                } label: {
                    Text("Location type")
                        .foregroundStyle(Colors.primary)
                }
                .pickerStyle(.menu)
            }
            .foregroundStyle(Colors.Contrast.gray800)
            .listRowBackground(Colors.Contrast.gray200)

            Section("Picture") {
                Image(uiImage: placeImage)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .frame(height: 200)
                
                PhotosPicker(
                    "Select Photos",
                    selection: $selectedImage,
                    matching: .images
                )
                .onChange(of: selectedImage) {
                    Task {
                        if let data = try? await selectedImage?.loadTransferable(type: Data.self) {
                            if let image = UIImage(data: data) {
                                placeImage = image
                            }
                        } else {
                            print("Cannot read data from selected image")
                        }
                    }
                }
            }
            .foregroundStyle(Colors.Contrast.gray800)
            .listRowBackground(Colors.Contrast.gray200)
        }
        .onAppear {
            viewModel.syncLocation()
            placeLocation = viewModel.state.currentLocation ?? .init()
        }
        .navigationTitle("New Place")
        .toolbar {
            ToolbarItemGroup(placement: .topBarLeading) {
                Button("Close") {
                    isViewPresented.toggle()
                }
            }
            
            ToolbarItemGroup(placement: .topBarTrailing) {
                Button("Save") {
                    saveMapPlace()
                    isViewPresented.toggle()
                }
            }
        }
        .foregroundStyle(Colors.primary)
        .scrollContentBackground(.hidden)
        .background(Colors.background)
    }
    
    private func saveMapPlace() {
        let newMapPlace = MapPlace(
            id: UUID(),
            name: placeName,
            style: placeStyle,
            type: placeType,
            image: placeImage,
            coordinates: placeLocation
        )
        
        viewModel.addNewPlace(place: newMapPlace)
        viewModel.fetchMapPlaces()
    }
}

#Preview {
    NewMapPlaceView(
        isViewPresented: .constant(true),
        viewModel: MapPlacesViewModel(
            dataManager: DIContainer.shared.resolve(),
            locationManager: DIContainer.shared.resolve()
        )
    )
}

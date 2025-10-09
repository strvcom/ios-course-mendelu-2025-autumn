//
//  DetailView.swift
//  CityGuide
//
//  Created by David Procházka on 26.03.2025.
//
import SwiftUI

struct DetailView: View {
    @State private var viewModel: DetailViewModel
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Image(uiImage: viewModel.state.mapPlace.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                
                RowElement(
                    label: "Name",
                    value: viewModel.state.mapPlace.name
                )
                
                RowElement(
                    label: "Style",
                    value: viewModel.state.mapPlace.style.name
                )
                
                RowElement(
                    label: "Building type",
                    value: viewModel.state.mapPlace.type.name
                )

                RowElement(
                    label: "Temperature",
                    value: viewModel.state.temperature
                )
            }
        }
        .padding()
        .navigationTitle(viewModel.state.mapPlace.name)
        .onAppear() {
            viewModel.fetchWeatherData()
        }
    }
}

#Preview {
    DetailView(viewModel: DetailViewModel(place: .sample1))
}

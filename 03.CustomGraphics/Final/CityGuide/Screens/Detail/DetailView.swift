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
                    translatedTitle: "Name",
                    value: viewModel.state.mapPlace.name
                )
                .accessibilityIdentifier(.detailViewTitle)
                
                RowElement(
                    translatedTitle: "Style",
                    value: viewModel.state.mapPlace.style.name
                )
                
                RowElement(
                    translatedTitle: "Building type",
                    value: viewModel.state.mapPlace.type.name
                )

                RowElement(
                    translatedTitle: "Temperature",
                    value: viewModel.state.temperature
                )
            }
        }
        .padding()
        .navigationTitle(viewModel.state.mapPlace.name)
        .onAppear() {
            viewModel.fetchWeatherData()
        }
        .background(Colors.background)
        .overlay {
            if viewModel.state.isLoading {
                ProgressView()
                    .progressViewStyle(.loading)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(
            viewModel: DetailViewModel(
                place: .sample1,
                dataManager: DIContainer.shared.resolve(),
                apiManager: DIContainer.shared.resolve()
            )
        )
    }
}

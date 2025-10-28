//
//  ContentView.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    private let container = DIContainer.shared

    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "List",
                systemImage: "list.bullet.circle",
                value: 0
            ){
                ListView(
                    viewModel: MapPlacesViewModel(
                        dataManager: container.resolve(),
                        locationManager: container.resolve()
                    )
                )
            }
            
            Tab(
                "Map",
                systemImage: "map.circle",
                value: 1)
            {
                MapView(
                    viewModel: MapPlacesViewModel(
                        dataManager: container.resolve(),
                        locationManager: container.resolve()
                    ),
                    connector: container.resolve()
                )
            }
        }
        .environmentObject(container)
    }
}

#Preview {
    ContentView()
}


//Color Name      Light Mode HEX      Dark Mode HEX
//--------------- ------------------- -------------------
//Background      #FEFFFF             #0E0E12
//
//Primary         #010205             #FBFCFF
//
//Contrast200     #D8D8DB             #404044
//
//Contrast500     #6B6D70             #88898C
//
//Contrast800     #535457             #AFB0B3
//
//Delete          #CC1922             #FC4040
//
//PinkExperiment  #D12D68             #FF8CBA

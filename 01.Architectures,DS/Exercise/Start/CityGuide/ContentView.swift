//
//  ContentView.swift
//  CityGuide
//
//  Created by David Procházka on 19.03.2025.
//

import SwiftUI

struct ContentView: View {
    @State var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(
                "List",
                systemImage: "list.bullet.circle",
                value: 0
            ){
                ListView(viewModel: MapPlacesViewModel())
            }
            
            Tab(
                "Map",
                systemImage: "map.circle",
                value: 1)
            {
                MapView(viewModel: MapPlacesViewModel())
            }
        }
    }
}

#Preview {
    ContentView()
}

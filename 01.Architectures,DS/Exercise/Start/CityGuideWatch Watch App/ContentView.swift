//
//  ContentView.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ListView(viewModel: MapPlacesViewModel())
    }
}

#Preview {
    //ContentView()
}

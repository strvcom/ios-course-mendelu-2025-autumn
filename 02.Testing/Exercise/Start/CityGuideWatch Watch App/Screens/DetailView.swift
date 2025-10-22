//
//  DetailView.swift
//  CityGuideWatch Watch App
//
//  Created by David Procházka on 02.10.2025.
//

import SwiftUI

struct DetailView: View {
    var mapPlace: MapPlace
    
    var body: some View {
        ScrollView {
            VStack {
                Text(mapPlace.name)
                    .font(.headline)
                Text(mapPlace.style.name)
                    .font(.subheadline)
                Image(uiImage: mapPlace.image)
                    .resizable()
                    .scaledToFit()
                    .clipShape(.circle)
                    .padding()
                
                Button("Navigate"){
                    startNavigation()
                }
            }
        }
    }
    
    func startNavigation() {
        let url = URL(string: "http://maps.apple.com/?daddr=\(mapPlace.coordinates.latitude),\(mapPlace.coordinates.longitude)&dirflg=w")!
        WKExtension.shared().openSystemURL(url)
    }
}

#Preview {
    DetailView(mapPlace: .sample1)
}

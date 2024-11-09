//
//  ContentView.swift
//  ExpandableSlider
//
//  Created by Ali Aghamirbabaei on 11/9/24.
//

import SwiftUI

struct ContentView: View {
    @State private var backgroundVolume: CGFloat = 10.0
    @State private var vocalVolume: CGFloat = 40.0
    @State private var guitarVolume: CGFloat = 70.0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 100.0) {
                CustomSlider(title: "Backgroud Volume", icon: "hifispeaker", value: $backgroundVolume, in: 0...100, config: .init(inActiveTint: .black.opacity(0.06), activeTint: .blue)) {
                    HStack {
                        Image(systemName: "speaker.wave.3.fill", variableValue: backgroundVolume / 100)
                        
                        Spacer(minLength: 0.0)
                        
                        Text(String(format: "%.1f", backgroundVolume) + "%")
                    }
                    .padding(.horizontal, 20.0)
                }
                
                CustomSlider(title: "Vocal Volume", icon: "music.mic", value: $vocalVolume, in: 0...100, config: .init(inActiveTint: .black.opacity(0.06), activeTint: .purple)) {
                    HStack {
                        Image(systemName: "speaker.wave.3.fill", variableValue: vocalVolume / 100)
                        
                        Spacer(minLength: 0.0)
                        
                        Text(String(format: "%.1f", vocalVolume) + "%")
                    }
                    .padding(.horizontal, 20.0)
                }
                
                CustomSlider(title: "Guitar Volume", icon: "guitars", value: $guitarVolume, in: 0...100, config: .init(inActiveTint: .black.opacity(0.06), activeTint: .red)) {
                    HStack {
                        Image(systemName: "speaker.wave.3.fill", variableValue: guitarVolume / 100)
                        
                        Spacer(minLength: 0.0)
                        
                        Text(String(format: "%.1f", guitarVolume) + "%")
                    }
                    .padding(.horizontal, 20.0)
                }
            }
            .padding(15.0)
            .navigationTitle("Expandaable Slider")
        }
    }
}

#Preview {
    ContentView()
}

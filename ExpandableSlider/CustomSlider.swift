//
//  CustomSlider.swift
//  ExpandableSlider
//
//  Created by Ali Aghamirbabaei on 11/9/24.
//

import SwiftUI

struct CustomSlider<Overlay: View>: View {
    @Binding var value: CGFloat
    let title: String
    let icon: String
    var range: ClosedRange<CGFloat>
    var overlay: Overlay
    var config: SliderConfiguration
    
    init(title: String, icon: String, value: Binding<CGFloat>, in range: ClosedRange<CGFloat>, config: SliderConfiguration = .init(), @ViewBuilder overlay: @escaping () -> Overlay) {
        self.title = title
        self.icon = icon
        self._value = value
        self.range = range
        self.config = config
        self.overlay = overlay()
        self.lastStoredValue = value.wrappedValue
    }
    
    @State private var lastStoredValue: CGFloat
    @GestureState private var isActive: Bool = false
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    
                
                Text(title)
                    .font(.title3)
            }
            .padding(.bottom, isActive ? 0.0 : -20.0)
            .animation(.snappy, value: isActive)
            
            GeometryReader {
                let size = $0.size
                let width = (value / range.upperBound) * size.width
                
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(config.inActiveTint)
                    
                    Rectangle()
                        .fill(
                            LinearGradient(gradient: Gradient(colors: [config.activeTint.opacity(0.7), config.activeTint]), startPoint: .leading, endPoint: .trailing)
                        )
                        .mask(alignment: .leading) {
                            Rectangle()
                                .frame(width: width)
                        }
                    
                    ZStack(alignment: .leading) {
                        overlay
                            .foregroundStyle(config.overlayInActiveTint)
                        
                        overlay
                            .foregroundStyle(config.overlayActiveTint)
                            .mask(alignment: .leading) {
                                Rectangle()
                                    .frame(width: width)
                            }
                    }
                    .compositingGroup()
                    .animation(.easeInOut(duration: 0.3).delay(isActive ? 0.12 : 0.0).speed(isActive ? 1 : 2)){
                        $0
                            .opacity(isActive ? 1.0 : 0.0)
                    }
                }
                .contentShape(.rect)
                .highPriorityGesture(
                    DragGesture(minimumDistance: 0)
                        .updating($isActive, body: { _, out, _ in
                            out = true
                        })
                        .onChanged({ value in
                            let progress = ((value.translation.width / size.width) * range.upperBound) + lastStoredValue
                            self.value = max(min(progress, range.upperBound), range.lowerBound)
                        }).onEnded({ _ in
                            lastStoredValue = value
                        })
                )
            }
            .frame(height: 20.0 + config.extraHeight)
            .mask {
                RoundedRectangle(cornerRadius: config.cornerRadius)
                    .frame(height: 20.0 + (isActive ? config.extraHeight : 0.0))
            }
            .animation(.snappy, value: isActive)
        }
    }
}

#Preview {
    ContentView()
}

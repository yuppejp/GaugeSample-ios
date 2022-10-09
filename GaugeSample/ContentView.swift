//
//  ContentView.swift
//  GaugeSample
//
//  Created on 2022/10/09.
//  

import SwiftUI

struct GaugeSample1: View {
    @State var value = 0.0
    @State var inputValue = 50.0
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("accessoryCircularCapacity")
                        .font(.caption)
                    Gauge(value: value, in: 0...100) {
                        Text(value / 100, format: .percent)
                    }
                    .gaugeStyle(.accessoryCircularCapacity)
                    .tint(.green)
                    .scaleEffect(4.0)
                    .frame(width: 300, height: 300)
                    .background(Color.gray.opacity(0.3))
                }
                
                VStack {
                    Text("accessoryCircular")
                        .font(.caption)
                    Gauge(value: value, in: 0...100) {
                    } currentValueLabel: {
                        Text(value / 100, format: .percent)
                    } minimumValueLabel: {
                        Text("0")
                    } maximumValueLabel: {
                        Text("100")
                    }
                    .gaugeStyle(.accessoryCircular)
                    .tint(Gradient(colors: [.red, .yellow, .green, .green, .green]))
                }
            }
            VStack {
                Text("accessoryLinear")
                Gauge(value: value, in: 0...100) {
                }
                .gaugeStyle(.accessoryLinear)
                .tint(.blue)
                
                Text("accessoryLinearCapacity")
                Gauge(value: value, in: 0...100) {
                }
                .gaugeStyle(.accessoryLinearCapacity)
                .tint(.cyan)
                Text("linearCapacity")
                
                Gauge(value: value, in: 0...100) {
                }
                .gaugeStyle(.linearCapacity)
                .tint(.orange)
            }
            Spacer()
            Slider(value: $inputValue, in: 0...100)
            Text(String(value))
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1)) {
                value = inputValue
            }
        }
        .onChange(of: inputValue) { newValue in
            withAnimation(.easeInOut(duration: 1)) {
                value = newValue.rounded(.toNearestOrAwayFromZero)
            }
        }
        .padding()
    }
}

struct GaugeSample2: View {
    @State var value = 0.0
    @State var inputValue = 50.0
    @State var scale = 1.0
    @State var padding = 0.0
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                HStack {
                    VStack {
                        Text("accessoryCircularCapacity")
                            .font(.caption)
                        Gauge(value: value, in: 0...100) {
                            Text(value / 100, format: .percent)
                        }
                        .gaugeStyle(.accessoryCircularCapacity)
                        .scaleEffect(scale)
                        .tint(.green)
                        .background(GeometryReader{ inner -> Text in
                            DispatchQueue.main.async {
                                let diameter = geometry.size.width / 2.5
                                scale = diameter / inner.size.width
                                padding = (diameter - inner.size.width) / 2
                                
                                print("***** geometry: \(geometry.size.width), \(geometry.size.height)")
                                print("***** inner   : \(inner.size.width), \(inner.size.height)")
                                print("***** scale   : \(scale)")
                            }
                            return Text("")
                        })
                        .padding(padding)
                    }
                    VStack {
                        Text("accessoryCircular")
                            .font(.caption)
                        Gauge(value: value, in: 0...100) {
                        } currentValueLabel: {
                            Text(value / 100, format: .percent)
                        } minimumValueLabel: {
                            Text("0")
                        } maximumValueLabel: {
                            Text("100")
                        }
                        .gaugeStyle(.accessoryCircular)
                        .scaleEffect(scale)
                        .tint(Gradient(colors: [.red, .yellow, .green, .green, .green]))
                        .padding(padding)
                    }
                }
                VStack {
                    Text("accessoryLinear")
                    Gauge(value: value, in: 0...100) {
                    }
                    .gaugeStyle(.accessoryLinear)
                    .tint(.blue)
                    
                    Text("accessoryLinearCapacity")
                    Gauge(value: value, in: 0...100) {
                    }
                    .gaugeStyle(.accessoryLinearCapacity)
                    .tint(.cyan)
                    Text("linearCapacity")
                    
                    Gauge(value: value, in: 0...100) {
                    }
                    .gaugeStyle(.linearCapacity)
                    .tint(.orange)
                }
                Spacer()
                Slider(value: $inputValue, in: 0...100)
                Text(String(value))
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    value = inputValue
                }
            }
            .onChange(of: inputValue) { newValue in
                withAnimation(.easeInOut(duration: 1)) {
                    value = newValue.rounded(.toNearestOrAwayFromZero)
                }
            }
            .padding()
        }
    }
}

struct ScaleGaugeSample: View {
    var value = 50.0
    @State var scale = 1.0
    @State var padding = 0.0
    
    var body: some View {
        GeometryReader{ geometry in
            VStack {
                Text("accessoryCircularCapacity")
                    .font(.caption)
                Gauge(value: value, in: 0...100) {
                    Text(value / 100, format: .percent)
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .scaleEffect(scale)
                .tint(.green)
                .background(GeometryReader{ inner -> Text in
                    DispatchQueue.main.async {
                        let diameter = geometry.size.width * 0.8
                        scale = diameter / inner.size.width
                        padding = (diameter - inner.size.width) / 2
                        
                        print("***** geometry: \(geometry.size.width), \(geometry.size.height)")
                        print("***** inner   : \(inner.size.width), \(inner.size.height)")
                        print("***** scale   : \(scale)")
                    }
                    return Text("")
                })
                .padding(padding)
                .background(Color.gray)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // GeometryReaderを使用するとセンタリングされない問題の対処
            .padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            //GaugeSample1()
            GaugeSample2()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            GaugeSample1()
            GaugeSample2()
            ScaleGaugeSample()
        }
    }
}

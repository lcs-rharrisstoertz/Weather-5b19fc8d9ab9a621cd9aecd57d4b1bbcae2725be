//
//  ContentView.swift
//  iOS
//
//  Created by Russell Gordon on 2021-10-02.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: WeatherViewModel
    
    @State var temperature: Double
    
    @State var feel: String
    
    @State var conditions: String
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                Text("\(conditions)")
#if os(iOS)
                    .font(.title)
#else
                    .font(.title2)
#endif
                
                Text("\(String(format: "%.1f", arguments: [temperature])) °C")
                    .font(.largeTitle)
                    .bold()
                
                Text("\(feel)")
                    .font(.title3)
            }
            .frame(maxWidth: .infinity)
            .padding() //padding around text
            .background(Color.blue)
            .padding() //padding around background (I don't want it to extend to the edges)
            .foregroundColor(.white)
            
            Spacer()
            
            Button {
                
                // Get a new prediction from the view model
                let prediction = viewModel.providePrediction()
                
                // Populate state variables so the user interface updates
                temperature = prediction.temperature
                feel = "That's \(prediction.feel.lowercased())."
                conditions = prediction.condition.description
                
            } label: {
                Text("Get New Prediction")
            }
            
            Spacer()
            
            
        }
        .navigationTitle("Current")
        
    }
}

struct ContentView_Previews: PreviewProvider {
    
    @StateObject private static var viewModel = WeatherViewModel()
    
    static var previews: some View {
        ContentView(viewModel: viewModel, temperature: viewModel.history.last!.temperature, feel: viewModel.history.last!.feel, conditions: viewModel.history.last!.condition.description)
    }
}

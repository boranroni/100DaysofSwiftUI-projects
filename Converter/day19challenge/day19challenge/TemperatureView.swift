//
//  TemperatureView.swift
//  day19challenge
//
//  Created by Boran Roni on 22.09.2022.
//

import SwiftUI

struct TemperatureView: View {
    let formats = ["Celsius", "Fahrenheit", "Kelvin"]
    @State var InputTemp = 10.0
    @State var InputFormat = "Celsius"
    @State var OutputFormat = "Fahrenheit"
    @FocusState private var isfocused: Bool
    var OutputTemp: Double {
        var finaltemp = 0.0
        switch InputFormat{
        case "Fahrenheit":
            finaltemp = (InputTemp-32) * 5/9
        case "Kelvin":
            finaltemp = InputTemp - 273.15
        default:
            finaltemp = InputTemp
        }
        
        switch OutputFormat{
        case "Fahrenheit":
            finaltemp = finaltemp * 9/5 + 32
        case "Kelvin":
            finaltemp += 273.15
        default:
            break
        }
        
        return finaltemp
    }
    var body: some View {
        NavigationView
        {
            Form
            {
            Section
                {
                    TextField("Temp",value:$InputTemp, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isfocused)
                    Picker("input format", selection: $InputFormat)
                    {
                        ForEach(formats, id: \.self){
                            Text($0)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("From")
                        
                }
                
                
                Section
                    {
                        Text(OutputTemp, format: .number)
                        Picker("input format", selection: $OutputFormat)
                        {
                            ForEach(formats, id: \.self){
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                    }header: {
                        Text("To")
                    }

            }
            
            .navigationTitle("Temp Converter")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("done"){
                        isfocused = false
                    }
                }
            }
        }
    }
}

struct TemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        TemperatureView()
    }
}

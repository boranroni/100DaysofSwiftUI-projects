//
//  LengthView.swift
//  day19challenge
//
//  Created by Boran Roni on 22.09.2022.
//

import SwiftUI

struct LengthView: View {
    let formats = ["meter","KM","feet","yards","miles"]
    @State var InputLen = 0.0
    @State var InputFormat = "meter"
    @State var OutputFormat = "KM"
    @FocusState private var isfocused: Bool
    var OutPutLen: Double {
        var finallen = 0.0
        switch InputFormat{
        case "KM":
            finallen = InputLen*1000
        case "feet":
            finallen = InputLen/3.281
        case "yards":
            finallen = InputLen/1.094
        case "miles":
            finallen = InputLen*01609
        default:
            finallen = InputLen
        }
        switch OutputFormat{
        case "KM":
            finallen = InputLen/1000
        case "feet":
            finallen = InputLen*3.281
        case "yards":
            finallen = InputLen*1.094
        case "miles":
            finallen = InputLen/01609
        default:
            break
        }
        return finallen
    }
    var body: some View {
        NavigationView
        {
            Form
            {
            Section
                {
                    TextField("Len",value:$InputLen, format: .number)
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
                        
                        Picker("input format", selection: $OutputFormat)
                        {
                            ForEach(formats, id: \.self){
                                Text($0)
                            }
                        }.pickerStyle(.segmented)
                        Text(OutPutLen, format: .number)
                    }header: {
                        Text("To")
                    }

            }
            
            .navigationTitle("Length Converter")
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


struct LengthView_Previews: PreviewProvider {
    static var previews: some View {
        LengthView()
    }
}

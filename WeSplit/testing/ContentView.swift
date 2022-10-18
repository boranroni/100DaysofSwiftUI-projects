//
//  ContentView.swift
//  testing
//
//  Created by Boran Roni on 20.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkamount = 0.0
    @State private var numberofpeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amoutisfocued: Bool
    let tipPercenages = Array(1..<101)
    
    var totalperperson: Double{
        let peopleCount = Double(numberofpeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkamount / 100 * tipSelection
        let grandTotal = checkamount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    var grandchecktotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkamount / 100 * tipSelection
        let grandTotal = checkamount + tipValue
        
        return grandTotal
    }
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("amount",value:$checkamount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amoutisfocued)
                    
                    Picker("Number of peope", selection: $numberofpeople){
                        ForEach(2..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                Section{
                    Picker("tip percentage", selection: $tipPercentage){
                        ForEach(tipPercenages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.automatic)
                }
                header: {
                    Text("How much tip do you want to leave?")
                }
                Section{
                    Text(grandchecktotal,format:.currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Grand Total")
                }
                
                Section{
                    Text(totalperperson,format:.currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Amount Per Person")
                }

            }
            .navigationTitle("Wesplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("done"){
                        amoutisfocued = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

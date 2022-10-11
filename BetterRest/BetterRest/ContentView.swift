//
//  ContentView.swift
//  BetterRest
//
//  Created by Boran Roni on 29.09.2022.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    var timeRange = Array((stride(from: 1, to: 20, by: 0.25)))
    
    var idealbedtime:String {
        calculateBedtime()
        
    }
    
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView{
            Form {
                //VStack(alignment: .leading, spacing: 0){
                Section(header: Text("When do you want to wake up?")){
                        
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                //VStack(alignment: .leading, spacing: 0){
                Section(header: Text("Desired amount of sleep")){
                    Picker("Amount of coffee", selection: $sleepAmount){
                        ForEach(1..<12) {
                                Text("\($0)")
                        }
                    }.pickerStyle(.wheel)
                    
                }
                //VStack(alignment: .leading, spacing: 0){
                Section(header: Text("Daily coffee intake")){
                    
                    //Stepper(coffeeAmount == 1 ? "1 cup": "\(coffeeAmount) cups", value: $coffeeAmount, in: 1...20)
                    Picker("Amount of coffee", selection: $coffeeAmount){
                        ForEach(1..<20) {
                                Text("\($0)")
                        }
                    }
                    //.pickerStyle(.wheel)
                }
                Section(header: Text("Your ideal bed time")){
                    Text("\(idealbedtime)")
            
                }
            }
            .navigationTitle("BetterRest")

        }
        
    }
    func calculateBedtime()->String{
        do{
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            return sleepTime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            return "Error"
        }
            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

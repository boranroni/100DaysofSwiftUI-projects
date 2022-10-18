//
//  ContentView.swift
//  Spirograph
//
//  Created by Boran Roni on 17.10.2022.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRad: Int
    let outerRad: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b : Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        return a
    }
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRad, outerRad)
        let outerRad = Double(self.outerRad)
        let innerRad = Double(self.innerRad)
        let distance = Double(self.distance)
        let difference = innerRad - outerRad
        let endPoint = ceil(2*Double.pi*outerRad/Double(divisor)) * amount
        
        
        var path = Path()
        
        for theta in stride(from: 0, to: endPoint, by: 0.01){
            var x = difference * cos(theta) + distance * cos(difference / outerRad * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRad * theta)
            x += rect.width/2
            y += rect.height/2
            
            if theta == 0{
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}
struct ContentView: View {
    @State private var innerRad = 125.0
    @State private var outterRad = 75.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Spirograph(innerRad: Int(innerRad), outerRad: Int(outterRad), distance: Int(distance), amount: amount)
                .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                .frame(width: 300,height: 300)
            
            Spacer()
            Group{
                Text("Inner radius: \(Int(innerRad))")
                Slider(value: $innerRad, in: 10...150, step: 1)
                    .padding([.horizontal,.bottom])
                Text("Outter radius: \(Int(outterRad))")
                Slider(value: $outterRad, in: 10...150, step: 1)
                    .padding([.horizontal,.bottom])
                Text("Distance: \(Int(distance))")
                Slider(value: $distance, in: 10...150, step: 1)
                    .padding([.horizontal,.bottom])
                
                Text("Amount: \(amount, format: .number.precision(.fractionLength(2)))")
                Slider(value: $amount)
                    .padding([.horizontal,.bottom])
                
                Text("Color")
                Slider(value: $hue)
                    .padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

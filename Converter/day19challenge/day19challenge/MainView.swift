//
//  MainView.swift
//  day19challenge
//
//  Created by Boran Roni on 22.09.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            
            TemperatureView()
                .tabItem {
                    Label("temperature",systemImage: "thermometer.sun")
                }
            LengthView()
                .tabItem {
                    Label("Length",systemImage: "camera.metering.none")
                }


        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

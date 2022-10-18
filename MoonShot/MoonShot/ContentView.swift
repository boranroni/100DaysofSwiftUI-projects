//
//  ContentView.swift
//  MoonShot
//
//  Created by Boran Roni on 13.10.2022.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var gridView = false
    let colums = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationView{
            Group {
                if gridView {
                    GridView(astronauts: astronauts, missions: missions)
                } else {
                    ListView(astronauts: astronauts, missions: missions)
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem{
                    Button("View") {
                        gridView.toggle()
                    }
                }
            }
        }
        
        
    }
}

struct GridView: View {
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    
    let colums = [
        GridItem(.adaptive(minimum: 150))
        
    ]
    var body: some View {
        
            ScrollView{
                LazyVGrid(columns: colums){
                    ForEach(missions) { mission in
                        NavigationLink{
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100,height: 100)
                                    .padding()
                                VStack{
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                            )
                        }
                    }
                }
                .padding([.horizontal,.bottom])
        }
    }
}
struct ListView: View{
    let astronauts: [String: Astronaut]
    let missions: [Mission]
    
    
    let colums = [
        GridItem(.flexible(minimum: 150))
    ]
    var body: some View{
    
        ScrollView{
                LazyVGrid(columns: colums){
                    ForEach(missions) { mission in
                        NavigationLink{
                            MissionView(mission: mission, astronauts: astronauts)
                        } label: {
                            
                                HStack{
                                    Image(mission.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100,height: 100)
                                        .padding()
                                    VStack{
                                        Text(mission.displayName)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                        Text(mission.formattedLaunchDate)
                                            .font(.caption)
                                            .foregroundColor(.white.opacity(0.5))
                                    }
                                    .padding(.vertical)
                                    .frame(maxWidth: .infinity)
                                    .background(.lightBackground)
                                    
                                }
                                
                                //.padding(.bottom)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                   RoundedRectangle(cornerRadius: 10)
                                       .stroke(.lightBackground)
                                )
                            
                        }
                    }
                }
                .padding([.horizontal,.bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

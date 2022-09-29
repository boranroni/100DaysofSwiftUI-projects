//
//  ContentView.swift
//  Guess The Flag
//
//  Created by Boran Roni on 24.09.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var questionsAsked = 0
    @State private var playerScore = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var EndOfTheGame = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria","Poland", "Russian", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    var body: some View {
        ZStack{
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45),location:0.3),.init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            
            VStack{
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack (spacing: 15){
                    
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button{
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Your score is \(playerScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore){
            Button("Continue", action: askQuestion)
        }message: {
            Text(scoreMessage)
        }
        .alert("End of the game!", isPresented: $EndOfTheGame){
            Button("Restart", action: RestartGame)
        }message:{
            Text("Game over your final score is \(playerScore)")
        }


    }
    func flagTapped(_ number: Int){
        if number == correctAnswer{
            scoreTitle = "Correct!"
            playerScore += 1
            scoreMessage = "Your score is \(playerScore)"
            
        }else{
            scoreTitle = "Wrong!"
            scoreMessage = "Wrong! That is the flag of \(countries[number])"
        }
        showingScore = true
    }
    func askQuestion(){
        questionsAsked += 1
        if questionsAsked == 8{
            EndOfTheGame = true
        }
        correctAnswer = Int.random(in: 0...2)
        countries.shuffle()

    }
    func RestartGame(){
        playerScore = 0
        questionsAsked = 0
        askQuestion()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//
//  ContentView.swift
//  Edutainment
//
//  Created by Boran Roni on 6.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tableChoice = 7
    @State private var questionNumber = 1
    @State private var difficulty = 0
    @State private var gameOver = 0
    
    var Mtable = [5,10,20]
    var difficulties = ["Easy", "Hard"]
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    Section(header:Text("What would you like to practice?")){
                        Picker("", selection: $tableChoice){
                            ForEach(2..<13){
                                Text("\($0)")
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                    Section(header:Text("How many questions would you like?")){
                        Picker("Please choose a number", selection: $questionNumber){
                            ForEach(0..<3){number in
                                Text("\(Mtable[number])")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    Section(header:Text("How hard you wanna go?")){
                        Picker("Please choose difficulty", selection: $difficulty){
                            ForEach(0..<2){number in
                                Text("\(difficulties[number])")
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                }
            }
            .navigationTitle("Learn Multiplication!")
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    NavigationLink(destination: QuestionView(questions: questionGenerator(qn: Mtable[questionNumber], qd: difficulty),table: tableChoice+2), label: {
                        Text("Let's go!")
                            .bold()
                            .frame(width: 280, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                    })
                }
            }
        }
    }
    func questionGenerator(qn:Int, qd:Int)-> [Int]{
        let diff = [
            [0,1,2,3,4,5,6,7,8,9,10,20,30,40,50,60,70,80,90,100],
            [11,12,13,14,15,16,17,18,19,21,22,23,24,25,26,27,28,29,31,32]
            
        ]
        var rlist = [Int.random(in: 0...19)]
        if qn == 20 {
            return diff[qd].shuffled()
        }else {
            for _ in 0..<qn{
                let r = Int.random(in: 0...19)
                let num = diff[qd][r]
                
                
                rlist.append(num)
            }
        }
        return rlist
    }
    
}

struct QuestionView: View {
    
    var questions: [Int]
    var table: Int
    
    @State private var gameover = false
    @State private var newgame = false

    
    @State private var playerAnswer = 0
    @State private var playerScore = 0
    @State private var message = "Correct!"
    
    
    @FocusState private var isfocused: Bool
    @State private var currentQuestion = 0
    

    var body: some View {
    
        
        NavigationView{
            VStack{
                Form{
                    Section{
                        Text("\(table) x \(questions[currentQuestion])")
                            .font(.system(size: 72))
                            .multilineTextAlignment(.center)
                    }
                    
                    
                    
                    Section{
                        TextField("Answer?",value:$playerAnswer,format: .number)
                            .keyboardType(.decimalPad)
                            .focused($isfocused)
                            .multilineTextAlignment(.center)
                    }
                }
            }
            
        }
        .navigationTitle("\(playerScore) / \(currentQuestion)")
        .toolbar{
            ToolbarItem(placement: .keyboard){
                //Spacer()
                Button("Submit!"){
                    //isfocused = false
                    
                    checkAns(PA: playerAnswer, table: table, times: questions[currentQuestion])
                }
            }
        }
        .alert("Game over!", isPresented: $gameover){
            Button("Restart"){
                newgame = true
            }
        }message: {
            Text("Good Job!")
        }
    }
    func checkAns(PA: Int, table:Int, times:Int){
        if (PA==(table*times)){
            playerScore += 1
            
        }
        currentQuestion += 1
        if currentQuestion == questions.count{
            gameover = true
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

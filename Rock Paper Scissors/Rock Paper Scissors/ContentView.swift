//
//  ContentView.swift
//  Rock Paper Scissors
//
//  Created by Boran Roni on 27.09.2022.
//

import SwiftUI

struct ContentView: View {
    let moves = ["✊", "✋", "🖖"]
    
    
    let WinTable = [0:1,1:2,2:0]
    let LoseTable = [0:2,1:0,2:1]
    @State var playerMove = 0
    @State var compMove = 0
    @State var win = true
    @State var pwon = true
    @State var playerScore = 0
    @State var QuestionAsked = 1
    @State var endgame = false
    var body: some View {
        
        
        
        VStack{
            Text("Round \(QuestionAsked)")
                .font(.system(.title))
            Spacer()
    
            Text("\(moves[compMove])")
                .font(.system(size:100))
            
            Text("\(win ? "Win": "Lose")")
                .font(.system(.largeTitle,design: .rounded))
            HStack {
                Button{
                     pwon = CheckHand(playerhand: 0, compMove: compMove, win: win)
                    NewHand()
                }label: {
                    Text("✊")
                        .font(.system(size:80))
                }
                Button{
                    pwon = CheckHand(playerhand: 1, compMove: compMove, win: win)
                    NewHand()
                    
                }label: {
                    Text("✋")
                        .font(.system(size:80))
                }
                Button{
                    pwon = CheckHand(playerhand: 2, compMove: compMove, win: win)
                    NewHand()
                    
                }label: {
                    Text("🖖")
                        .font(.system(size:80))
                }
                
                
            }
            .alert("Game over!", isPresented: $endgame){
                Button("Restart", action: RestartGame)
            }message:{
                Text("Your final score is \(playerScore)")
                
            }

        
            
            Spacer()
                
            
        }
        .padding()
    }
    
    
    func CheckHand(playerhand: Int,compMove:Int,win: Bool)->Bool{
        if win{
            if WinTable[compMove] == playerhand{
                return true
            }
        }else{
            if LoseTable[compMove] == playerhand{
                return true
            }
        }
        return false
    }
    
    func NewHand(){
        compMove = Int.random(in: 0...2)
        win = Bool.random()
        QuestionAsked += 1
        playerScore = pwon ? playerScore+1: playerScore-1
        
        if QuestionAsked == 10
        {
            endgame = true
            
        }
    }
    func RestartGame(){
        QuestionAsked = 1
        playerScore = 0
        endgame = false
    }

}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

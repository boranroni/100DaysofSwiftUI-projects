//
//  ContentView.swift
//  WordScramble
//
//  Created by Boran Roni on 2.10.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var playerScore = 0
    
    var body: some View {
        NavigationView{
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .autocapitalization(.none)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
            }
            .navigationTitle("\(rootWord) / Score: \(playerScore)")
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert (errorTitle,isPresented: $showingError){
                Button("OK", role: .cancel){ }
                
            }message: {
                Text(errorMessage)
            }
            
            
            
        
            .toolbar{
                Button("New Word"){
                    startGame()
                }
            }
        }
    }
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {return}
        
        
        guard sameWord(word: answer, rootWord: rootWord) else {
            wordError(title: "Word not possible", message: "Be more original!")
            return
        }
        
        guard tooShort(word: answer) else {
            wordError(title: "Word is too short", message: "Use something longer! \n That's what she said")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
        withAnimation{
            usedWords.insert(answer, at: 0)
            playerScore = 1 + playerScore + answer.count
            
        }
        newWord = ""
    }
    
    func startGame(){
        if let starWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: starWordsURL){
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func sameWord(word: String, rootWord: String) -> Bool{
        return !(word==rootWord)
        
    }
    
    func tooShort(word: String) -> Bool {
        return word.count > 3
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    func isPossible(word: String ) -> Bool {
        var tempWord = rootWord
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            }else {
                return false
            }
        }
        return true
    }
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspel = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return misspel.location == NSNotFound
    }
    func wordError(title: String, message: String){
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

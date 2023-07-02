//
//  EndlessView.swift
//  MultiplicationTables
//
//  Created by Philipp Sanktjohanser on 12.12.22.
//

import SwiftUI

struct EndlessView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    
    @State private var allCorrect = true
    @State private var answer = ""
    
    @State private var num1 = 1
    @State private var num2 = 1
    
    @State private var submitted = false
    @State private var submittedFalseAnswer = false
    @State private var backToHome = false
    
    @State private var score = 0
    @AppStorage("highScore") private var highScore = 0
    
    var body: some View {
            ZStack {
                VStack {
                    Text("What is \(num1) x \(num2)?")
                    
                    TextField("Answer", text: $answer)
                        .keyboardType(.numberPad)
                    
                    Text("Current score: \(score)")
                    Text("Highscore: \(highScore)")
                    
                    //Return button if player wants to quit
                }
                .onSubmit {
                    if answer != String(num1 * num2) {
                        submittedFalseAnswer = true
                    } else {
                        submitted = true
                    }
                }
                .alert("Correct!", isPresented: $submitted) {
                    Button("Continue") { nextQuestion() }
                }
                .alert("Wrong", isPresented: $submittedFalseAnswer) {
                    Button("Back to menu", role: .destructive) { dismiss() }
                    Button("Try again", role: .cancel) { restartGame() }
                }
            }
            .navigationBarBackButtonHidden()
            .onAppear {
                randomNumber()
        }
    }
    
    func nextQuestion() {
        score += 1
        if score > highScore { highScore = score }
        
        randomNumber()
        answer = ""
    }
    
    func restartGame() {
        score = 0
        randomNumber()
        answer = ""
    }
    
    func randomNumber() {
        if settings.difficulty == "Easy" {
            num1 = Int.random(in: 1...5)
            num2 = Int.random(in: 1...5)
        } else if settings.difficulty == "Hard" {
            num1 = Int.random(in: 1...20)
            num2 = Int.random(in: 1...20)
        } else {
            num1 = Int.random(in: 1...10)
            num2 = Int.random(in: 1...10)
        }
    }
}

struct EndlessView_Previews: PreviewProvider {
    static var previews: some View {
        EndlessView()
            .environmentObject(Settings())
    }
}

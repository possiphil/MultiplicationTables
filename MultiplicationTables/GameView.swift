//
//  GameView.swift
//  MultiplicationTables
//
//  Created by Philipp Sanktjohanser on 12.12.22.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: Settings
    
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var submittedAnswer = false
    @State private var submitted = false
    @State private var turn = 1
    @State private var gameOver = false
    
    @State private var num1 = 0
    @State private var num2 = 0
    @State private var answer = ""
    @State private var score = 0
    
    @State private var isTimerRunning = true
    @State private var remainingTime = 10 //{
//        didSet {
//            if remainingTime <= 0 {
//                remainingTime = 0
//                isTimerRunning = false
//                submittedAnswer = false
//                submitted = true
//            }
//        }
//    }
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(remainingTime)")
                
                Text("What is \(num1) x \(num2)?")
                
                TextField("Answer", text: $answer)
                    .keyboardType(.numberPad)
            }
            .onSubmit {
                isTimerRunning = false
                if answer != String(num1 * num2) {
                    submittedAnswer = false
                } else {
                    submittedAnswer = true
                    score += 1
                }
                submitted = true
            }
            .alert(submittedAnswer ? "Correct!" : "False", isPresented: $submitted) {
                Button("Continue") { nextQuestion() }
            }
            .alert("GG!", isPresented: $gameOver) {
                Button("Play again", role: .cancel) { restartGame() }
                Button("Back to menu", role: .destructive) { dismiss() }
            } message: {
                Text("Your final score is \(score)")
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            randomNumber()
        }
        .onReceive(timer) { _ in
            if isTimerRunning {
                remainingTime -= 1
                if remainingTime == 0 {
                    isTimerRunning = false
                    submittedAnswer = false
                    submitted = true
                }
            }
        }
    }
    
    func nextQuestion() {
        turn += 1
        if String(turn) == settings.questionAmount {
            gameOver = true
            return
        }
        
        randomNumber()
        answer = ""
        remainingTime = 10
        isTimerRunning = true
    }
    
    func restartGame() {
        turn = 0
        score = 0
        nextQuestion()
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

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(Settings())
    }
}

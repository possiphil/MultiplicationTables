//
//  HomeView.swift
//  MultiplicationTables
//
//  Created by Philipp Sanktjohanser on 12.12.22.
//

import SwiftUI

struct HomeView: View {
    @StateObject var settings = Settings()
    @State private var difficulties = ["Easy", "Normal", "Hard"]
    @State private var difficulty = "Easy"
    
    var questionAmount = ["5", "10", "20", "Endless"]
    @State private var selectedQuestion = "5"
    
    @State private var isEndless = false
    
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                //Background color
                Color(.white)
                
                VStack {
                    VStack {
                        Section("Difficulty") {
                            Picker("Choose a difficulty", selection: $difficulty) {
                                ForEach(difficulties, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                        
                        Section("Amount of questions") {
                            Picker("Choose a question amount", selection: $selectedQuestion) {
                                ForEach(questionAmount, id: \.self) {
                                    Text($0)
                                }
                            }
                            .pickerStyle(.segmented)
                        }
                    }
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    Button {
                        settings.difficulty = difficulty
                        settings.questionAmount = selectedQuestion
                        path.append("Endless")
                    } label: {
                        Text("Start Game")
                            .font(.title)
                            .bold()
                            .foregroundColor(.primary)
                            .frame(width: 300, height: 60)
                            .background(LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    .navigationDestination(for: String.self) { view in
                        if selectedQuestion == "Endless" {
                            EndlessView()
                                .environmentObject(settings)
                        } else {
                            GameView()
                                .environmentObject(settings)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .environmentObject(settings)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Settings())
    }
}

//
//  Settings.swift
//  MultiplicationTables
//
//  Created by Philipp Sanktjohanser on 12.12.22.
//

import Foundation

class Settings: ObservableObject {
    @Published var difficulty = "Easy"
    @Published var questionAmount = "5"
}

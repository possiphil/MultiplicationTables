//
//  Buttons.swift
//  MultiplicationTables
//
//  Created by Philipp Sanktjohanser on 12.12.22.
//

import SwiftUI

struct NavigationButton: View {
    let title: String
    var endless: Bool
    
    var body: some View {
        Button {
            NavigationLink("Game") {
                if endless {
                    EndlessView()
                } else {
                    GameView()
                }
            }
        } label: {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.primary)
                .frame(width: 300, height: 60)
                .background(LinearGradient(colors: [.green, .yellow], startPoint: .topLeading, endPoint: .bottomTrailing))
                .clipShape(RoundedRectangle(cornerRadius: 30))
        }

    }
}

struct Buttons_Previews: PreviewProvider {
    static var previews: some View {
        NavigationButton(title: "Endless Mode", endless: false)
    }
}

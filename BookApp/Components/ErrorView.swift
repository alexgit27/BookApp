//
//  ErrorView.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 23.02.2024.
//

import SwiftUI

struct ErrorView: View {
    @Binding var error: Error?
    @State var rotationDegrees = 3.0
    
    var body: some View {
        VStack(spacing: 8) {
            Image("Error")
                .resizable()
                .scaledToFit()
                
            
                Text((error?.localizedDescription) ?? "Error")
                    .foregroundColor(.black)
                    .padding(20)
                    .rotationEffect(.init(degrees: rotationDegrees))
            
        }
        .background(Color.white)
        .cornerRadius(30)
        .padding(20)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation {
                    rotationDegrees = 0
                }
            }
        }
    }
}


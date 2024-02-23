//
//  SplashView.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import SwiftUI

struct SplashView: View {
    @State private var progress: Double = 0.0
    @State private var showingReccomendedBookView = false
    
    var body: some View {
        ZStack {
            Image("BG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .vertical)
            
            Image("HeartBack")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea(edges: .vertical)
            
            mainStack
        }
        .onAppear {
            animateProgressView()
        }
        .fullScreenCover(isPresented: $showingReccomendedBookView, content: {
            LibraryView()
        })
    }
}

#Preview {
    SplashView()
}


extension SplashView {
    private var mainStack: some View {
        VStack(spacing: 0) {
            Text("Book App")
                .foregroundStyle(Color.theme.pink)
                .fontWeight(.bold)
                .font(.system(size: 52))
            
            Text("Welcome to Book App")
                .foregroundStyle(Color.white)
                .fontWeight(.medium)
                .font(.system(size: 24))
                .padding(.top, 12)
            
            ProgressView(value: progress)
                .tint(.white)
                .foregroundStyle(Color.white)
                .padding(.horizontal, 50)
                .padding(.top, 19)
        }
        
    }
    
    private func animateProgressView() {
        let duration = 2.0
        let steps = 100.0
        let step = 0.01
        Timer.scheduledTimer(withTimeInterval: duration / steps, repeats: true) { timer in
            
            if self.progress > 0.99 {
                timer.invalidate()
                showingReccomendedBookView = true
            } else {
                self.progress += step
        
            }
        }
    }
}

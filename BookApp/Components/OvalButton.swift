//
//  OvalButton.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 21.02.2024.
//

import SwiftUI

struct OvalButton: View {
    let title: String
    let color: Color
    let textColor: Color
    let action: (() -> Void)
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding()
                .foregroundColor(textColor)
                .background(color, in: Capsule())
        }
    }
}

#Preview {
    OvalButton(title: "Read Now", color: .pink, textColor: .white, action: ({}))
}

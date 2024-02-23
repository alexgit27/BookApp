//
//  VStackText.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 21.02.2024.
//

import SwiftUI

struct VStackText: View {
    let title: String
    let subtitle: String
    let image: String?
    
    var body: some View {
        VStack(spacing: 4) {
            
            HStack {
                Text(title)
                    .fontWeight(.bold)
                    .font(.system(size: 18))
                    .foregroundStyle(Color.theme.black)
                
                if let image {
                    Image(image)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
            
            Text(subtitle)
                .fontWeight(.semibold)
                .font(.system(size: 12))
                .foregroundStyle(Color.theme.gray)
        }
    }
}

#Preview {
    VStackText(title: "22.2K", subtitle: "Readers", image: "Hot")
}

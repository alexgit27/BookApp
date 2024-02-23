//
//  View.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 23.02.2024.
//

import SwiftUI

extension View {
    @ViewBuilder
    func offsetX(_ addObserver: Bool, completion: @escaping (CGRect) -> Void) -> some View {
        self
            .frame(maxWidth: .infinity)
            .overlay {
                if addObserver {
                    GeometryReader(content: {
                        let rect = $0.frame(in: .global)
                        
                        Color.clear.preference(key: OffsetKey.self, value: rect)
                            .onPreferenceChange(OffsetKey.self, perform: completion)
                    })
                }
            }
    }
}

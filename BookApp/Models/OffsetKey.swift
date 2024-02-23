//
//  OffsetKey.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 23.02.2024.
//

import SwiftUI

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

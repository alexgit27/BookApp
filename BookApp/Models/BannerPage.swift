//
//  BannerPage.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 23.02.2024.
//

import SwiftUI

struct BannerPage: Identifiable, Hashable {
    var id: UUID = .init()
    var color: Color
    
    var book: Book
    var allBooks: [Book]
    var youWillLikeBooks: [Book]
}

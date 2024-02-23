//
//  BannerSlide.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import Foundation

struct BannerSlide: Identifiable, Decodable, Hashable {
    let id: Int
    let bookID: Int
    let cover: String
    
    private enum CodingKeys: String, CodingKey {
        case id, bookID = "book_id", cover
    }
    
    static var mock = Self(id: 1, bookID: 2, cover:  "https://firebasestorage.googleapis.com/v0/b/bookapp-b1f1b.appspot.com/o/the_sandman.jpg?alt=media&token=db0c3806-da65-4d96-ba4c-f6cf27a92cd3")
}

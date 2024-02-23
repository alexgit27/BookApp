//
//  Book.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import Foundation

struct Book: Identifiable, Decodable, Hashable {
    let id: Int
    let author: String
    let coverURL: String
    let genre: String
    let likes: String
    let name: String
    let quotes: String
    let summary: String
    let views: String
    
    private enum CodingKeys: String, CodingKey {
        case id, author, coverURL = "cover_url", genre, likes, name, quotes, summary, views
    }
    
    static var mock: Self = Self(id: 0,
              author: "Neil Gaiman",
              coverURL:  "https://firebasestorage.googleapis.com/v0/b/bookapp-b1f1b.appspot.com/o/the_sandman.jpg?alt=media&token=db0c3806-da65-4d96-ba4c-f6cf27a92cd3",
              genre: "Fantasy",
              likes: "30K",
              name: "The Sandman",
              quotes: "20K",
              summary: "Neil Gaiman\'s The Sandman was launched in 1989. This extremely popular series was bound into ten collections. Following Dream of the Endless, also known as Morpheus, Onieros and many other names, we explore a magical world filled with stories both horrific and beautiful.",
              views: "400K")
    
}

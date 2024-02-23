//
//  BannerCell.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import SwiftUI
import Kingfisher

struct BannerCell: View {
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            KFImage(URL(string: book.coverURL))
                .resizable()
                .scaledToFill()
                .frame(height: geo.size.height)
                .clipShape(RoundedRectangle(cornerRadius: 16))}
    }
}

#Preview {
    BannerCell(book: Book.mock)
}

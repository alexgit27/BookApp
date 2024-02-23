//
//  BookCell.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import SwiftUI
import Kingfisher

struct BookCell: View {
    let book: Book
    let textColor: Color
    
    init(book: Book, textColor: Color = .white.opacity(0.7)) {
        self.book = book
        self.textColor = textColor
    }
    
    var body: some View {
        GeometryReader { geo in
             VStack {
                 image(size: geo.size)
                 title()
            }
        }
    }
}

private extension BookCell {
    func image(size: CGSize) -> some View {
        KFImage(URL(string: book.coverURL))
            .resizable()
            .scaledToFill()
            .frame(width: size.width)
            .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    func title() -> some View {
        Text(book.name)
            .fontWeight(.semibold)
            .font(.system(size: 16))
            .foregroundStyle(textColor)
            .minimumScaleFactor(0.5)
            .frame(height: 36)
    }
}

#Preview {
    BookCell(book: Book.mock)
}

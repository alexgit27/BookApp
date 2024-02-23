//
//  RecommendedBookView.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 21.02.2024.
//

import SwiftUI
import Kingfisher

struct RecommendedBookView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var scrollID: Int?
    
    @State var selectedBook: Book
    let youWillLikeBooks: [Book]
    let books: [Book]
    
    var body: some View {
        GeometryReader { geo in
            
            ScrollView(.vertical) {
                
                VStack(spacing: 0) {
                    
                    scrollView(geo.size)
                    
                    VStack(spacing: 0) {
                        bookDetails()
                        
                        defaultDivider()
                        
                        summary(selectedBook.summary)
                        
                        defaultDivider()
                        
                        youWillLike(geo.size)
                        
                        readNow()
                    }
                    .background(Color.white)
                    .clipShape(
                        .rect(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 0,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 20
                        )
                    )
                }
            }
            .scrollIndicators(.hidden)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .foregroundStyle(Color.white)
                    }
                }
            }
            .background(
                VStack(spacing: 0) {
                    Color.theme.darkRed
                    Color.theme.darkRed
                    Color.white
                }
            )
            .ignoresSafeArea()
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    scrollID = selectedBook.id
                }
            })
        }
    }
}

private extension RecommendedBookView {
    func defaultDivider() -> some View {
        Divider()
            .padding(.horizontal, 16)
            .padding(.top, 16)
    }
    
    func scrollView(_ size: CGSize) -> some View {
        guard size != .zero else { return AnyView(EmptyView()) }
        
        let itemWidth = (size.width - 175)
        let itemHeight = itemWidth * 1.25
        
        return AnyView(ScrollView(.horizontal) {
            LazyHStack(spacing: 16) {
                ForEach(books) { book in
                    VStack(spacing: 16) {
                        KFImage(URL(string: book.coverURL))
                            .resizable()
                            .scaledToFill()
                            .frame(width: itemWidth, height: itemHeight)
                            .clipShape(RoundedRectangle(cornerRadius: 16.0))
                            .scrollTransition(.animated, axis: .horizontal) { content, phase in
                                content
                                    .opacity(phase.isIdentity ? 1.0 : 0.8)
                                    .scaleEffect(phase.isIdentity ? 1.0 : 0.8)
                            }
                        
                        VStack(spacing: 4) {
                            Text(book.name)
                                .font(.system(size: 20))
                                .minimumScaleFactor(0.5)
                            
                            Text(book.author)
                                .font(.system(size: 14))
                        }
                        .frame(width: 200)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.white)
                    }
                }
            }
            .scrollTargetLayout()
            .padding(.horizontal, 87)
            .padding(.top, 100)
            .padding(.bottom, 18)
        }
            .scrollIndicators(.hidden)
            .scrollTargetBehavior(.viewAligned)
            .background(Color.theme.darkRed)
            .scrollPosition(id: $scrollID)
            .onChange(of: scrollID) { oldValue, newValue in
                if let newValue {
                    guard let newBook = books.first(where: {$0.id == newValue }) else { return }
                    self.selectedBook = newBook
                }
            })
    }
    
    func bookDetails() -> some View {
        return HStack(spacing: 40) {
            VStackText(title: selectedBook.views,
                       subtitle: "Readers",
                       image: nil)
            
            VStackText(title: selectedBook.likes,
                       subtitle: "Likes",
                       image: nil)
            
            VStackText(title: selectedBook.quotes,
                       subtitle: "Quotes",
                       image: nil)
            
            VStackText(title: selectedBook.genre,
                       subtitle: "Genre",
                       image: "Hot")
        }
        .padding(.top, 21)
    }
    
    func summary(_ description: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Summary")
                .font(.system(size: 20))
                .fontWeight(.medium)
            
            Text(description)
                .font(.system(size: 14))
                .fontWeight(.regular)
        }
        .foregroundStyle(Color.theme.black)
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
    
    func youWillLike(_ size: CGSize) -> some View {
        let itemHeightMultiplier = 1.59
        let itemWidth = CGFloat(size.width / 3)
        
        return VStack(alignment: .leading) {
            Text("You will also like")
                .font(.system(size: 20))
                .fontWeight(.medium)
                .padding(.leading, 16)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(youWillLikeBooks) { book in
                        BookCell(book: book, textColor: Color.black)
                            .frame(width: itemWidth, height: itemWidth * itemHeightMultiplier)
                    }
                }
                .padding(.horizontal, 16)
            }
            .scrollIndicators(.hidden)
        }
        .padding(.top, 16)
    }
    
    func readNow() -> some View {
        OvalButton(title: "Read Now", color: .theme.pink, textColor: .white, action: ({}))
            .padding(.vertical, 24)
            .padding(.horizontal, 48)
    }
}

#Preview {
    RecommendedBookView(selectedBook:.mock, youWillLikeBooks: [.mock], books: [.mock])
}



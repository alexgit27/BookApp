//
//  LibraryView.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import SwiftUI
import PopupView

struct LibraryView: View {
    @StateObject private var vm = LibraryViewModel()
    @State private var scrollID: Int?
    
    var body: some View {
        GeometryReader { geo in
            NavigationStack {
                ScrollView(.vertical) {
                    if vm.error == nil {
                        
                        VStack(spacing: 24) {
                            title()
                            
                            topBanner(size: geo.size)
                            
                            scrollingHStack(title: BookGenre.fantasy.rawValue, size: geo.size, books: vm.fantasyBooks)
                            
                            scrollingHStack(title: BookGenre.science.rawValue, size: geo.size, books: vm.scienceBooks)
                            
                            scrollingHStack(title: BookGenre.romance.rawValue, size: geo.size, books: vm.romanceBooks)
                        }
                        
                    }
                }
                .background(Color.black)
                .popup(isPresented: $vm.isFetching) {
                  fetchingPopup()
                } customize: {
                    $0
                        .backgroundColor(.black.opacity(0.8))
                        .type(.floater())
                        .position(.center)
                        .animation(.spring())
                        .appearFrom(.left)
                        .dragToDismiss(true)
                }
                .popup(isPresented: $vm.showErrorView) {
                    ErrorView(error: $vm.error)
                } customize: {
                    $0
                        .backgroundColor(.black.opacity(0.6))
                        .type(.floater())
                        .position(.top)
                        .animation(.spring())
                        .appearFrom(.top)
                        .dragToDismiss(true)
                }
            }
        }
    }
}

private extension LibraryView {
    func fetchingPopup() -> some View {
        VStack(spacing: 6) {
            Text("Fetching data...")
                .foregroundStyle(Color.white)
                .font(.system(size: 20, weight: .semibold))
            Text("Wait please")
                .foregroundStyle(Color.white.opacity(0.8))
                .font(.system(size: 16, weight: .semibold))
        }
    }

    func title() -> some View {
        Text("Library")
            .frame(maxWidth: .infinity, alignment: .leading)
            .fontWeight(.bold)
            .font(.system(size: 20))
            .foregroundStyle(Color.theme.pink)
            .padding(.leading, 16)
    }
    
    
    func topBanner(size: CGSize) -> some View {
        let itemHeightMultiplier = 0.47
        let itemWidth = CGFloat(size.width - 32)
        let scrollSize = CGSize(width: itemWidth, height: itemWidth * itemHeightMultiplier)
        guard scrollSize.height > .zero else { return AnyView(EmptyView()) }
        
        return AnyView(InfiniteScrollView(listOfPages: $vm.bannerPages).frame(height: scrollSize.height))
    }
    
    func scrollingHStack(title: String, size: CGSize, books: [Book]) -> some View {
        VStack(alignment: .leading) {
            let itemHeightMultiplier = 1.59
            let itemWidth = CGFloat(size.width / 3)
            
            Text(title)
                .fontWeight(.bold)
                .font(.system(size: 20))
                .foregroundStyle(Color.white)
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 8) {
                    ForEach(books) { book in
                        NavigationLink {
                            RecommendedBookView(selectedBook: book, youWillLikeBooks: vm.similarBooks(for: book), books: vm.allGenreBooks(for: book))
                        } label: {
                            BookCell(book: book)
                                .frame(width: itemWidth, height: itemWidth * itemHeightMultiplier)
                        }
                    }
                }
                .padding(.top, 8)
            }
        }
        .padding(.leading, 16)
    }
}

#Preview {
    LibraryView()
}

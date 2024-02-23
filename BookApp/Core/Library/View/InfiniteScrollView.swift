//
//  InfiniteScrollView.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 21.02.2024.
//

import SwiftUI

struct InfiniteScrollView: View {
    private let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    @State private var currentPage = ""
    @State private var fakedPages = [BannerPage]()
    
    @Binding public var listOfPages: [BannerPage]
    // public var scrollSize: CGSize
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let itemHeightMultiplier = 0.47
            let itemWidth = CGFloat(size.width - 32)
            let scrollSize = CGSize(width: itemWidth, height: itemWidth * itemHeightMultiplier)
            
            
            TabView(selection: $currentPage) {
                ForEach(fakedPages) { page in
                    
                    NavigationLink {
                        RecommendedBookView(selectedBook: page.book, youWillLikeBooks: page.youWillLikeBooks, books: page.allBooks)
                    } label: {
                        BannerCell(book: page.book)
                    }
                    .frame(width: scrollSize.width, height: scrollSize.height)
                    .tag(page.id.uuidString)
                    .offsetX(currentPage == page.id.uuidString) { rect in
                        let minX = rect.minX
                        let pageOffset = minX - (size.width * CGFloat(fakeIndex(page)))
                        
                        let pageProgress = pageOffset / size.width
                        if -pageProgress < 1.0 {
                            if fakedPages.indices.contains(fakedPages.count - 1) {
                                currentPage = fakedPages[fakedPages.count - 1].id.uuidString
                            }
                        }
                        
                        if -pageProgress > CGFloat(fakedPages.count - 1) {
                            if fakedPages.indices.contains(1) {
                                currentPage = fakedPages[1].id.uuidString
                            }
                        }
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            .overlay(alignment: .bottom) {
                PageControl(totalPages: listOfPages.count, currentPage: originalIndex(currentPage))
                    .padding(.bottom, 8)
            }
            
        }
        //.frame(height: scrollSize.height)
        .onReceive(timer) { _ in
            nextPage()
        }
        .onChange(of: listOfPages, { oldValue, newValue in
            //guard fakedPages.isEmpty else { return }
            
            fakedPages = listOfPages
            //fakedPages.append(contentsOf: listOfPages)
            
            if var firstPage = listOfPages.first, var lastPage = listOfPages.last {
                
                currentPage = firstPage.id.uuidString
                
                firstPage.id = .init()
                lastPage.id = .init()
                
                
                fakedPages.append(firstPage)
                fakedPages.insert(lastPage, at: 0)
            }
        })
    }
}

private extension InfiniteScrollView {
    
    func fakeIndex(_ of: BannerPage) -> Int {
        fakedPages.firstIndex(of: of) ?? 0
    }
    
    func originalIndex(_ id: String) -> Int {
        listOfPages.firstIndex { page in
            page.id.uuidString == id
        } ?? 0
    }
    
    func nextPage() {
        let index = listOfPages.firstIndex(where: {$0.id.uuidString == currentPage}) ?? 0
        
        if index + 1 == listOfPages.count {
            let newPage = listOfPages[0]
            currentPage = newPage.id.uuidString
        } else {
            let newPage = listOfPages[(index) + 1]
            currentPage = newPage.id.uuidString
        }
    }
    
}

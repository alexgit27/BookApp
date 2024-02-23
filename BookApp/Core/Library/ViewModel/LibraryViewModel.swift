//
//  LibraryViewModel.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 20.02.2024.
//

import Foundation
import Combine

class LibraryViewModel: ObservableObject {
    private let dataManager = RemoteConfigManager.shared
    private var data = [String:Any]()
    private var books = [Book]()
    private var topBannerSlides = [BannerSlide]()
    
    @Published public var fantasyBooks = [Book]()
    @Published public var scienceBooks = [Book]()
    @Published public var romanceBooks = [Book]()
    @Published public var bannerPages = [BannerPage]()
    
    @Published public var showErrorView: Bool = false
    @Published public var error: Error?
    @Published public var isFetching: Bool = false
    
    init() {
        Task { await setup() }
    }
}

extension LibraryViewModel {
    @MainActor
    func setup() async {
        isFetching = true
        
        do {
            data = try await dataManager.fetchJSONData() ?? [:]
            
            self.books = try getBooks(from: data)
            self.fantasyBooks = books.filter({$0.genre == BookGenre.fantasy.rawValue})
            self.scienceBooks = books.filter({$0.genre == BookGenre.science.rawValue})
            self.romanceBooks = books.filter({$0.genre == BookGenre.romance.rawValue})
            
            self.topBannerSlides = try getTopBannerSlides(from: data)
            let idsBannerBooks = topBannerSlides.map { $0.bookID }
            let bannerBooks = books.filter({idsBannerBooks.contains($0.id)})
            self.bannerPages = bannerBooks.map({.init(color: .blue, book: $0, allBooks: allGenreBooks(for: $0), youWillLikeBooks: similarBooks(for: $0))})
            
            isFetching = false
        } catch {
            isFetching = false
            self.error = error
            self.showErrorView = true
            print("Error at fetching JSON data from Remote Config: \(error.localizedDescription)")
        }
    }

    func getBooks(from data: [String:Any]) throws -> [Book] {
        do {
            let decoder = JSONDecoder()
            let booksData = try JSONSerialization.data(withJSONObject: data[RemoteConfigKeys.books.rawValue] ?? [])
            let decodedBooks = try decoder.decode([Book].self, from: booksData)
            return decodedBooks
        } catch {
            throw error
        }
    }

    func getTopBannerSlides(from data: [String:Any]) throws -> [BannerSlide] {
        do {
            let decoder = JSONDecoder()
            let slidesData = try JSONSerialization.data(withJSONObject: data[RemoteConfigKeys.topBannerSlides.rawValue] ?? [])
            let decodedSlides = try decoder.decode([BannerSlide].self, from: slidesData)
            return decodedSlides
        } catch {
            throw error
        }
    }
    
    func getSimialarBooksIds(from data: [String:Any]) throws -> [Int] {
        do {
            let decoder = JSONDecoder()
            let slidesData = try JSONSerialization.data(withJSONObject: data[RemoteConfigKeys.youWillLikeSection.rawValue] ?? [])
            let ids = try decoder.decode([Int].self, from: slidesData)
            return ids
        } catch {
            throw error
        }
    }
    
    func allGenreBooks(for book: Book) -> [Book] {
        books.filter({$0.genre == book.genre})
    }
    
    func similarBooks(for book: Book) -> [Book] {
        let ids = (try? getSimialarBooksIds(from: data)) ?? []
        return books.filter({ids.contains($0.id)})
    }
    
}

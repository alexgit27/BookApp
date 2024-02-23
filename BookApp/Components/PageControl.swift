//
//  PageControl.swift
//  BookApp
//
//  Created by Alexandr Ananchenko on 23.02.2024.
//

import SwiftUI

struct PageControl: UIViewRepresentable {
    var totalPages: Int
    var currentPage: Int
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = totalPages
        control.currentPage = currentPage
        control.backgroundStyle = .minimal
        control.allowsContinuousInteraction = false
        control.currentPageIndicatorTintColor = UIColor(Color.theme.pink)
        control.pageIndicatorTintColor = .gray
        
        return control
    }
    
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.numberOfPages = totalPages
        uiView.currentPage = currentPage
    }
}


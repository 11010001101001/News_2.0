//
//  TopicCell.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicCell: View {
    @State private var scale = 1.0
    let article: Article

    var body: some View {
        VStack(alignment: .leading,
               content: {
            Text(article.title ?? .empty)
                .padding(.bottom)
                .font(.headline)
            Text(article.publishedAt?.toReadableDate() ?? .empty)
                .font(.subheadline)
            Text(article.source?.name ?? .empty)
                .font(.subheadline)
        })
        .scaleEffect(scale)
        .onAppear {
            withAnimation(.bouncy(duration: 0.1)) {
                scale = 1.03
            } completion: {
                withAnimation(.bouncy(duration: 0.2, extraBounce: 0.3)) {
                    scale = 1.0
                }
            }
        }
    }
}

#Preview {
    TopicCell(article: Article(source: Source(id: UUID().uuidString,
                                              name: "Source"),
                               title: "Title",
                               publishedAt: Date().makeTestDateString()))
}

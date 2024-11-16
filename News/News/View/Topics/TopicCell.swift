//
//  TopicCell.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicCell: View {
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
    }
}

#Preview {
    TopicCell(article: Article(source: Source(id: UUID().uuidString,
                                              name: "Source"),
                               title: "Title",
                               publishedAt: Date().makeTestDateString()))
}

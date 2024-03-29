//
//  TopicCell.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicCell: View {
    let article: Articles

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
    TopicCell(article: Articles(source: Source(id: UUID().uuidString,
                                               name: "Source"),
                                title: "Title",
                                publishedAt: makeTestDateString()))

}

func makeTestDateString() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    dateFormatter.locale = Locale(identifier: "en_En")
    return dateFormatter.string(from: Date())
}

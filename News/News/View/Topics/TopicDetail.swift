//
//  Topic.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicDetail: View, RandomProvider {

    let article: Articles
    let action: Action

    @State var rotating = false
    @State var scale = 0.85

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: article.urlToImage ?? .empty)) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: CGFloat.screenWidth - 32,
                               height: 300,
                               alignment: .center)
                        .clipped()
                        .clipShape(.buttonBorder)
                        .shadow(color: Color(image.averageColor), radius: 60)
                        .applyNice3DRotation(rotating: rotating, coordinates: randomCoordinates)
                        .onAppear { rotating.toggle() }
                } else if phase.error != nil {
                    ErrorView(
                        title: "Error loading image...",
                        action: nil)
                    .applyNice3DRotation(rotating: rotating, coordinates: randomCoordinates)
                    .onAppear { rotating.toggle() }
                } else {
                    Loader()
                }
            }
            .frame(height: 300)
            .padding(.vertical)
            .padding(.horizontal)

            VStack {
                Text(article.description ?? .empty)
                    .padding(.bottom)
                    .padding(.horizontal)
                Spacer()
                CustomButton(title: "More", action: action)
                    .padding(.bottom)
            }
            .scaleEffect(scale)
            .onAppear {
                withAnimation(.bouncy) {
                    scale = 1.0
                }
            }
        }
        .navigationTitle("Details")
    }
}

#Preview {
    TopicDetail(article: Articles(source: Source(id: UUID().uuidString,
                                                 name: "Source"),
                                  title: "Title",
                                  description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
                                  publishedAt: "Time"),
                action: {
        print("tapped")
    })
}

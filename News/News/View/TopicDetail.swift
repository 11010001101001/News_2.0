//
//  Topic.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicDetail: View, RandomProvider {

    let article: Articles

    @State var rotating = false

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
                        .applyNice3DRotation(rotating: &rotating, coordinates: randomCoordinates)
                        .onAppear { rotating.toggle() }
                } else if phase.error != nil {
                    ErrorView(
                        title: "Error loading image...",
                        action: nil)
                    .applyNice3DRotation(rotating: &rotating, coordinates: randomCoordinates)
                    .onAppear { rotating.toggle() }
                } else {
                    ProgressView()
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
                CustomButton(title: "More", action: {})
                    .padding(.bottom)
            }
        }
    }
}

struct TestAnimationView: View, RandomProvider {

    @State var rotating = false

    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundStyle(.blue)
            .frame(width: 100, height: 100)
            .shadow(color: .blue, radius: 60)
            .applyNice3DRotation(rotating: &rotating, coordinates: randomCoordinates)
            .onAppear { rotating.toggle() }
    }

}

#Preview {
//    TopicDetail(article: Articles(source: Source(id: UUID().uuidString,
//                                                 name: "Source"),
//                                  title: "Title",
//                                  description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
//                                  publishedAt: "Time"))
    TestAnimationView()
}

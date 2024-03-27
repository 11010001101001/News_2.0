//
//  Topic.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct TopicDetail: View {

    var article: Articles

    @State var rotating = false

    private let random = CGFloat((-1...1).randomElement() ?? .zero)

    private var rotationCoordinates: [(x: CGFloat, y: CGFloat, z: CGFloat)] {
        var coordinates = [(x: CGFloat, y: CGFloat, z: CGFloat)]()

        for _ in 0...10 {
            coordinates.append((x: random, y: random, z: random))
        }

        return coordinates
    }

    private var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }

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
                        .rotation3DEffect(
                            Angle(degrees: rotating ? -10 : 10),
                            axis: rotating ? randomCoordinates : randomCoordinates,
                            anchor: .center,
                            anchorZ: 0.5,
                            perspective: rotating ? 1 : -1
                        )
                        .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true),
                                   value: rotating)
                        .onAppear { rotating.toggle() }
                        .scaleEffect(rotating ? 1 : 0)
                        .animation(.smooth(duration: 1.2,
                                           extraBounce: 0.6),
                                   value: rotating)
                } else if phase.error != nil {
                    ErrorView(
                        title: "Error loading image...",
                        action: nil)
                    .rotation3DEffect(
                        Angle(degrees: rotating ? -10 : 10),
                        axis: rotating ? randomCoordinates : randomCoordinates,
                        anchor: .center,
                        anchorZ: 0.5,
                        perspective: rotating ? 1 : -1
                    )
                    .animation(.easeInOut(duration: 10).repeatForever(autoreverses: true),
                               value: rotating)
                    .onAppear { rotating.toggle() }
                    .scaleEffect(rotating ? 1 : 0)
                    .animation(.smooth(duration: 1.2,
                                       extraBounce: 0.6),
                               value: rotating)
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

struct KeyframeAnimationView: View {

    @State var rotating = false

    private let random = CGFloat((-1...1).randomElement() ?? .zero)

    private var rotationCoordinates: [(x: CGFloat, y: CGFloat, z: CGFloat)] {
        var coordinates = [(x: CGFloat, y: CGFloat, z: CGFloat)]()

        for _ in 0...10 {
            coordinates.append((x: random, y: random, z: random))
        }

        return coordinates
    }

    private var randomCoordinates: (x: CGFloat, y: CGFloat, z: CGFloat) {
        rotationCoordinates.randomElement() ?? (x: 1.0, y: 1.0, z: 0.0)
    }

    var totalDuration = 1.0
    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundStyle(.blue)
            .frame(width: 100, height: 100)
            .shadow(color: .blue, radius: 60)
            .rotation3DEffect(
                Angle(degrees: rotating ? -10 : 10),
                axis: rotating ? randomCoordinates : randomCoordinates,
                anchor: .center,
                anchorZ: 1,
                perspective: rotating ? 1 : -1
            )
            .animation(.easeInOut(duration: 3).repeatForever(autoreverses: true),
                       value: rotating)
            .onAppear { rotating.toggle() }
            .scaleEffect(rotating ? 1 : 0)
            .animation(.smooth(duration: 1.2,
                               extraBounce: 0.6),
                       value: rotating)
    }

}

#Preview {
//    TopicDetail(article: Articles(source: Source(id: UUID().uuidString,
//                                                 name: "Source"),
//                                  title: "Title",
//                                  description: "Very long description of the topic if you really want this for testing for example i dont know what to type more here but i guess it's enough",
//                                  publishedAt: "Time"))
    KeyframeAnimationView()
}

//
//  ContentView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
//    @Environment(\.modelContext) private var modelContext
//    @Query private var items: [Item]
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        NavigationView {
            ZStack {
                ProgressView()

                List {
                    ForEach($viewModel.newsArray) { $item in
                        ZStack {
                            NavigationLink {
                                TopicDetail(article: item)
                            } label: {
                                Topic(article: item)
                                    .ignoresSafeArea()
                            }
                        }
                    }
                }
                .opacity($viewModel.loadingSucceed.wrappedValue ? 1.0 : .zero)

                ErrorView(
                    title: $viewModel.failureReason.wrappedValue,
                    action: { viewModel.loadNews() })
                .opacity($viewModel.loadingFailed.wrappedValue ? 1.0 : .zero)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        Settings()
                    } label: {
                        Label("", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("News")

        }
//        .tint(.black)
        .onAppear {
            // commented while debugging
            viewModel.loadNews()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
        .modelContainer(for: Item.self, inMemory: true)
}

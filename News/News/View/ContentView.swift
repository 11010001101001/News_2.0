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

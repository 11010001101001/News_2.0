//
//  ContentView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query var savedSettings: [SettingsModel]

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
                        Settings { name in
                            viewModel.applySettings(name)
                        }
                    } label: {
                        Label("", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("News")

        }
        .onAppear {
            if savedSettings.isEmpty {
                let defaultSettings = [SettingsModel(category: Categories.technology.rawValue, soundTheme: SoundThemes.starwars.rawValue)]
                modelContext.insert(defaultSettings[0])
                try? modelContext.save()
                
                viewModel.savedSettings = defaultSettings
            } else {
                viewModel.savedSettings = savedSettings
            }
            viewModel.loadNews()
        }
    }
}

#Preview {
    ContentView(viewModel: ViewModel())
        .modelContainer(for: SettingsModel.self, inMemory: true)
}

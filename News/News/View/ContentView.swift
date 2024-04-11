//
//  ContentView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    @Environment(ViewModel.self) private var viewModel

    @Environment(\.modelContext) var modelContext

    @Query private var savedSettings: [SettingsModel]

    var body: some View {
        NavigationStack {
            TopicsList(viewModel: viewModel)
                .refreshable { refresh() }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    NavigationLink {
                        SettingsList(viewModel: viewModel)
                    } label: {
                        Label("", systemImage: "gear")
                    }
                }
            }
            .navigationTitle("News")
        }
        .onAppear { onAppear() }
    }
}

// MARK: - Helpers
extension ContentView {
    private func onAppear() {
        loadSettings()
        viewModel.loadNews()
        viewModel.configureNotifications()
    }

    private func loadSettings() {
        if savedSettings.isEmpty {
            let defaultSettings = [SettingsModel(category: Category.business.rawValue,
                                                 soundTheme: SoundTheme.silentMode.rawValue,
                                                 loader: LoaderConfiguration.hourGlass.rawValue)]
            modelContext.insert(defaultSettings[0])
            try? modelContext.save()

            viewModel.savedSettings = defaultSettings
        } else {
            viewModel.savedSettings = savedSettings
        }

        viewModel.redrawContentViewLoader()
    }

    private func refresh() {
        viewModel.playRefresh()
        viewModel.loadNews()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: SettingsModel.self, inMemory: true)
}

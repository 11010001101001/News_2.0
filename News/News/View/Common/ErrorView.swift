//
//  ErrorView.swift
//  News
//
//  Created by Ярослав Куприянов on 26.03.2024.
//

import SwiftUI

struct ErrorView: View {

    var title: String
    var action: Action

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Label(title, systemImage: "bolt.fill")
                        .labelStyle(.titleOnly)
                        .fontDesign(.monospaced)
                        .foregroundStyle(.gray)
                        .multilineTextAlignment(.center)
                        .font(.body)
                        .padding(EdgeInsets(top: .zero,
                                            leading: 100,
                                            bottom: .zero,
                                            trailing: 100))

                    Image("ErrorCat")
                        .resizable()
                        .imageScale(.small)
                        .frame(width: 90, height: 100)
                }

                CustomButton(title: "Reload", action: action)
            }
        }
    }
}

#if DEBUG
#Preview {
    ErrorView(title: "Time - out\nerror\n\nServer problem or internet connection broken",
              action: {
        print("Button pressed")
    })
}
#endif

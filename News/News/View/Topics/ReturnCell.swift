//
//  ReturnCell.swift
//  News
//
//  Created by Ярослав Куприянов on 03.04.2024.
//

import SwiftUI
import Lottie

struct ReturnCell: View {
    let action: Action

    var body: some View {
        HStack {
            Spacer()

            Text("That's all. Return?")
                .font(.headline)
                .padding(.leading)

            LottieButton(animation: .named("button"), action: action ?? {})
                .frame(width: 100, height: 80)
                .shadow(color: .white, radius: 10)
                .padding(.trailing)

            Spacer()
        }
    }
}

#Preview {
    ReturnCell(action: {})
}

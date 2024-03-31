//
//  CheckMark.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct CheckMark: View, RandomProvider {

    @State var rotating = false

    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundStyle(.blue)
            .frame(width: 30, height: 30)
            .shadow(color: .blue, radius: 20)
            .applyNice3DRotation(rotating: rotating,
                                 duration: 2,
                                 coordinates: randomCoordinates)
            .onAppear { rotating.toggle() }
    }
}

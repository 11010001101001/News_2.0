//
//  CheckMark.swift
//  News
//
//  Created by Ярослав Куприянов on 29.03.2024.
//

import SwiftUI

struct CheckMark: View {
    @State var rotating = false

    var body: some View {
        Image(systemName: "checkmark.circle.fill")
            .resizable()
            .foregroundStyle(.blue)
            .frame(width: 25, height: 25)
            .applyNice3DRotation(rotating: rotating, duration: 0.7)
            .onAppear { rotating.toggle() }
    }
}

#Preview {
    CheckMark(rotating: false)
}

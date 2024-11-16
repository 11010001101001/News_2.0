//
//  AnswerNegative.swift
//  News
//
//  Created by Ярослав Куприянов on 12.07.2024.
//

import SwiftUI

struct AnswerNegative: ViewModifier {
    @State private var left = false
    @State private var right = false
    @State private var initial = false
    var execute: Action?

    func body(content: Content) -> some View {
        content
            .offset(x: left ? -5 : 0)
            .offset(x: right ? 10 : 0)
            .offset(x: initial ? -5 : 0)
            .onTapGesture {
                withAnimation { left.toggle() }
            completion: {
                withAnimation { right.toggle() }
            completion: {
				withAnimation(
					.interpolatingSpring(
						stiffness: 1000,
						damping: 9
					)
				) {
					execute??()
					initial.toggle()
				}
			}
			}
			}
    }
}

#Preview {
    Circle()
        .frame(width: 100, height: 100, alignment: .center)
        .modifier(AnswerNegative())
}

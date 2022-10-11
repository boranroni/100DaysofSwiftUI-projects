//
//  test.view.swift
//  Guess The Flag
//
//  Created by Boran Roni on 4.10.2022.
//

import SwiftUI

struct test_view: View {
    @State private var animationAmount = 1.0
    @State private var enabled = false
    @State private var enabled2 = false

    var body: some View {
        VStack {
            Stepper("Scale amount", value: $animationAmount.animation(), in: 1...10)

            Spacer()

            Button("Tap Me") {
                enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? .blue : .red)
            .animation(.default, value: enabled)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1), value: enabled)
            .frame(width: 200, height: 200)
            .background(enabled2 ? .blue : .red)
            .animation(.default, value: enabled2)
        }
    }
}

struct test_view_Previews: PreviewProvider {
    static var previews: some View {
        test_view()
    }
}

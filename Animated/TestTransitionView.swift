//
//  TestTransitionView.swift
//  Animated
//
//  Created by FS on 2024/1/29.
//

import SwiftUI

struct TestTransitionView: View {
    @State var isOn = false
    
    var body: some View {
        ZStack {
            Color.pink
            
            
            if !isOn {
                Text("Hello World!")
                    .zIndex(1)
                    .transition(.opacity)
            }
            
            Button {
                withAnimation {
                    isOn.toggle()
                }
            } label: {
                Text("Toggle")
            }
            .offset(y: 100)

        }
    }
}

#Preview {
    TestTransitionView()
}

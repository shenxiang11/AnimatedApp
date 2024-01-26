//
//  ContentView.swift
//  Animated
//
//  Created by FS on 2024/1/26.
//

import SwiftUI
import RiveRuntime

struct ContentView: View {
    @AppStorage("selectedTab") private var selectedTab: Tab = .chat
    @State var isOpen = false
    let button = {
        let vm = RiveViewModel(fileName: "menu_button", stateMachineName: "State Machine", autoPlay: false)
        vm.setInput("isOpen", value: false)
        return vm
    }()
    var body: some View {
        ZStack {
            TabView(selection: $selectedTab) {
                OnboardingView()
                    .tag(Tab.chat)
                
                Text("2")
                    .tag(Tab.search)

                Text("3")
                    .tag(Tab.timer)

                Text("4")
                    .tag(Tab.bell)

                Text("5")
                    .tag(Tab.user)
            }
        
            button.view()
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: .shadow.opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .onTapGesture {
                    isOpen.toggle()
                }
            
            TabBar()
        }
        .onChange(of: isOpen) { _, newValue in
            button.setInput("isOpen", value: newValue)
        }
    }
}

#Preview {
    ContentView()
}

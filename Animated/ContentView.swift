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
    @State var show = false
    @State var showTabbar = true
    let button = {
        let vm = RiveViewModel(fileName: "menu_button", autoPlay: false)
        vm.setInput("isOpen", value: false)
        return vm
    }()
    
    var body: some View {
        ZStack {
            Color.background2
                .ignoresSafeArea()
            
            SideMenu()
                .offset(x: isOpen ? 0 : -300)
            
            
            TabView(selection: $selectedTab) {
                Group {
                    HomeView()
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
                .safeAreaInset(edge: .bottom) {
                    Color.clear.frame(height: 80)
                }
                .safeAreaInset(edge: .top) {
                    Color.clear.frame(height: 104)
                }
                .ignoresSafeArea()
            }
            .allowsHitTesting(!isOpen)
            .mask {
                RoundedRectangle(cornerRadius: 30, style: .continuous)
            }
            .offset(x: isOpen ? 300 : 0)
            .scaleEffect(isOpen ? 0.9: 1)
            .scaleEffect(show ? 0.92 : 1)
            .rotation3DEffect(
                .degrees(isOpen ? 30 : 0),
                axis: (x: 0, y: -1, z: 0)
            )
            .ignoresSafeArea()
            
            Image(systemName: "person")
                .frame(width: 36, height: 36)
                .background(.white)
                .mask(Circle())
                .shadow(color: .shadow.opacity(0.2), radius: 5, x: 0, y: 5)
                .onTapGesture {
                    withAnimation(.spring) {
                        show = true
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding()
                .offset(y: 4)
                .offset(x: isOpen ? 100 : 0)
            
            button.view()
                .frame(width: 44, height: 44)
                .mask(Circle())
                .shadow(color: .shadow.opacity(0.2), radius: 5, x: 0, y: 5)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .padding()
                .offset(x: isOpen ? 216 : 0)
                .onTapGesture {
                    withAnimation(.smooth) {
                        isOpen.toggle()
                    }
                }
            
            if showTabbar {
                TabBar()
                    .offset(y: -24)
                    .background {
                        LinearGradient(colors: [.background.opacity(0), .background], startPoint: .top, endPoint: .bottom)
                            .frame(height: 150)
                            .frame(maxHeight: .infinity, alignment: .bottom)
                            .allowsHitTesting(false)
                    }
                    .ignoresSafeArea()
                    .zIndex(1)
                    .transition(.move(edge: .bottom))
            }
            
            if show {
                OnboardingView(show: $show)
                    .background(.white)
                    .mask {
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    }
                    .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                    .ignoresSafeArea(.all, edges: .top)
                    .offset(y: show ? -10 : 0)
                    .zIndex(1)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
        }
        .onChange(of: isOpen) { _, newValue in
            withAnimation {
                showTabbar = !newValue
            }
            button.setInput("isOpen", value: !newValue)
            
            UIApplication.shared.setStatusBarStyle(newValue ? .lightContent : .darkContent, animated: true)
        }
        .onChange(of: show, { _, newValue in
            withAnimation {
                showTabbar = !newValue
            }
        })
        .onAppear {
            UITabBar.appearance().isHidden = true
        }
    }
}

#Preview {
    ContentView()
}

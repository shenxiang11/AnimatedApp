//
//  TabBar.swift
//  Animated
//
//  Created by FS on 2024/1/26.
//

import SwiftUI
import RiveRuntime

struct TabBar: View {
    @Namespace private var ns
    @AppStorage("selectedTab") private var selectedTab = Tab.chat
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                content
            }
            .padding(12)
            .background(.background2.opacity(0.8))
            .background(.ultraThinMaterial)
            .mask {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
            }
            .shadow(color: .background2.opacity(0.3), radius: 20, x: 0, y: 20)
            .overlay {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .stroke(
                        .linearGradient(colors: [.white.opacity(0.5), .white.opacity(0)], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            }
            .padding(.horizontal, 24)
        }
    }
    
    var content: some View {
        ForEach(tabItems) { item in
            Button {
                item.icon.setInput("active", value: true)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    item.icon.setInput("active", value: false)
                }
                withAnimation {
                    selectedTab = item.tab
                }
            } label: {
                item.icon.view()
                    .frame(height: 36)
                    .opacity(selectedTab == item.tab ? 1 : 0.5)
                    .background {
                        if selectedTab == item.tab {
                            VStack {
                                RoundedRectangle(cornerRadius: 2)
                                    .frame(width: 20, height: 4)
                                    .offset(y: -4)
                                Spacer()
                            }
                            .matchedGeometryEffect(id: "Bar", in: ns, properties: .frame, isSource: true)
                        }
                    }
            }
        }
    }
}

struct TabItem: Identifiable {
    let id = UUID()
    var icon: RiveViewModel
    var tab: Tab
}

let tabItems = [
    TabItem(icon: RiveViewModel(fileName: "icons", artboardName: "CHAT"), tab: .chat),
    TabItem(icon: RiveViewModel(fileName: "icons", artboardName: "SEARCH"), tab: .search),
    TabItem(icon: RiveViewModel(fileName: "icons", artboardName: "TIMER"), tab: .timer),
    TabItem(icon: RiveViewModel(fileName: "icons", artboardName: "BELL"), tab: .bell),
    TabItem(icon: RiveViewModel(fileName: "icons", artboardName: "USER"), tab: .user),
]

enum Tab: String, Hashable {
    case chat
    case search
    case timer
    case bell
    case user
}

#Preview {
    TabBar()
}

//
//  MenuRow.swift
//  Animated
//
//  Created by FS on 2024/1/29.
//

import SwiftUI

struct MenuRow: View {
    @Binding var selectedMenu: SelectedMenu
    var item: MenuItem
    
    var body: some View {
        HStack(spacing: 14.0) {
            item.icon.view()
                .frame(width: 32, height: 32)
                .opacity(0.6)
            Text(item.text)
                .customFont(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .background {
            if selectedMenu == item.menu {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(.blue)
            }
        }
        .background {
            Color("Background 2")
        }
        .onTapGesture {
            item.icon.setInput("active", value: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                item.icon.setInput("active", value: false)
            }
            withAnimation(.spring) {
                selectedMenu = item.menu
            }
        }
    }
}

#Preview {
    MenuRow(selectedMenu: .constant(.home), item: menuItems[0])
}

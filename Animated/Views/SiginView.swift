//
//  SiginView.swift
//  Animated
//
//  Created by FS on 2024/1/26.
//

import SwiftUI
import RiveRuntime

struct SiginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoading = false
    @Binding var showModal: Bool
    let check = RiveViewModel(fileName: "check")
    let confetti = RiveViewModel(fileName: "confetti")
    
    var body: some View {
        VStack(spacing: 24) {
            Text("Sign In")
                .customFont(.largeTitle)
            
            Text("Access to 240+ hours of content. Learn design and code, by building real apps with React and Swift.")
                .customFont(.headline)
            
            
            VStack(alignment: .leading) {
                Text("Email")
                    .customFont(.subheadline)
                    .foregroundStyle(.secondary)
                TextField("", text: $email)
                    .customTextField()
            }
            
            VStack(alignment: .leading) {
                Text("Password")
                    .customFont(.subheadline)
                    .foregroundStyle(.secondary)
                SecureField("", text: $password )
                    .customTextField(image: Image(.iconLock))
            }
            
            Button {
                login()
            } label: {
                Label("Sign In", systemImage: "arrow.right")
                    .customFont(.headline)
                    .padding(20)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background {
                        UnevenRoundedRectangle(cornerRadii: RectangleCornerRadii(topLeading: 8, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20))
                            .foregroundStyle(.pink)
                    }
                    .shadow(color: .pink.opacity(0.5), radius: 20, x: 0, y: 10)
            }

            
            HStack {
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
                Text("OR")
                    .customFont(.subheadline2)
                    .foregroundStyle(.black.opacity(0.3))
                Rectangle()
                    .frame(height: 1)
                    .opacity(0.1)
            }
            
            Text("Sign up with Email, Apple or Google")
                .customFont(.subheadline)
                .foregroundStyle(.secondary)
            
            HStack {
                Image(.logoEmail)
                Spacer()
                Image(.logoApple)
                Spacer()
                Image(.logoGoogle)
                
            }
        }
        .padding(30)
        .background(.regularMaterial)
        .mask {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
        }
        .shadow(color: .shadow.opacity(0.3), radius: 5, x: 0, y: 3)
        .shadow(color: .shadow.opacity(0.3), radius: 30, x: 0, y: 30)
        .overlay {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(
                    .linearGradient(colors: [.white.opacity(0.8), .white.opacity(0.1)], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
        }
        .padding()
        .overlay {
            if isLoading {
                check.view()
                    .frame(width: 100, height: 100)
                    .allowsHitTesting(false)
            }
            confetti.view()
                .scaleEffect(3)
                .allowsHitTesting(false)
        }
    }
    
    private func login() {
        isLoading = true
        
        if email.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                check.triggerInput("Error")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
                check.reset()
            }
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                check.triggerInput("Check")
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isLoading = false
                confetti.triggerInput("Trigger explosion")
                check.reset()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    showModal = false
                }
            }
        }
    }
}

#Preview {
    SiginView(showModal: .constant(true))
}

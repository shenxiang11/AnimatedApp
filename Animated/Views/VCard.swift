//
//  VCard.swift
//  Animated
//
//  Created by FS on 2024/1/26.
//

import SwiftUI

struct VCard: View {
    var course: Course
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .customFont(.title2)
                .frame(maxWidth: 170, alignment: .leading)
                .layoutPriority(1)
            
            Text(course.subtitle)
                .customFont(.subheadline)
                .opacity(0.7)
            
            Text(course.caption.uppercased())
                .customFont(.footnote2)
            
            Spacer()
            
            HStack {
                ForEach(Array([4, 5, 6].shuffled().enumerated()), id: \.offset) { index, num in
                    Image("Avatar \(Int(num))")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .mask(Circle())
                        .offset(x: CGFloat(index * -20))
                }
            }
        }
        .foregroundStyle(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background {
            LinearGradient(colors: [course.color, course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
        }
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .overlay {
            course.image
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .padding(20)
        }
    }
}

#Preview {
    VCard(course: courses[2])
}

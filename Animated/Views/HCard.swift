//
//  HCard.swift
//  Animated
//
//  Created by FS on 2024/1/29.
//

import SwiftUI

struct HCard: View {
    var section: CourseSection
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8.0) {
                Text(section.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .customFont(.body)
            }
            Divider()
            section.image
        }
        .padding(30)
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(section.color)
        .foregroundStyle(.white)
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
    }

}

#Preview {
    HCard(section: courseSections[2])
}

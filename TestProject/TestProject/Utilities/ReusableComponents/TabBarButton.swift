//
//  TabBarButton.swift
//  TestProject
//
//  Created by Ahfas Rinu on 17/01/24.
//

import SwiftUI

struct TabBarButton: View {
    let tabItem: TabType
    var foregroundColour: Color
    var title: String
    var isSelected: Bool
    var body: some View {
        VStack(spacing: 0) {
            Text(title)
                .foregroundColor(isSelected ? foregroundColour : Color.gray)
                .font(.system(size: 22, weight: .regular, design: .rounded))
                .padding(.bottom, 16)
            Rectangle()
                .frame(height: 2)
                .foregroundColor(isSelected ? foregroundColour : .clear)
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
        }
    }
}

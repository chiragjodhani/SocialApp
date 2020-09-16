//
//  CustomTabbar.swift
//  Social-App
//
//  Created by Chirag's on 16/09/20.
//

import SwiftUI

struct CustomTabbar: View {
    @Binding var selectedTab: String
    var body: some View {
        HStack(spacing:65){
            TabButton(title: "Posts", selectedTab: $selectedTab)
            TabButton(title: "Settings", selectedTab: $selectedTab)
        }.padding(.horizontal)
        .background(Color.white)
        .clipShape(Capsule())
    }
}

struct TabButton: View {
    var title: String
    @Binding var selectedTab: String
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            VStack(spacing: 10) {
                Image(title).resizable().renderingMode(.template).frame(width: 35, height: 35)
                Text(title).font(.caption).fontWeight(.bold)
            }.foregroundColor(selectedTab == title ? Color("blue") : .gray)
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}

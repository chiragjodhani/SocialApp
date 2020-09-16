//
//  Home.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI

struct Home: View {
    @State var selectedTab = "Posts"
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .bottom)) {
            ZStack {
                PostView().opacity(selectedTab == "Posts" ? 1 : 0)
                SettingView().opacity(selectedTab == "Settings" ? 1 : 0)
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            CustomTabbar(selectedTab: $selectedTab)
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all)).ignoresSafeArea(.all, edges: .top)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

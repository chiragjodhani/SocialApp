//
//  ContentView.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("current_status") var status = false
    var body: some View {
        NavigationView {
            VStack {
                if status {
                    Home()
                }else {
                    LoginView()
                }
            }
            RegisterView().navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

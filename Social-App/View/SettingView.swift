//
//  SettingView.swift
//  Social-App
//
//  Created by Chirag's on 16/09/20.
//

import SwiftUI
import SDWebImageSwiftUI
struct SettingView: View {
    var edges = UIApplication.shared.windows.first?.safeAreaInsets
    @StateObject var settingData = SettingViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Settings").font(.largeTitle).fontWeight(.heavy).foregroundColor(.white)
                Spacer(minLength: 0)
                
            }.padding().padding(.top, edges!.top).background(Color("bg")).shadow(color: Color.white.opacity(0.06), radius: 5, x: 0, y: 5)
            
            if settingData.userInfo.pic != "" {
                ZStack {
                    WebImage(url: URL(string: settingData.userInfo.pic)!).resizable().aspectRatio(contentMode: .fill).frame(width: 125, height: 125).clipShape(Circle())
                    
                    if settingData.isLoading {
                        ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("blue")))
                    }
                }.padding(.top, 25)
                .onTapGesture {
                    settingData.picker.toggle()
                }
                
            }
            
            HStack(spacing: 15) {
                Text(settingData.userInfo.username).font(.title).fontWeight(.bold).foregroundColor(.white)
                
                Button(action: {
                    self.settingData.updateFields(field: "Name")
                }) {
                    Image(systemName: "pencil.circle.fill").font(.system(size: 24)).foregroundColor(.white)
                }
            }.padding()
            
            HStack(spacing: 15) {
                Text(settingData.userInfo.bio).foregroundColor(.white)
                
                Button(action: {
                    self.settingData.updateFields(field: "Bio")
                }) {
                    Image(systemName: "pencil.circle.fill").font(.system(size: 24)).foregroundColor(.white)
                }
            }
            
            Button(action: {
                settingData.logOut()
            }) {
                Text("Logout").foregroundColor(.white).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 100).background(Color("blue")).clipShape(Capsule())
            }.padding()
            .padding(.top, 10)
            
            Spacer(minLength: 0)
        }
        .sheet(isPresented: $settingData.picker) {
            ImagePicker(picker: $settingData.picker, img_Data: $settingData.image_Data)
        }
        .onChange(of: settingData.image_Data) { (newData) in
            settingData.updateImage()
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}

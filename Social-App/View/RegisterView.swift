//
//  RegisterView.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var registerData = RegisterViewModel()
    var body: some View {
        VStack {
            HStack {
                Text("Register").font(.largeTitle).fontWeight(.heavy).foregroundColor(.white)
                Spacer(minLength: 0)
            }.padding()
            
            ZStack {
                if registerData.image_Data.count == 0 {
                    Image(systemName: "person").font(.system(size: 65)).foregroundColor(.black).frame(width: 115, height: 115).background(Color.white).clipShape(Circle())
                }else {
                    Image(uiImage: UIImage(data: registerData.image_Data)!).resizable().aspectRatio(contentMode: .fill).frame(width: 115, height: 115).clipShape(Circle())
                }
            }.padding(.top).onTapGesture {
                self.registerData.picker.toggle()
            }
            
            HStack(spacing: 15) {
                TextField("Name", text: self.$registerData.name).padding().foregroundColor(.white).background(Color.white.opacity(0.06)).cornerRadius(15)
            }.padding()
            
            
            HStack(spacing: 15) {
                TextField("Bio", text: self.$registerData.bio).padding().foregroundColor(.white).background(Color.white.opacity(0.06)).cornerRadius(15)
            }.padding()
            
            if registerData.isLoading {
                ProgressView().padding()
            }else {
                Button(action: {
                    self.registerData.register()
                }) {
                    Text("Register").foregroundColor(.white).fontWeight(.bold).padding(.vertical).frame(width: UIScreen.main.bounds.width - 100).background(Color("blue")).clipShape(Capsule())
                }
                .disabled(registerData.image_Data.count == 0 || registerData.name == "" || registerData.bio == "" ? true : false)
                .opacity(registerData.image_Data.count == 0 || registerData.name == "" || registerData.bio == "" ? 0.5 : 1.0)
            }
            Spacer(minLength: 0)
        }.background(Color("bg").ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $registerData.picker) {
            ImagePicker(picker: $registerData.picker, img_Data: $registerData.image_Data)
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}

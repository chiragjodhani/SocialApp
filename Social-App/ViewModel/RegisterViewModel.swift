//
//  RegisterViewModel.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI
import Firebase

class RegisterViewModel: ObservableObject {
    @Published var name = ""
    @Published var bio = ""
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    @Published var isLoading = false
    @AppStorage("current_status") var status = false
    let ref = Firestore.firestore()
    func register(){
        isLoading = true
        let uid = Auth.auth().currentUser!.uid
        UploadImage(imageData: image_Data, path: "profile_photo") { (url) in
            self.ref.collection("Users").document(uid).setData([
                "uid" : uid,
                "imageurl" : url,
                "username" : self.name,
                "bio" : self.bio,
                "dateCreated" : Date()
                
            ]){(error) in
                if error != nil {
                    self.isLoading = false
                    return
                }
                self.isLoading = false
                self.status = true
            }
        }
    }
}

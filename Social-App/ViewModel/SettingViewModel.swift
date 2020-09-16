//
//  SettingViewModel.swift
//  Social-App
//
//  Created by Chirag's on 16/09/20.
//

import SwiftUI
import Firebase
class SettingViewModel: ObservableObject {
    @Published var userInfo = UserModel(username: "", pic: "", bio: "")
    @AppStorage("current_status") var status = false
    
    @Published var image_Data = Data(count: 0)
    @Published var picker = false
    @Published var isLoading = false
    let ref = Firestore.firestore()
    let uid = Auth.auth().currentUser!.uid
    init() {
        fetchUser()
    }
    
    func fetchUser(){
        ref.collection("Users").document(uid).getDocument { (doc, error) in
            guard let user = doc else { return}
            let username = user.data()?["username"] as! String
            let pic = user.data()?["imageurl"] as! String
            let bio = user.data()?["bio"] as! String
            DispatchQueue.main.async {
                self.userInfo = UserModel(username: username, pic: pic, bio: bio)
            }
        }
    }
    
    func logOut(){
        try! Auth.auth().signOut()
        status = false
    }
    
    func updateImage(){
        isLoading = true
        UploadImage(imageData: image_Data, path: "profile_Photos") { (url) in
            self.ref.collection("Users").document(self.uid).updateData([
                "imageurl": url,
            ]){ (error) in
                if error != nil { return}
                self.isLoading = false
                self.fetchUser()
            }
        }
    }
    
    func updateFields(field: String) {
        alertView(msg: "Update \(field)") { (txt) in
            if txt != "" {
                self.updateBio(id: field == "Name" ? "username" : "bio", value: txt)
            }
        }
    }
    
    func updateBio(id: String, value: String) {
        ref.collection("Users").document(uid).updateData([
            id: value,
        ]){(error) in
            if error != nil { return}
            self.fetchUser()
        }
    }
}

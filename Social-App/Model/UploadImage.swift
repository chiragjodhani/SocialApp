//
//  UploadImage.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI
import Firebase

func UploadImage(imageData: Data, path: String, completion: @escaping (String) -> ()) {
    let storage = Storage.storage().reference()
    let uid = Auth.auth().currentUser!.uid
    storage.child(path).child(uid).putData(imageData, metadata: nil) { (_, error) in
        if error != nil {
            completion("")
            return
        }
        storage.child(path).child(uid).downloadURL { (url, error) in
            if error != nil {
                completion("")
                return
            }
            completion("\(url!)")
        }
    }
}

//
//  LoginViewModel.swift
//  Social-App
//
//  Created by Chirag's on 15/09/20.
//

import SwiftUI
import Firebase
import Combine
class LoginViewModel: ObservableObject {
    @Published var code = ""
    @Published var number = ""
    @Published var errorMsg = ""
    @Published var error = false
    @Published var registerUser = false
    
    @AppStorage("current_status") var status = false
    
    @Published var isLoading = false
    func verifyUser() {
        isLoading = true
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        let phoneNumber = "+" + code + number
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (ID, error) in
            if error != nil {
                self.errorMsg = error?.localizedDescription ?? ""
                self.error.toggle()
                self.isLoading = false
                return
            }
            alertView(msg: "Enter Verification Code") { (Code) in
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: ID!, verificationCode: Code)
                Auth.auth().signIn(with: credential) { (res, error) in
                    if error != nil {
                        self.errorMsg = error?.localizedDescription ?? ""
                        self.error.toggle()
                        self.isLoading = false
                        return
                    }
                    self.checkUser()
                }
            }
        }
    }
    func checkUser(){
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser!.uid
        ref.collection("Users").whereField("uid", isEqualTo: uid).getDocuments { (snap, error) in
            if error != nil {
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            if (snap!.documents.isEmpty){
                self.registerUser.toggle()
                self.isLoading = false
                return
            }
            self.status = true
        }
    }
}

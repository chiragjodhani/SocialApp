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
            self.alertView { (Code) in
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
    
    func alertView(completion: @escaping (String) -> ()) {
        let alert = UIAlertController(title: "Verification", message: "Enter Code", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "123456"
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
        alert.addAction(UIAlertAction(title: "Verify", style: .default, handler: { (_) in
            let code = alert.textFields![0].text ?? ""
            if code == "" {
                UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
            }else {
                completion(code)
            }
            
        }))
        UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
    }
    
    func checkUser(){
        let ref = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        ref.collection("Users").whereField("uid", isEqualTo: uid!).getDocuments { (snap, error) in
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

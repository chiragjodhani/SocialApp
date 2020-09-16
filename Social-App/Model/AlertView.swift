//
//  AlertView.swift
//  Social-App
//
//  Created by Chirag's on 16/09/20.
//

import SwiftUI

func alertView(msg: String, completion: @escaping (String) -> ()) {
    let alert = UIAlertController(title: "Message", message: msg, preferredStyle: .alert)
    alert.addTextField { (textField) in
        textField.placeholder = msg.contains("Verification") ? "123456" : ""
    }
    alert.addAction(UIAlertAction(title: "Cancel", style: .destructive))
    alert.addAction(UIAlertAction(title: msg.contains("Verification") ? "Verify" : "Update", style: .default, handler: { (_) in
        let code = alert.textFields![0].text ?? ""
        if code == "" {
            UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
        }else {
            completion(code)
        }
        
    }))
    UIApplication.shared.windows.first?.rootViewController?.present(alert, animated: true)
}

//
//  FirebaseManager.swift
//  Pulse
//
//  Created by Andi on 19.02.24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

struct FirebaseManager {
    
    static var shared = FirebaseManager()
    
    let auth = Auth.auth()
    let database = Firestore.firestore()

    var userID : String? {
        auth.currentUser?.uid
    }
}

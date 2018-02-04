//
//  User.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-12-23.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import Foundation
import FirebaseAuth

class User {
    static var isLoggedIn: Bool? {
        get {
            return Auth.auth().currentUser != nil
        }
    }
    static var name: String? {
        get {
            return Auth.auth().currentUser?.displayName
        }
    }
    
    static var id: String? {
        get {
            return Auth.auth().currentUser?.uid
        }
    }
    
}

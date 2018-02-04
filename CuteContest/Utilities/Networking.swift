//
//  Networking.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2018-01-16.
//  Copyright © 2018 Johann Wentzel. All rights reserved.
//

import Foundation
import Firebase

class Networking {
    
    static var sharedInstance: Networking?
    
    static var databaseReference: DatabaseReference?
    static var storageReference: StorageReference?
    
    func sendPost(_ image: UIImage, name: String){
        
        if User.id == nil {
            print("Error: could not find a userid")
            return
        }
        
        let imageData = UIImageJPEGRepresentation(image.resized(withPercentage: 0.2)!, 1.0)
        let postId = UUID().uuidString
        
        let storageRef = Networking.storageReference?.child("images/\(Auth.auth().currentUser!.uid)/\(name).jpeg")
        let postsRef = Networking.databaseReference?.child("posts").child(postId)
        let scoreRef = Networking.databaseReference?.child("score").child(postId)
        
        let _ = storageRef?.putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("ERROR: Image upload failed")
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()?.absoluteString
            postsRef?.setValue([
                "photoURL": downloadURL ?? "",
                "userId": User.id!,
                "timestamp": ServerValue.timestamp(),
                "name": name
                ])
            scoreRef?.setValue([
                "thumbsUp": 0,
                "thumbsDown": 0,
                "total": 0
                ])

        }
    }
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            guard let appDel = UIApplication.shared.delegate as? AppDelegate else { return }
            let loginVC = UIStoryboard(name: "Login", bundle: nil).instantiateInitialViewController()
            
            UIView.transition(with: appDel.window!, duration: 0.3, options: .transitionCrossDissolve, animations: {
                appDel.window?.rootViewController = loginVC
            }, completion: { completed in
                // maybe do something here
            })
            
            
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    func getUserDataWithId(_ uid: String){
        let ref = Networking.databaseReference?.child("users/\(uid)")
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            print("Got user with name: \(name)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setupUserIfNew(){
        let ref = Networking.databaseReference?.child("users").child(Auth.auth().currentUser!.uid)
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                ref?.updateChildValues(["name": User.name ?? "", "posts": 0, "totalScore": 0])
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
}

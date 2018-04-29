//
//  Networking.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2018-01-16.
//  Copyright © 2018 Johann Wentzel. All rights reserved.
//

import Foundation
import Firebase

protocol NetworkingDelegate {
    func didLoadNewPosts()
}

class Networking {
    
    static var sharedInstance: Networking?
    
    var databaseReference: DatabaseReference?
    var storageReference: StorageReference?
    
    var delegate: NetworkingDelegate?
    
    init() {
        databaseReference = Database.database().reference()
        storageReference = Storage.storage().reference()
    }
    
    func incrementScore(postID: String, isPositive: Bool){
        
    }
    
    func getPosts(){
        let ref = databaseReference?.child("posts")
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.value is NSNull { return }
            let result = snapshot.value as! NSDictionary
            for userId in result.allKeys {
                let info = result[userId] as? NSDictionary
                
                let name = info!["name"] as? String ?? ""
                let photoURL = info!["photoURL"] as? String ?? ""
                let timeStamp = info!["timestamp"] as? String ?? ""
                let ownerName = info!["ownerName"] as? String ?? ""
                let ownerId = info!["userId"] as? String ?? ""

                let newCardData = CardData(photoURL: photoURL, petName: name, ownerName: ownerName, ownerId: ownerId, timestamp: timeStamp)

                Model.shared?.data.append(newCardData)
            }
            
            self.delegate?.didLoadNewPosts()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func sendPost(_ image: UIImage, name: String){
        
        if User.id == nil {
            print("Error: could not find a userid")
            return
        }
        
        let imageData = UIImageJPEGRepresentation(image.resized(withPercentage: 0.2)!, 1.0)
        let postId = UUID().uuidString
        
        let filename = "\(name)-\(Date().timeIntervalSince1970).jpeg"
        
        let storageRef = storageReference?.child("images/\(User.id!)/\(filename)")
        let postsRef = databaseReference?.child("posts").child(postId)
        let scoreRef = databaseReference?.child("score").child(postId)
        
        
        
        let _ = storageRef?.putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                print("ERROR: Image upload failed")
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
//            let downloadURL = metadata.downloadURL()?.absoluteString
            postsRef?.setValue([
                "photoURL": filename ,
                "userId": User.id!,
                "timestamp": ServerValue.timestamp(),
                "name": name,
                "ownerName": User.name ?? ""
                ])
            
            print("uloading image with URL: images/\(User.id!)/\(filename)")
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
        let ref = databaseReference?.child("users/\(uid)")
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            print("Got user with name: \(name)")
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func setupUserIfNew(){
        let ref = databaseReference?.child("users").child(Auth.auth().currentUser!.uid)
        ref?.observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.exists() {
                ref?.updateChildValues(["name": User.name ?? "", "posts": 0, "totalScore": 0])
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func getPhoto(){
        
    }
    
}

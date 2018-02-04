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
    
    func uploadImage(_ image: UIImage, name: String){
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let ref = Networking.storageReference?.child("images/\(Auth.auth().currentUser!.uid)/\(name).jpeg")
        
        let _ = ref?.putData(imageData!, metadata: nil) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL
            
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
    
}

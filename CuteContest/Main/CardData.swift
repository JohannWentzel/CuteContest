//
//  CardData.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-12-22.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class CardData: NSObject {
    var image: UIImage?
    var petName: String?
    var ownerId: String?
    var ownerName: String?
    var timestamp: String?
    var photoURL: String?
    
    init(image: UIImage, name: String, owner: String) {
        self.image = image
        self.petName = name
        self.ownerName = owner
    }
    
    init(photoURL: String, petName: String, ownerName: String, ownerId: String, timestamp: String){
        self.photoURL = photoURL
        self.petName = petName
        self.ownerId = ownerId
        self.ownerName = ownerName
        self.timestamp = timestamp
    }
}

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
    var name: String?
    var owner: String?
    
    init(image: UIImage, name: String, owner: String) {
        self.image = image
        self.name = name
        self.owner = owner
    }
}

//
//  Card.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-10-08.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class Card: UIView{

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    var image : UIImage?
    var name : String?
    var owner : String?
    
    
    
    class func instanceFromNib(name: String, owner: String, image: UIImage) -> Card {
        
        let newCard = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
        
        newCard.image = image
        newCard.name = name
        newCard.owner = owner
        
        newCard.petImage.image = image
        newCard.nameLabel.text = name
        newCard.ownerLabel.text = owner
        
        newCard.layer.shadowColor = UIColor.black.cgColor
        newCard.layer.shadowOpacity = 0.1
        newCard.layer.shadowOffset = CGSize.zero
        newCard.layer.shadowRadius = 10
        
        newCard.layer.shadowPath = UIBezierPath(rect: newCard.bounds).cgPath
//        newCard.layer.shouldRasterize = true
        
        return newCard
    }
    

}

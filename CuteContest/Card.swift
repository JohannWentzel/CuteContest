//
//  Card.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-10-08.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class Card: UIView {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    
    var data : CardData?
    
    class func instanceFromNib(name: String, owner: String, image: UIImage) -> Card {
        
        let newCard = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
        newCard.data = CardData(image: image, name: name, owner: owner)
        setCardUI(newCard)
        return newCard
    }
    
    class func instanceFromNib(data: CardData) -> Card {
        let newCard = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
        newCard.data = data
        setCardUI(newCard)
        return newCard
    }
    
    private class func setCardUI(_ card: Card) {
        
        card.petImage.image = card.data?.image
        card.nameLabel.text = card.data?.name
        card.ownerLabel.text = card.data?.owner
        
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.darkGray.cgColor
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0
        card.layer.shadowOffset = CGSize.zero
        card.layer.shadowRadius = 10
        
        card.layer.shadowPath = UIBezierPath(rect: card.bounds).cgPath
    }
}

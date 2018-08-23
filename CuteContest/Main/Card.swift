//
//  Card.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-10-08.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit
import FirebaseStorageUI

class Card: UIView {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ownerLabel: UILabel!
    @IBOutlet weak var textContainer: UIView!
    @IBOutlet weak var textStackView: UIStackView!
    
    var data : CardData?
    
    class func instanceFromNib(name: String, owner: String, image: UIImage) -> Card {
        
        let newCard = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
        newCard.data = CardData(image: image, name: name, owner: owner)
        setCardUI(newCard)
        newCard.createGradientLayer()
        return newCard
    }
    
    class func instanceFromNib(data: CardData) -> Card {
        let newCard = UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Card
        newCard.data = data
        setCardUI(newCard)
        newCard.createGradientLayer()
        newCard.textContainer.bringSubview(toFront: newCard.textStackView)
        var counter = 0
        while newCard.petImage == nil {
            counter += 1
        }
        print("Downloaded image after \(counter) cycles")
        return newCard
    }
    
    private class func setCardUI(_ card: Card) {
        
        card.petImage.image = card.data?.image
        card.nameLabel.text = card.data?.petName
        card.ownerLabel.text = card.data?.ownerName
        
        card.petImage.layer.cornerRadius = 5
        card.petImage.clipsToBounds = true
        card.petImage.layer.borderWidth = 1
        card.petImage.layer.borderColor = UIColor.darkGray.cgColor
        
        if card.data?.photoURL != nil {
            print("downloading img with url: images/\(card.data?.ownerId ?? "")/\(card.data?.photoURL ?? "")")
            card.petImage.sd_setImage(with: (Networking.sharedInstance?.storageReference?.child("images/\(card.data?.ownerId ?? "")/\(card.data?.photoURL ?? "")"))!)
        }
        
        card.layer.borderWidth = 1
        card.layer.borderColor = UIColor.darkGray.cgColor
        card.layer.cornerRadius = 10
        card.layer.masksToBounds = true
        
        card.layer.shadowColor = UIColor.black.cgColor
        card.layer.shadowOpacity = 0
        card.layer.shadowOffset = CGSize.zero
        card.layer.shadowRadius = 10
        
        card.layer.shadowPath = UIBezierPath(rect: card.bounds).cgPath
    }
    
    private func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = self.textContainer.bounds
        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.withAlphaComponent(0.8).cgColor]
        
        self.textContainer.layer.addSublayer(gradientLayer)
    }
}

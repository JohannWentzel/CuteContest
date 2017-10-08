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
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Card", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    

}

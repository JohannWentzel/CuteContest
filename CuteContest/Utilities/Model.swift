//
//  Model.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2018-04-28.
//  Copyright © 2018 Johann Wentzel. All rights reserved.
//

import Foundation

class Model {
    static var shared: Model?
    
    var data: [CardData]
    
    init(){
        data = [CardData]()
    }
    
    func addDummyPets(){
        for _ in 0 ..< 5 {
            let newPet = CardData(image: #imageLiteral(resourceName: "daisy"), name: "Test Daisy", owner: "Johann")
            data.append(newPet)
        }
    }
}

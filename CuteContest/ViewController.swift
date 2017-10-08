//
//  ViewController.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-10-05.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var card: UIView!
    
    var LEFT_MARGIN : CGFloat = 0.0
    var RIGHT_MARGIN : CGFloat = 0.0
    var topCard : Card?
    var cards : [Card] = [] 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LEFT_MARGIN = 75
        RIGHT_MARGIN = view.frame.width - 75
        
        populateDummyCardStack()
//        assignTopCard()
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButton(_ sender: Any) {
        populateDummyCardStack()
    }
    
    
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
//        print("panned")
        let translation = panGestureRecognizer.translation(in: self.view)
        panGestureRecognizer.view!.center = CGPoint(x: panGestureRecognizer.view!.center.x + translation.x, y: panGestureRecognizer.view!.center.y + translation.y)
        panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        let xFromCenter = topCard!.center.x - view.center.x
        
        let panRatio = xFromCenter / view.center.x
        let scale = min(150/abs(xFromCenter),1)
        
        topCard!.transform = CGAffineTransform(rotationAngle: panRatio * 0.4).scaledBy(x: scale, y: scale)
        
        
        if xFromCenter > 0 {
            topCard!.thumbImageView.image = #imageLiteral(resourceName: "ThumbsUp")
            topCard!.thumbImageView.tintColor = UIColor.green
        }
        else {
            topCard!.thumbImageView.image = #imageLiteral(resourceName: "ThumbsDown")
            topCard!.thumbImageView.tintColor = UIColor.red
        }
        
        topCard!.thumbImageView.alpha = abs(panRatio)
        
        
        
        if sender.state == UIGestureRecognizerState.ended{
            
            
            if self.topCard!.center.x < self.LEFT_MARGIN {
                
                didSwipeLeft()
                
            }
            else if self.topCard!.center.x > self.RIGHT_MARGIN {
                didSwipeRight()
                
                

            }
            else {
                
                resetCardPosition()
            }
        }
    }
    
    func populateDummyCardStack(){
        
        for i in 0...4 {
            
            let newCard = Card.instanceFromNib(name:"Card " + String(i), owner:"Subtitle " + String(i), image: #imageLiteral(resourceName: "ThumbsUp"))
            newCard.center = view.center
            cards.append(newCard)
            
        }
        
        assignTopCard()
        
        
        
    }
    
    func assignTopCard(){
        
        if cards.count > 0 {
            topCard = cards[0]
            topCard!.addGestureRecognizer(panGestureRecognizer)
            self.view.addSubview(topCard!)
        }
        else{
            
        }
        
        
        
    }
    
    
    func didSwipeLeft(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.topCard!.center = CGPoint(x: self.topCard!.center.x - 200, y: self.topCard!.center.y + 75)
            self.topCard!.alpha = 0
        })
        cards.remove(at: 0)
        assignTopCard()
        
    }
    
    func didSwipeRight(){
        UIView.animate(withDuration: 0.3, animations: {
            self.topCard!.center = CGPoint(x: self.topCard!.center.x + 200, y: self.topCard!.center.y + 75)
            self.topCard!.alpha = 0
        })
        cards.remove(at: 0)
        assignTopCard()
    }
    
    
    
    func resetCardPosition(){
        UIView.animate(withDuration: 0.2, animations: {
            self.topCard!.alpha = 1
            self.topCard!.center = self.view.center
            self.topCard!.thumbImageView.alpha = 0
            self.topCard!.transform = .identity
        })
    }
    
    
    

}


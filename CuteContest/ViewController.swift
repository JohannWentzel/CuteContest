//
//  ViewController.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2017-10-05.
//  Copyright © 2017 Johann Wentzel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet var panGestureRecognizer: UIPanGestureRecognizer!
    @IBOutlet weak var card: UIView!
    
    var LEFT_MARGIN : CGFloat = 0.0
    var RIGHT_MARGIN : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        LEFT_MARGIN = 75
        RIGHT_MARGIN = view.frame.width - 75
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func resetButton(_ sender: Any) {
        resetCard()
    }
    
    @IBAction func didPan(_ sender: UIPanGestureRecognizer) {
        print("panned")
        let translation = panGestureRecognizer.translation(in: self.view)
        panGestureRecognizer.view!.center = CGPoint(x: panGestureRecognizer.view!.center.x + translation.x, y: panGestureRecognizer.view!.center.y + translation.y)
        panGestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        let xFromCenter = card.center.x - view.center.x
        
        let panRatio = xFromCenter / view.center.x
        let scale = min(150/abs(xFromCenter),1)
        
        card.transform = CGAffineTransform(rotationAngle: panRatio * 0.4).scaledBy(x: scale, y: scale)
        
        
        if xFromCenter > 0 {
            thumbImageView.image = #imageLiteral(resourceName: "ThumbsUp")
            thumbImageView.tintColor = UIColor.green
        }
        else {
            thumbImageView.image = #imageLiteral(resourceName: "ThumbsDown")
            thumbImageView.tintColor = UIColor.red
        }
        
        thumbImageView.alpha = abs(panRatio)
        
        
        
        if sender.state == UIGestureRecognizerState.ended{
            
            
            if self.card.center.x < self.LEFT_MARGIN {
                UIView.animate(withDuration: 0.3, animations: {
                    self.card.center = CGPoint(x: self.card.center.x - 200, y: self.card.center.y + 75)
                    self.card.alpha = 0
                })
            }
            else if self.card.center.x > self.RIGHT_MARGIN {
                UIView.animate(withDuration: 0.3, animations: {
                    self.card.center = CGPoint(x: self.card.center.x + 200, y: self.card.center.y + 75)
                    self.card.alpha = 0
                })
                

            }
            else {
                
                resetCard()
            }
        }
    }
    
    func resetCard(){
        UIView.animate(withDuration: 0.2, animations: {
            self.card.alpha = 1
            self.card.center = self.view.center
            self.thumbImageView.alpha = 0
            self.card.transform = .identity
        })
    }
    
    
    

}


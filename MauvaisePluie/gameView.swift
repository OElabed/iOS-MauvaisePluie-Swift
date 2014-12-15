//
//  gameView.swift
//  MauvaisePluie
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit

class gameView: UIView {
    
    let scoreButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let jouerButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let prefButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let leftButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let rightButton = UIButton.buttonWithType(UIButtonType.System) as UIButton
    let bonhomme = UIImageView(image: UIImage(named: "player"))
    var moveTimer : NSTimer?
    var score = UILabel()
    let aarg = UILabel()
    let niv = UILabel()
    var move = 0
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.frame = CGRectMake(0,0, frame.width, frame.height)
        
        self.backgroundColor = UIColor(white: 1, alpha: 0)
        
        scoreButton.setTitle("Scores", forState: .Normal)
               jouerButton.setTitle("Jouer", forState: .Normal)
        

        prefButton.setTitle("Préférences", forState: .Normal)
        
        leftButton.setTitle("<<<", forState: .Normal)
      
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
            leftButton.tintColor = .whiteColor()
            rightButton.tintColor = .whiteColor()
        }
        
        leftButton.titleLabel?.textAlignment = .Center
        rightButton.titleLabel?.textAlignment = .Center

        leftButton.hidden = true
        rightButton.setTitle(">>>", forState: .Normal)
        rightButton.hidden = true
        let dico : NSDictionary = ["scoreButton":scoreButton,"jouerButton":jouerButton,"prefButton":prefButton,"leftButton":leftButton,"rightButton":rightButton,"scorelab":score,"niv":niv]
  
        
        scoreButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        prefButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        jouerButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        leftButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        rightButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        score.setTranslatesAutoresizingMaskIntoConstraints(false)
        aarg.setTranslatesAutoresizingMaskIntoConstraints(false)
        niv.setTranslatesAutoresizingMaskIntoConstraints(false)

        bonhomme.hidden = true
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        bonhomme.frame = CGRectMake(frame.width / 2 - 20 , frame.height - 20 - 40, 100, 100)
        }
        else {
            bonhomme.frame = CGRectMake(frame.width / 2 - 20 , frame.height - 20 - 40, 100  , 100)

        }

        niv.textColor = .whiteColor()
        
        
        score.textColor = .whiteColor()
        score.textAlignment = .Right
        
        aarg.textColor = .whiteColor()
        aarg.font = UIFont.boldSystemFontOfSize(30)
        aarg.hidden = true
        

        score.hidden = true
        niv.hidden = true

        
        self.addSubview(scoreButton)
        self.addSubview(prefButton)
        self.addSubview(jouerButton)
        self.addSubview(bonhomme)

        self.addSubview(score)
        self.addSubview(niv)

        self.addSubview(aarg)
        self.addSubview(leftButton)
        self.addSubview(rightButton)
        

        self.addConstraint(NSLayoutConstraint(item: aarg, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: aarg, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: jouerButton, attribute: NSLayoutAttribute.CenterX, relatedBy:
            NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        self.addConstraint(NSLayoutConstraint(item: leftButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -15))
        
        self.addConstraint(NSLayoutConstraint(item: rightButton, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: -15))
        
        self.addConstraint(NSLayoutConstraint(item: leftButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 50))
        
        self.addConstraint(NSLayoutConstraint(item: rightButton, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 50))
        
        self.addConstraint(NSLayoutConstraint(item: leftButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 100))
        
        self.addConstraint(NSLayoutConstraint(item: rightButton, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 100))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[niv(200)]->=10-[scorelab(200)]-10-|", options: nil, metrics: nil, views: dico))
       self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[scorelab(21)]->=10-|", options: nil, metrics: nil, views: dico))
             self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[niv(21)]->=10-|", options: nil, metrics: nil, views: dico))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[scoreButton]->=10-[jouerButton]->=10-[prefButton]-10-|", options: nil, metrics: nil, views: dico))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftButton]->=10-[rightButton]|", options: nil, metrics: nil, views: dico))
        
        

    }
    
    func move(timer :NSTimer) {
        
        if (move<0 && bonhomme.center.x > (bonhomme.frame.width / 2)){
           bonhomme.center.x -= 1
        }
        else if (move>0 && bonhomme.center.x < (self.frame.width - bonhomme.frame.width / 2)){
            bonhomme.center.x += 1
        }
        
        
    }
    
    func startMove(){
        self.moveTimer = NSTimer.scheduledTimerWithTimeInterval(0.005, target: self, selector: "move:", userInfo: nil, repeats: true)
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    
}
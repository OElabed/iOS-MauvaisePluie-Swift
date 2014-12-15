//
//  scoreView.swift
//  MauvaisePluie
//
//  Created by m2sar on 29/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit

class scoreView: UIView,UITextFieldDelegate {
    
    let names = UITextView()
    let scoresText = UITextView()
    private let meilleurLabel = UILabel()
    private let votreLabel = UILabel()
    private let votreScore = UILabel()
    private let saisir = UILabel()
    let nom = UITextField()
    let notif = NSNotificationCenter.defaultCenter()
    private let subview = UIView()
    let done = UIButton.buttonWithType(.System) as UIButton

    var scores = score()
    var scoreIndex = -1
    
  
    override init(frame: CGRect) {

        super.init(frame: frame)
        
       
        done.addTarget(self, action: "doneAction:", forControlEvents: UIControlEvents.TouchUpInside)
        done.tintColor = .whiteColor()
        self.backgroundColor = UIColor(white:0, alpha: 0.0)
        self.hidden = true
        
        meilleurLabel.font = UIFont.boldSystemFontOfSize(15)
        meilleurLabel.textAlignment = .Center
        meilleurLabel.text = "Meilleurs scores"
        meilleurLabel.textColor = .whiteColor()
        
        saisir.font = UIFont.boldSystemFontOfSize(15)
        saisir.textAlignment = .Center
        saisir.text = "Saisir votre nom"
        saisir.textColor = .whiteColor()
        saisir.hidden = true
        
        votreLabel.font = UIFont.boldSystemFontOfSize(15)
        votreLabel.textAlignment = .Center
        votreLabel.text = "Votre Score"
        votreLabel.textColor = .whiteColor()

        names.textAlignment = .Right
        names.font = UIFont.systemFontOfSize(14)
        scoresText.font = UIFont.systemFontOfSize(14)
        names.editable = false
        scoresText.editable = false
        
        names.backgroundColor = UIColor(white: 1, alpha: 0)
        scoresText.backgroundColor = UIColor(white: 1, alpha: 0)
        names.textColor = UIColor.whiteColor()
        scoresText.textColor = UIColor.whiteColor()
        
        names.selectable = false
        scoresText.selectable = false
        
        votreScore.text = "0"
        votreScore.textAlignment = .Center
        votreScore.textColor = .whiteColor()
        
        nom.borderStyle = UITextBorderStyle.RoundedRect
        nom.backgroundColor = UIColor(white: 1, alpha: 0.7)
        
        nom.delegate = self
        
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        notif.addObserver(self, selector: "hideShow:", name: UIKeyboardWillShowNotification, object: nil)
        notif.addObserver(self, selector: "hideShow:", name: UIKeyboardWillHideNotification, object: nil)

        }
        else{
            
            nom.keyboardType = UIKeyboardType.ASCIICapable
        }
        
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Dark))
        visualEffect.frame = frame

        done.setTitle("Done", forState: .Normal)
        
        
        self.addSubview(visualEffect)
        self.addSubview(done)
        subview.addSubview(saisir)
        subview.addSubview(names)
        subview.addSubview(scoresText)
        subview.addSubview(meilleurLabel)
        subview.addSubview(votreLabel)
        subview.addSubview(votreScore)
        self.addSubview(subview)
        self.addSubview(saisir)
        self.addSubview(nom)
      
        
        prepareLayout(frame)
        

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func doneAction(sender: UIButton){
        
        if (scoreIndex >= 0 && scoreIndex<6){
           
            scores.setnom(scoreIndex,val: (nom.text != "" ? nom.text : "???"))
            updateScores()


        }
        
        nom.resignFirstResponder()
        self.hidden = true
    }
    
    
    func hideShow(notification:NSNotification){
        
      dessine(!saisir.hidden)
    
    }

    func prepareLayout(frame:CGRect)
    {
        var y = CGFloat(0.0)
        
        done.frame = CGRectMake(frame.width - 80 - 20, 0 , 100 , 50 )
        saisir.frame = CGRectMake(0, done.frame.height ,frame.width, 42)
        subview.frame = CGRectMake(0, done.frame.height  ,frame.width, 200)
        meilleurLabel.frame = CGRectMake(0, 0, frame.width, 21)
        y += 21.0
        
        names.frame = CGRectMake(0, y, frame.width / 2 - 10, 120)
        scoresText.frame = CGRectMake(frame.width / 2 + 10, y , frame.width / 2 - 10, 120)

        y += 120.0
        votreLabel.frame = CGRectMake(0, y, frame.width , 21)
        y += 21.0
        votreScore.frame = CGRectMake(0, y, frame.width , 21)
        
        nom.frame = CGRectMake(frame.width / 2 - 100, subview.frame.origin.y + subview.frame.height+5, 200, 30)
        dessine(-1)
    }
    
    
  func dessine(scoreValue:Int){
    
    if (scoreValue == -1) {
        
        votreScore.text = String(0)
        nom.hidden = true
        
    }
    else {
        votreLabel.hidden = false
        votreScore.hidden = false
        
        votreScore.text = String(scoreValue)
        
        
        //afficher saisir nom
        
        for (index,s) in enumerate(scores.list) {
            
            if (scoreValue > s.1) {
                
                
                scoreIndex = index
                nom.hidden = false
                
                var i = scores.list.count - 2
                
                while (i >= index){
                    
                    scores.list[i+1] = scores.list[i]
                    i--
                }
                scores.setnom(index,val: "???")
                scores.setscore(index,val: scoreValue)
                updateScores()
                dessine(true)
                break;
            }
            
        }
        
        
    }
    }
    
    func dessine(saisie:Bool) {
        
       if (saisie){
        
            saisir.hidden = true
            subview.hidden = false
            nom.placeholder = "Saisir votre nom"
            nom.frame = CGRectMake(frame.width / 2 - 100, subview.frame.origin.y + subview.frame.height+5, 200, 30)

     
        }
            
        else {
        
            saisir.hidden = false
            subview.hidden = true
            nom.placeholder = ""
            nom.frame = CGRectMake(frame.width / 2 - 100, saisir.frame.origin.y + saisir.frame.height+5, 200, 30)

        }
    }
    
    func updateScores() {
        names.text = ""
        scoresText.text = ""
        
        for s in scores.list {
            names.text = names.text.stringByAppendingString("\(s.0)\n")
            scoresText.text = scoresText.text.stringByAppendingString(NSString(format: "%d\n", s.1))

        }
       
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        if (string == "\n") {
            textField.resignFirstResponder()
            return false
        }
        else  {
            return true
        }
    }
    
}
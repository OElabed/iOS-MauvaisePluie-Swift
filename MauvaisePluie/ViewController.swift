//
//  ViewController.swift
//  MauvaisePluie
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var timer: NSTimer?
    private var timerCollision: NSTimer?
    private var astroides:[astro] = []
    
    var prefV : prefView!
    var scoreV : scoreView!
    var gameV : gameView!

    var currentScore = 0
    var currentAstro = 0
    var maxAstro = 0
    var cpt = 0
    var proba = 0
    var deplacement = 0
    var delay = 3
    var moving = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Do any additional setup after loading the view, typically from a nib.
        
        let w = UIScreen.mainScreen().bounds.width
        let h = UIScreen.mainScreen().bounds.height
        
        let frame = (w > h) ? CGRect(x: 0, y: 0, width: w, height: h):CGRect(x: 0, y: 0, width: h, height: w)
        self.view = UIView(frame: frame )
        
        self.view.backgroundColor = UIColor.blackColor()
        
        let background = UIImageView(image: UIImage(named: "fond"))
        
        prefV = prefView(frame:  frame)
        scoreV = scoreView(frame:  frame)
        gameV = gameView(frame:  frame)
        
        let scale = Float(frame.width / background.frame.width)
        let newWidth = CGFloat(scale * Float(background.frame.width))
        let newHeight = CGFloat(scale * Float(background.frame.height))

        background.contentMode = UIViewContentMode.ScaleAspectFill
        background.frame = CGRectMake(0, 0, newWidth, newHeight)

     
    //    background.frame.origin.y = (UIScreen.mainScreen().bounds.size.height / 2) - 15
        
        let effetH = UIInterpolatingMotionEffect(keyPath: "center.x", type: .TiltAlongHorizontalAxis)
        effetH.minimumRelativeValue = -60.0
        effetH.maximumRelativeValue = 60.0
        background.addMotionEffect(effetH)
        
        self.view.addSubview(background)
  
        self.view.addSubview(gameV)
        self.view.addSubview(prefV)
        self.view.addSubview(scoreV)
        
  
        gameV.prefButton.addTarget(self, action: "preferences:", forControlEvents: UIControlEvents.TouchUpInside)
        gameV.jouerButton.addTarget(self, action: "jouer:", forControlEvents: .TouchUpInside)
        gameV.scoreButton.addTarget(self, action: "scores:", forControlEvents: .TouchUpInside)
        
        gameV.leftButton.addTarget(self, action: "left:", forControlEvents: UIControlEvents.TouchDown)
        gameV.rightButton.addTarget(self, action: "right:", forControlEvents: UIControlEvents.TouchDown)
        gameV.leftButton.addTarget(self, action: "up:", forControlEvents: UIControlEvents.TouchUpInside | UIControlEvents.TouchUpOutside)
        gameV.rightButton.addTarget(self, action: "up:", forControlEvents:  UIControlEvents.TouchUpInside | UIControlEvents.TouchUpOutside)
        scoreV.updateScores()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    func preferences(sender: UIButton) {
        
        
        prefV.hidden = false
        
    }
    
    
    func scores(sender: UIButton) {
        
        scoreV.dessine(-1)
        scoreV.hidden = false
        
    }
    
    func left(sender: UIButton) {
        
      
            gameV.move = -deplacement
            
    }
    
    func right(sender: UIButton) {
        
        gameV.move = deplacement
        
    }
    func up(sender: UIButton) {
        
        gameV.move = 0
        
    }
    
 
    func jouer(sender: UIButton) {
       
        
        astroides.removeAll(keepCapacity: false)
        gameV.bonhomme.frame = CGRectMake(gameV.frame.width / 2 - 20 , gameV.frame.height - 20 - 40, 40, 40)
        
        currentScore = 0
        scoreV.nom.text = ""
        gameV.prefButton.hidden = true
        gameV.jouerButton.hidden = true
        gameV.scoreButton.hidden = true
        
        gameV.leftButton.hidden = false
        gameV.rightButton.hidden = false
        gameV.bonhomme.hidden = false
        
        gameV.score.text = NSString(format: "Score: %d", 0)
        gameV.niv.text = NSString(format: "Niveau: %d", prefV.niveau)
        
        gameV.score.hidden = false
        gameV.niv.hidden = false
        gameV.move = 0
        gameV.startMove()
        
        gameV.hidden = false
        
        if (UIDevice.currentDevice().userInterfaceIdiom == .Phone) {
        maxAstro = 20 + 10 * prefV.niveau
            proba = 20
            deplacement = 1
        }
        else {
        maxAstro = 50 + 10 * prefV.niveau
            proba = 30
            deplacement = 5  
        }
        
        
        currentAstro = 0
        delay = 3
        gameV.aarg.hidden = false
        gameV.aarg.text = NSString(format: "%d", delay)

        self.timer = NSTimer.scheduledTimerWithTimeInterval(0.8 , target: self, selector: "startGame:", userInfo: nil, repeats: true)
    }
    
    func collision(timer :NSTimer) {
        
        for s in astroides {
            for s1 in astroides {
                
            
            if  CGFloat(abs(s.image.center.y - s1.image.center.y) - 10.0) <=  s1.image.frame.height/2+s.image.frame.height/2 && CGFloat(abs(s.image.center.x - s1.image.center.x) - 10.0) <=  s1.image.frame.width/2+s.image.frame.height/2 {
                
                
                if (s.hspeed * s1.hspeed < 0) {
                    
                if ((s.image.center.x > s1.image.center.x && s.hspeed < 0 && s1.hspeed > 0) || (s.image.center.x < s1.image.center.x && s.hspeed > 0 && s1.hspeed < 0) ) {
                    s.hspeed = s.hspeed * -1
                    s1.hspeed = s1.hspeed * -1
                    break
                }
                }
                
                else  if (s.hspeed * s1.hspeed >= 0)  {
                    s.vspeed = max(s.vspeed,s1.vspeed)
                    s1.vspeed =  max(s.hspeed,s1.vspeed)
                    break
                }
            }
            
        }
    }
    }
    func pluie(timer :NSTimer) {
        
        cpt++
        
        let p =  Int(arc4random_uniform(UInt32(101)) + cpt)
     /*
        if (cpt>100) {
            cpt = 0}
        */
        
        if ((p < proba || cpt == 30) &&  currentAstro < maxAstro ) {
          
        let i = Int(arc4random_uniform(UInt32(4))) + 1
          let vspeed = 4 +  Int(arc4random_uniform(UInt32(2 * prefV.niveau + 1 )))
          let x = Int(arc4random_uniform(UInt32(self.view.frame.width + 1))) + 1
          let hspeed = Int(arc4random_uniform(UInt32(41))) - 20
          let angle = Int(arc4random_uniform(UInt32(2)))

            let s = astro(name: String(NSString(format: (UIDevice.currentDevice().userInterfaceIdiom == .Phone) ? "astro-p%d":"astro-g%d", i)), vSpeed: CGFloat(vspeed), hSpeed: CGFloat(Double(hspeed) / 10) , position: CGPoint(x: x , y: -80.0), Angle: ((angle == 0) ? -1.0 : 1.0) / 100 )

            gameV.addSubview(s.image)
            self.astroides.append(s)
         cpt = 0
            currentAstro++
        }
        
        if (currentAstro == maxAstro) {
            cpt = 0
        }
        
        var idx = self.astroides.count - 1
        
        while (idx >= 0) {
            if (astroides[idx].image.center.y >= gameV.frame.height && astroides[idx].image.center.x >= 0 && astroides[idx].image.center.x <= gameV.frame.width) {
                astroides[idx].image.removeFromSuperview()
                astroides.removeAtIndex(idx)
                currentAstro--
                currentScore++
                gameV.score.text = NSString(format: "Score: %d", currentScore)

            }
            else if (astroides[idx].image.center.x < 0 || astroides[idx].image.center.x > gameV.frame.width) {
                astroides[idx].image.removeFromSuperview()
                astroides.removeAtIndex(idx)
                currentAstro--
            }
            else {
                
                
                
                astroides[idx].image.center.y = astroides[idx].image.center.y + astroides[idx].vspeed
                astroides[idx].image.center.x = astroides[idx].image.center.x + astroides[idx].hspeed
                astroides[idx].angle = astroides[idx].angle + astroides[idx].vspeed / 100
                
                astroides[idx].image.transform = CGAffineTransformMakeRotation(astroides[idx].angle)
               //colision
                if ((abs(astroides[idx].image.center.x - gameV.bonhomme.center.x) <   gameV.bonhomme.frame.width - 10) && (abs(astroides[idx].image.center.y - gameV.bonhomme.center.y) <   gameV.bonhomme.frame.height - 10 )  ) {
                self.timer?.invalidate()
                //self.timerCollision?.invalidate()

                self.timer = nil
                gameV.moveTimer?.invalidate()

                aarg()
                    
                self.timer = NSTimer.scheduledTimerWithTimeInterval(1 , target: self, selector: "fin:", userInfo: nil, repeats: false)
                
                }
            }
            idx--
        }
        
        
        
    }
   
    func aarg(){
        
        for s in astroides {
            s.image.removeFromSuperview()
        }
        gameV.aarg.text = "AAAAAAAARG..."
        gameV.score.hidden = true
        gameV.niv.hidden = true

        gameV.aarg.hidden = false
        gameV.leftButton.hidden = true
        gameV.rightButton.hidden = true
        
        
        
    }
    
    func fin(timer :NSTimer){
        
        gameV.aarg.hidden = true
        gameV.prefButton.hidden = false
        gameV.jouerButton.hidden = false
        gameV.scoreButton.hidden = false
        
        scoreV.dessine(currentScore)
        
        scoreV.hidden = false
        self.timer?.invalidate()
    }
    func startGame(timer :NSTimer){
        if delay > 1 {
            delay--
        gameV.aarg.text = NSString(format: "%d", delay)
            
        } else {
            gameV.aarg.hidden = true

        self.timer?.invalidate()
        
        let vitesse = Double(0.045
            - Double(prefV.niveau) * 0.005)
        cpt = 0
        self.timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(vitesse) , target: self, selector: "pluie:", userInfo: nil, repeats: true)
        
    //    self.timerCollision = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(0.5) , target: self, selector: "collision:", userInfo: nil, repeats: true)

        }
        
    }
    
   
    override func supportedInterfaceOrientations() -> Int {
        return Int(UIInterfaceOrientationMask.Landscape.toRaw())
    }
  
    override func shouldAutorotate() -> Bool {
        return true
    }
   
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
 
}


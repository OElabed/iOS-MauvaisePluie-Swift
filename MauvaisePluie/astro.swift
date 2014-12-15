//
//  astro.swift
//  MauvaisePluie
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit

class astro {
    
    let image : UIImageView
    var angle : CGFloat
    var vspeed : CGFloat
    var hspeed : CGFloat
    
    init(name n:String, vSpeed vs:CGFloat, hSpeed hs:CGFloat, position:CGPoint, Angle: CGFloat) {
        
        image = UIImageView(image: UIImage(named: n))
        image.center = position
        vspeed = vs
        hspeed = hs
        angle = Angle
        
    }
    
}

class score {
    
    var list : [(String,Int)]
    
    init() {
        
        list = [
            ("???",0),
            ("???",0),
            ("???",0),
            ("???",0),
            ("???",0),
        ]
    }
    
    func setscore(idx:Int,val:Int) {
        list[idx].1 = val
    }
    func setnom(idx:Int,val:String) {
        list[idx].0 = val
    }
    
}
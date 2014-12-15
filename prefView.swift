//
//  prefView.swift
//  MauvaisePluie
//
//  Created by m2sar on 27/10/2014.
//  Copyright (c) 2014 m2sar. All rights reserved.
//

import UIKit

class prefView: UIView,UIPickerViewDataSource,UIPickerViewDelegate {

   
    
    var niveau = 1;
    
    private let data = ["Niveau 1","Niveau 2","Niveau 3","Niveau 4","Niveau 5"]

    override init(frame: CGRect) {
        let niveauPicker = UIPickerView()
        let label = UILabel()
        let done = UIButton.buttonWithType(.System) as UIButton
       
        super.init(frame: frame)
        
        done.addTarget(self, action: "doneAction:", forControlEvents: UIControlEvents.TouchUpInside)

       // self.backgroundColor = UIColor(white: 1, alpha: 0)
        self.hidden = true
        label.font = UIFont.boldSystemFontOfSize(18)
        label.textAlignment = .Center
        label.text = "Selectionner le niveau du jeu"
        
        let visualEffect = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        visualEffect.frame = frame
        visualEffect.backgroundColor = UIColor(white: 0, alpha: 0.0)
        done.setTitle("Done", forState: .Normal)
       
        self.addSubview(visualEffect)
        self.addSubview(niveauPicker)
        
        self.addSubview(label)
        self.addSubview(done)

        
        niveauPicker.sizeToFit()
        niveauPicker.delegate = self
        niveauPicker.dataSource = self
        
        niveauPicker.setTranslatesAutoresizingMaskIntoConstraints(false)
        done.setTranslatesAutoresizingMaskIntoConstraints(false)
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
         let dico = ["done":done,"label":label,"picker":niveauPicker]
        
        self.addConstraint(NSLayoutConstraint(item: niveauPicker, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
      
        self.addConstraint(NSLayoutConstraint(item: niveauPicker, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 300))
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Height, multiplier: 0, constant: 21))
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Width, multiplier: 0, constant: 300))
        
        self.addConstraint(NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0))
        
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|->=10-[done]-20-|", options: nil, metrics: nil, views: dico))
        
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[done(50)]-[label]-[picker]->=10-|", options: nil, metrics: nil, views: dico))
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        return data[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        niveau = row + 1
        
    }
    
    func doneAction(sender: UIButton){
        self.hidden = true
    }
}
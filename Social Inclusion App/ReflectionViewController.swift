//
//  EndOfInstructionsViewController.swift
//  Social Inclusion App
//
//  Created by Mary Chopin on 4/26/17.
//  Copyright © 2017 Maryville Information Systems. All rights reserved.
//

import UIKit

class ReflectionViewController: UIViewController {
    
    var reflectionActivity: Activity!

    @IBAction func negativeEmotionSelected(_ sender: Any) {
        performSegue(withIdentifier: "segueToActivityReflectionCont", sender: UIButton.self)
    }
    
    @IBAction func neutralEmotionSelected(_ sender: Any) {
        performSegue(withIdentifier: "segueToActivityReflectionCont", sender: UIButton.self)
    }
   
    @IBAction func positiveEmotionSelected(_ sender: Any) {
        performSegue(withIdentifier: "segueToActivityReflectionCont", sender: UIButton.self)
    }
    
    
    
    
}

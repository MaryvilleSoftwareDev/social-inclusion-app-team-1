//
//  ContinuedReflectionViewController.swift
//  Social Inclusion App
//
//  Created by Mary Chopin on 4/26/17.
//  Copyright © 2017 Maryville Information Systems. All rights reserved.
//

import UIKit

class ContinuedReflectionViewController: UIViewController {
    
    
    @IBOutlet weak var reflectionTextField: UITextField!
    
    @IBAction func reflectionTextFieldEdited(_ sender: Any) {
        //this should contain code that makes reflectionTextField's height increase as more text is entered into the text field (as opposed to the entire entry being entered in one big line, this should create multiple lines
    }
    
    @IBAction func submitReflectionSelected(_ sender: Any) {
        //this should contain code that replaces all of the navigation views with the rootViewController (ActivityCollectionViewController). It should also log and store the data about the activity just performed (activity code, time spent on each instruction, the reflection emoji/text, etc.)
    }
    
}

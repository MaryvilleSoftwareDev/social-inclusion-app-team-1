//
//  InstructionsViewController.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    @IBOutlet weak var instructionsNavigationController: UINavigationItem!
    
    @IBOutlet weak var instructionsTextView: UITextView!
    
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet weak var prevButton: UIBarButtonItem!
    
    var instructionActivity: Activity!
    
    var selectedInstruction: Int! = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        instructionsNavigationController.title = instructionActivity.name
        
        instructionsTextView.text = instructionActivity.instructions[selectedInstruction].details
        
        if selectedInstruction + 1 == instructionActivity.instructions.count {
            nextButton.setTitle("Finish", for: .normal)
        }
        
        if selectedInstruction == 0 {
            prevButton.title = "Activities"
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        if selectedInstruction + 1 == instructionActivity.instructions.count {
            
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EndOfInstructions") as! EndOfInstructionsViewController
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        } else {
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Instructions") as! InstructionsViewController
            
            nextViewController.selectedInstruction = selectedInstruction + 1
            nextViewController.instructionActivity = instructionActivity
           
            
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
}
    @IBAction func prevButtonSelected(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

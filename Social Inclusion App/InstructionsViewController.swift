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
    
    @IBOutlet var socialSkillTextView: UITextView!
    @IBOutlet var instructionStepTitle: UITextField!
    
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var finishButton: UIButton!
    
    
    @IBOutlet weak var prevButton: UIBarButtonItem!
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
    }
    var instructionActivity: Activity!
    
    var selectedInstruction: Int! = 0
    
    override func viewWillAppear(_ animated: Bool) {
        
        finishButton.isEnabled = false
        finishButton.isHidden = true
        
        instructionsNavigationController.title = instructionActivity.name
        
        instructionStepTitle.text = instructionActivity.instructions[selectedInstruction].title
        socialSkillTextView.text = instructionActivity.instructions[selectedInstruction].socialSkillText
        
        instructionsTextView.text = instructionActivity.instructions[selectedInstruction].details
        
        if selectedInstruction + 1 == instructionActivity.instructions.count {
            // nextButton.title("Finish", for: .normal)
            nextButton.isEnabled = false
            finishButton.isHidden = false
            finishButton.isEnabled = true
        }
        
        if selectedInstruction == 0 {
            prevButton.title = "Activities"
        }
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        if selectedInstruction + 1 == instructionActivity.instructions.count {
            
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Reflection") as! ReflectionViewController
            
            let selectedActivity = instructionActivity
            let reflectionViewController = nextViewController 
            
            reflectionViewController.reflectionActivity = selectedActivity
            
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

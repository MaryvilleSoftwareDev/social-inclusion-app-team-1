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
    var activityLogItem: ActivityLogItem!
    var selectedInstruction: Int! = 0
    
    override func viewWillAppear(_ animated: Bool) {
        // Build the activityLogItem
        var newTimer = InstructionTimer()
        if activityLogItem.activityCode == "" {
            activityLogItem.activityCode = instructionActivity.activityCode
            activityLogItem.participantCode = "code"
            activityLogItem.instructionTimer = [newTimer.startInstructionTimer(forInstruction: instructionActivity.instructions[selectedInstruction].instructionCode)]
        } else {
            activityLogItem.instructionTimer += [newTimer.startInstructionTimer(forInstruction: instructionActivity.instructions[selectedInstruction].instructionCode)]
        }
        
        // Set button state
        finishButton.isEnabled = false
        finishButton.isHidden = true
        
        // Set text values for the current instruction
        instructionsNavigationController.title = instructionActivity.name
        instructionStepTitle.text = instructionActivity.instructions[selectedInstruction].title
        socialSkillTextView.text = instructionActivity.instructions[selectedInstruction].socialSkillText
        instructionsTextView.text = instructionActivity.instructions[selectedInstruction].details
        
        // Change the button state if last instruction is displayed
        if selectedInstruction + 1 == instructionActivity.instructions.count {
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
            
            let reflectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Reflection") as! ReflectionViewController
            
            let selectedActivity = instructionActivity
            
            activityLogItem.instructionTimer[selectedInstruction].stopTime = Date()
            
            reflectionViewController.activityLogItem = self.activityLogItem
            
            self.navigationController?.pushViewController(reflectionViewController, animated: true)
        } else {
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Instructions") as! InstructionsViewController
            activityLogItem.instructionTimer[selectedInstruction].stopTime = Date()
            nextViewController.selectedInstruction = selectedInstruction + 1
            nextViewController.instructionActivity = instructionActivity
            nextViewController.activityLogItem = activityLogItem
           
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
}
    @IBAction func prevButtonSelected(_ sender: Any) {
        activityLogItem.instructionTimer[selectedInstruction].stopTime = Date()
        self.navigationController?.popViewController(animated: true)
    }
}

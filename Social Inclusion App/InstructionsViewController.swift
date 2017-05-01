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
    var completedActivityLog: CompletedActivityLog!
    var selectedInstruction: Int! = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // Build the activityLogItem
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        var newTimer = InstructionTimer()
        
        if completedActivityLog.allCompletedActivities[thisLogItem].activityCode == "" {
            completedActivityLog.allCompletedActivities[thisLogItem].activityCode = instructionActivity.activityCode
            
            completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer = [newTimer.startInstructionTimer(forInstruction: instructionActivity.instructions[selectedInstruction].instructionCode)]
        } else {
            completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer += [newTimer.startInstructionTimer(forInstruction: instructionActivity.instructions[selectedInstruction].instructionCode)]
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
    
    override func viewDidDisappear(_ animated: Bool) {
        // stop timer here?
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        let thisTimer = completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer.count - 1
        if selectedInstruction + 1 == instructionActivity.instructions.count {
            let reflectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Reflection") as! ReflectionViewController
            completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
            reflectionViewController.completedActivityLog = self.completedActivityLog
            self.navigationController?.pushViewController(reflectionViewController, animated: true)
        } else {
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Instructions") as! InstructionsViewController
            completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
            nextViewController.selectedInstruction = selectedInstruction + 1
            nextViewController.instructionActivity = instructionActivity
            nextViewController.completedActivityLog = completedActivityLog
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
}
    @IBAction func prevButtonSelected(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        let thisTimer = completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
        self.navigationController?.popViewController(animated: true)
    }
}

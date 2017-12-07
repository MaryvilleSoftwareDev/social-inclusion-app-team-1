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
    @IBOutlet weak var socialSkillLabel: UILabel!
    @IBOutlet var socialSkillTextView: UITextView!
    @IBOutlet var instructionStepTitle: UILabel!
    @IBOutlet var nextButton: UIBarButtonItem!
    @IBOutlet var finishButton: UIButton!
    @IBOutlet weak var prevButton: UIBarButtonItem!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    @IBAction func finishButtonPressed(_ sender: UIButton) {
        let reflectionViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Reflection") as! ReflectionViewController
       
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        
        let thisTimer = completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
        reflectionViewController.completedActivityLog = self.completedActivityLog
        reflectionViewController.participant = self.participant
        self.navigationController?.pushViewController(reflectionViewController, animated: true)
        completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].convertDatesToUnix(start: completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].startTime!, stop: completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime!)
    }
    
    var instructionActivity: Activity!
    var completedActivityLog: CompletedActivityLog!
    var selectedInstruction: Int! = 0
    var participant : Participant!
    
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
        if instructionActivity.instructions[selectedInstruction].socialSkill != nil {
            socialSkillLabel.text = String("Social skill: \(instructionActivity.instructions[selectedInstruction].socialSkill!)")
        }
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
        
        if instructionActivity.instructions[selectedInstruction].socialSkillText == nil {
            socialSkillTextView.isHidden = true
            socialSkillLabel.isHidden = true
        }
        //scrollViewHeight.constant = instructionStepTitle.frame.height + instructionsTextView.frame.height + socialSkillLabel.frame.height + socialSkillTextView.frame.height + finishButton.frame.height + 135
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
            reflectionViewController.participant = self.participant
            self.navigationController?.pushViewController(reflectionViewController, animated: true)
        } else {
            let nextViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Instructions") as! InstructionsViewController
            completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
            nextViewController.selectedInstruction = selectedInstruction + 1
            nextViewController.instructionActivity = instructionActivity
            nextViewController.completedActivityLog = completedActivityLog
            nextViewController.participant = self.participant
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
        completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].convertDatesToUnix(start: completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].startTime!, stop: completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime!)
}
    @IBAction func prevButtonSelected(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        let thisTimer = completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].instructionTimer[thisTimer].stopTime = Date()
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        func setTextViewFrame(textView: UITextView) {
            let contentSize = textView.sizeThatFits(textView.bounds.size)
            var frame = textView.frame
            frame.size.height = contentSize.height
            textView.frame = frame
            
            let aspectRatioTextViewConstraint = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: textView, attribute: .width, multiplier: textView.bounds.height/textView.bounds.width, constant: 1)
            
            textView.addConstraint(aspectRatioTextViewConstraint)
        }
        setTextViewFrame(textView: instructionsTextView)
        setTextViewFrame(textView: socialSkillTextView)
    }
}

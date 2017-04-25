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
    
    var instructionActivity: Activity!
    
    var currentInstructionIndex: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        instructionsNavigationController.title = instructionActivity.name
        
        instructionsTextView.text = instructionActivity.instructions[currentInstructionIndex].details
    }

    @IBAction func nextButtonPressed(_ sender: Any) {
        
        if currentInstructionIndex < (instructionActivity.instructions.endIndex - 2)
        {
            nextButton.setTitle("Next", for: .normal)
            currentInstructionIndex += 1
            instructionsTextView.text = instructionActivity.instructions[currentInstructionIndex].details
        } else if currentInstructionIndex == (instructionActivity.instructions.endIndex - 2){
            currentInstructionIndex += 1
            instructionsTextView.text = instructionActivity.instructions[currentInstructionIndex].details
            nextButton.setTitle("Finish", for: .normal)
        } else {
            performSegue(withIdentifier: "instructionsFinishedSegue", sender: nextButton)
        }
    
    
}
}

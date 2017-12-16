//
//  LoginView.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var rememberMeSwitch: UISwitch!
    var completedActivityLog: CompletedActivityLog!
    var participant : Participant?
    //This participant is only preset because we are currently skipping the login phase. Once the login screen is reimplemented, this participant variable should be optional and then set to whatever data corresponds to the code entered on the login page.
    
    let listOfParticipants = [Participant(name: "David", email: "dchopin1@live.maryville.edu", code: "000001"), Participant(name: "Mary", email: "mchopin@charter.net", code: "000002"), Participant(name: "George", email: "gchopin@cherwell.com", code: "000003")]
    
    var savedParticipantCode: Int?
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        codeTextField.text = nil
        codeTextField.placeholder = " code"
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if defaults.value(forKey: "savedParticipantCode") != nil {
            print(defaults.value(forKey: "savedParticipantCode"))
            codeTextField.text = String("\(defaults.value(forKey: "savedParticipantCode")!)")
            print("Remembered")
        }
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        logIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        codeTextField.placeholder = "Logging in"
        let activityCollectionViewController = segue.destination as! ActivityCollectionViewController
        activityCollectionViewController.completedActivityLog = self.completedActivityLog
        activityCollectionViewController.participant = self.participant
    }
    
    func logIn() {
        // looping only works if the first participant code is selected, need to re-think this logic
        for thisParticipant in listOfParticipants {
            if thisParticipant
                .code == codeTextField.text {
                participant = thisParticipant
                if rememberMeSwitch.isOn {
                    defaults.set(participant?.code, forKey: "savedParticipantCode")
                    defaults.synchronize()
                } else {
                    defaults.set(nil, forKey: "savedParticipantCode")
                    defaults.synchronize()
                }
                let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
                completedActivityLog.allCompletedActivities[thisLogItem].participantCode = codeTextField.text!
                codeTextField.text = nil
                performSegue(withIdentifier: "segueToActivities", sender: UIButton.self)
            }
        }
        codeTextField.text = nil
        codeTextField.placeholder = " Please try again"
    }
    
    //Allows the user to press "Return" on keyboard to call the logIn function
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        //textField code
        
        textField.resignFirstResponder()  //if desired
        logIn()
        return true
    }
    
    @IBAction func textFieldPrimaryActionTriggered(_ sender: Any) {
        textFieldShouldReturn(textField: codeTextField)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: view).x > codeTextField.frame.maxX || touch.location(in: view).x < codeTextField.frame.minX || touch.location(in: view).y > codeTextField.frame.maxY || touch.location(in: view).y < codeTextField.frame.minY {
                self.view.endEditing(true)
            }
        }
    }
}

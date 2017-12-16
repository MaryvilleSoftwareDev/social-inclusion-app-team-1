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
    var participant = Participant.init(name: "David", email: "dchopin1@live.maryville.edu", code: "000000")
    //This participant is only preset because we are currently skipping the login phase. Once the login screen is reimplemented, this participant variable should be optional and then set to whatever data corresponds to the code entered on the login page.
    
    let listOfParticipants = [Participant(name: "David", email: "dchopin1@live.maryville.edu", code: "000001"), Participant(name: " ", email: nil, code: "000002"), Participant(name: " ", email: nil, code: "000003")]
    
    var savedParticipantCode: Int?
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*print("code is: \(defaults.value(forKey: "savedParticipantCode")!)")
        if defaults.value(forKey: "savedParticipantCode")! as! Int != 000000 {
            codeTextField.text = String("\(defaults.value(forKey: "savedParticipantCode") as! NSInteger)")
            print("Remembered")
        }*/
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        codeTextField.text = nil
        codeTextField.placeholder = " code"
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //The following line of code allows us to immediately segue to the activityviewcontroller so that we do not have to log in each time we are testing the application. Removing this line of code will require the tester/user to login with an active login code.
        //performSegue(withIdentifier: "segueToActivities", sender: self)
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
                    defaults.set(participant.code, forKey: "savedParticipantCode")
                    defaults.synchronize()
                }
                let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
                completedActivityLog.allCompletedActivities[thisLogItem].participantCode = codeTextField.text!
                codeTextField.text = nil
                performSegue(withIdentifier: "segueToActivities", sender: UIButton.self)
            } else {
                codeTextField.text = nil
                codeTextField.placeholder = " Please try again"
            }
        }
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

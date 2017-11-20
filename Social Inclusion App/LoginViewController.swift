//
//  LoginView.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    var completedActivityLog: CompletedActivityLog!
    var participant = Participant.init(name: "David", email: "dchopin1@live.maryville.edu", code: "000000")
    //This participant is only preset because we are currently skipping the login phase. Once the login screen is reimplemented, this participant variable should be optional and then set to whatever data corresponds to the code entered on the login page.
    
    let listOfParticipants = [Participant(name: "David", email: "dchopin1@live.maryville.edu", code: "000000"), Participant(name: " ", email: nil, code: "000001"), Participant(name: " ", email: nil, code: "000002")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadDateAndTime()
    }
    
    func loadDateAndTime() {
        let today = Date()
        let d_format = DateFormatter()
        d_format.dateFormat = "dd/MM/yyyy"
        dateLabel.text = d_format.string(from: today)
        timeLabel.text = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none
            , timeStyle: DateFormatter.Style.short)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        codeTextField.text = nil
        if codeTextField.text == nil {
            loginButton.isEnabled = false
        }
        codeTextField.placeholder = "code"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        loadDateAndTime()
        
        //The following line of code allows us to immediately segue to the activityviewcontroller so that we do not have to log in each time we are testing the application. Removing this line of code will require the tester/user to login with an active login code.
        performSegue(withIdentifier: "segueToActivities", sender: self)
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        // looping only works if the first participant code is selected, need to re-think this logic
        for thisParticipant in listOfParticipants {
            if thisParticipant
                .code == codeTextField.text {
                participant = thisParticipant
                let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
                completedActivityLog.allCompletedActivities[thisLogItem].participantCode = codeTextField.text!
                codeTextField.text = nil
                performSegue(withIdentifier: "segueToActivities", sender: UIButton.self)
            } else {
                codeTextField.text = nil
                codeTextField.placeholder = "Please try again"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let activityCollectionViewController = segue.destination as! ActivityCollectionViewController
        activityCollectionViewController.completedActivityLog = self.completedActivityLog
        activityCollectionViewController.participant = self.participant
    }
}

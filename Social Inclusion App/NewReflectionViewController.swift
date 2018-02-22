//
//  NewReflectionViewController.swift
//  Social Inclusion App
//
//  Created by Dave on 2/21/18.
//  Copyright © 2018 Maryville Information Systems. All rights reserved.
//

import UIKit
import AVFoundation

class NewReflectionViewController: UIViewController, UITextViewDelegate, AVAudioRecorderDelegate {
    
    @IBOutlet var scrollView: UIScrollView!
    
    //Data elements
    var completedActivityLog: CompletedActivityLog!
    var activityLogItem: ActivityLogItem!
    var participant : Participant!
    var thisLogItem : Int!
    
    //Responses
    var Q1Response: String?
    var Q2Response: String?
    var Q3Response: String?
    var Q4Response: String?
    
    override func viewDidLoad() {
        scrollView.contentSize = CGSize(width: self.accessibilityFrame.width, height: 20000)
        
        thisLogItem = completedActivityLog.allCompletedActivities.count - 1
    }
    
    @IBAction func submitReflectionButtonPressed(_ sender: Any) {
        
        //Do the JSON stuff
        let json: [String: Any] = ["Name" : participant.name, "Email" : participant.email ?? " ", "Participant code" : participant.code, "Activity" : completedActivityLog.allCompletedActivities[thisLogItem].activityCode, "Q1 Response" : Q1Response ?? "N/a", "Q2 Response" : Q2Response ?? "N/a", "Q3 Response" : Q3Response ?? "N/a", "Q4 Response" : Q4Response ?? "N/a", "Time of completion" : completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted as Any]
        
        print(json)
        
        let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
        
        //Create post request
        let url = URL(string: "https://pgtest-01.musites.org/api/index.php?email=dchopin1@live.maryville.edu")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Insert json data to the request
        request.httpBody = jsonData
        
        print(request.httpBody ?? "UGH")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        
        task.resume()
        
        //Create alert and segue back to home screen
        let submissionAlert = UIAlertController(title: "Thank you!", message: "Your reflection has been sent", preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Back to activities", style: UIAlertActionStyle.default, handler: { ACTION in
            self.navigationController?.popToViewController((self.navigationController?.viewControllers[1])!, animated: true)
        })
        let orange = UIColor(red: 242/255, green: 129/255, blue: 107/255, alpha: 1)
        action.setValue(orange, forKey: "titleTextColor")
        submissionAlert.addAction(action)
        
        self.present(submissionAlert, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBOutlet weak var A1Button: UIButton!
    @IBOutlet weak var A2Button: UIButton!
    @IBOutlet weak var A3Button: UIButton!
    @IBOutlet weak var B1Button: UIButton!
    @IBOutlet weak var B2Button: UIButton!
    @IBOutlet weak var B3Button: UIButton!
    @IBOutlet weak var C1Button: UIButton!
    @IBOutlet weak var C2Button: UIButton!
    @IBOutlet weak var C3Button: UIButton!
    @IBOutlet weak var D1Button: UIButton!
    @IBOutlet weak var D2Button: UIButton!
    @IBOutlet weak var D3Button: UIButton!
    
    @IBAction func buttonPressed(_ sender: AnyObject) {
        switch sender as! UIButton {
        
        case A1Button:
            A1Button.titleLabel?.font = A1Button.titleLabel?.font.withSize(72)
            A2Button.titleLabel?.font = A2Button.titleLabel?.font.withSize(32)
            A3Button.titleLabel?.font = A3Button.titleLabel?.font.withSize(32)
            Q1Response = "Good"
        case A2Button:
            A2Button.titleLabel?.font = A2Button.titleLabel?.font.withSize(72)
            A1Button.titleLabel?.font = A1Button.titleLabel?.font.withSize(32)
            A3Button.titleLabel?.font = A3Button.titleLabel?.font.withSize(32)
            Q1Response = "Neutral"
        case A3Button:
            A3Button.titleLabel?.font = A3Button.titleLabel?.font.withSize(72)
            A1Button.titleLabel?.font = A1Button.titleLabel?.font.withSize(32)
            A2Button.titleLabel?.font = A2Button.titleLabel?.font.withSize(32)
            Q1Response = "Bad"
            
        case B1Button:
            B1Button.titleLabel?.font = B1Button.titleLabel?.font.withSize(72)
            B2Button.titleLabel?.font = B2Button.titleLabel?.font.withSize(32)
            B3Button.titleLabel?.font = B3Button.titleLabel?.font.withSize(32)
            Q2Response = "Good"
        case B2Button:
            B2Button.titleLabel?.font = B2Button.titleLabel?.font.withSize(72)
            B1Button.titleLabel?.font = B1Button.titleLabel?.font.withSize(32)
            B3Button.titleLabel?.font = B3Button.titleLabel?.font.withSize(32)
            Q2Response = "Neutral"
        case B3Button:
            B3Button.titleLabel?.font = B3Button.titleLabel?.font.withSize(72)
            B1Button.titleLabel?.font = B1Button.titleLabel?.font.withSize(32)
            B2Button.titleLabel?.font = B2Button.titleLabel?.font.withSize(32)
            Q2Response = "Bad"
            
        case C1Button:
            C1Button.titleLabel?.font = C1Button.titleLabel?.font.withSize(72)
            C2Button.titleLabel?.font = C2Button.titleLabel?.font.withSize(32)
            C3Button.titleLabel?.font = C3Button.titleLabel?.font.withSize(32)
            Q3Response = "Good"
        case C2Button:
            C2Button.titleLabel?.font = C2Button.titleLabel?.font.withSize(72)
            C1Button.titleLabel?.font = C1Button.titleLabel?.font.withSize(32)
            C3Button.titleLabel?.font = C3Button.titleLabel?.font.withSize(32)
            Q3Response = "Neutral"
        case C3Button:
            C3Button.titleLabel?.font = C3Button.titleLabel?.font.withSize(72)
            C1Button.titleLabel?.font = C1Button.titleLabel?.font.withSize(32)
            C2Button.titleLabel?.font = C2Button.titleLabel?.font.withSize(32)
            Q3Response = "Bad"
            
        case D1Button:
            D1Button.titleLabel?.font = D1Button.titleLabel?.font.withSize(72)
            D2Button.titleLabel?.font = D2Button.titleLabel?.font.withSize(32)
            D3Button.titleLabel?.font = D3Button.titleLabel?.font.withSize(32)
            Q4Response = "Good"
        case D2Button:
            D2Button.titleLabel?.font = D2Button.titleLabel?.font.withSize(72)
            D1Button.titleLabel?.font = D1Button.titleLabel?.font.withSize(32)
            D3Button.titleLabel?.font = D3Button.titleLabel?.font.withSize(32)
            Q4Response = "Neutral"
        case D3Button:
            D3Button.titleLabel?.font = D3Button.titleLabel?.font.withSize(72)
            D1Button.titleLabel?.font = D1Button.titleLabel?.font.withSize(32)
            D2Button.titleLabel?.font = D2Button.titleLabel?.font.withSize(32)
            Q4Response = "Bad"
        
        default:
            break
        }
    }
    
    
}

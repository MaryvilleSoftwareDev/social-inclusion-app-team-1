//
//  EndOfInstructionsViewController.swift
//  Social Inclusion App
//
//  Created by Mary Chopin on 4/26/17.
//  Copyright © 2017 Maryville Information Systems. All rights reserved.
//

import UIKit

import AVFoundation




class ReflectionViewController: UIViewController, UITextViewDelegate, AVAudioRecorderDelegate  {
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var submitReflectionButton: UIButton!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    var completedActivityLog: CompletedActivityLog!
    
//    var recordButton: UIButton!
//    var recordingSession: AVAudioSession!
//    var audioRecorder: AVAudioRecorder!
    
    var activityLogItem: ActivityLogItem!

    
    /*
    @IBAction func negativeEmotionSelected(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].reaction = .negative
        // resize the icons based on selection
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
    
    }
    
    @IBAction func neutralEmotionSelected(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].reaction = .neutral
        // resize the icons based on selection
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
    }
   
    @IBAction func positiveEmotionSelected(_ sender: Any) {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].reaction = .positive
        // resize the icons based on selection
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
    }
 */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set placeholder text for the summaryTextView
        summaryTextView.text = "Type how you felt here..."
        summaryTextView.textColor = (UIColor.lightGray)
        
        summaryTextView.layer.borderWidth = 1
        summaryTextView.layer.borderColor = UIColor.black.cgColor
        
        summaryTextView.delegate = self
        
        
        //Create keyboard toolbar button for submitting reflection
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let submitButton = UIBarButtonItem(title: "Submit Reflection", style: .done, target: self, action: #selector(submitReflection)
        )
        submitButton.tintColor = UIColor(red: 0, green: (122/255), blue: 1, alpha: 1)
        keyboardToolbar.items = [flexible, submitButton]
        summaryTextView.inputAccessoryView = keyboardToolbar
        

    }

        //sound addition here//
        
//        recordingSession = AVAudioSession.sharedInstance()
//        
//        do {
//            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
//            try recordingSession.setActive(true)
//            recordingSession.requestRecordPermission() { [unowned self] allowed in
//                DispatchQueue.main.async {
//                    if allowed {
//                        self.loadRecordingUI()
//                    } else {
//                        // failed to record!
//                    }
//                }
//            }
//        } catch {
//            // failed to record!
//        }
//    }

    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if summaryTextView.textColor == UIColor.lightGray {
            summaryTextView.text = nil
            summaryTextView.textColor = UIColor.black
    }
}
    func textViewDidEndEditing(_ textView: UITextView) {
        if summaryTextView.text == nil {
            summaryTextView.text = "Type how you felt here..."
            summaryTextView.textColor = (UIColor.lightGray)
        }
    }
    
    func submitReflection() {
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].response = summaryTextView.text
        completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted = Date()
        completedActivityLog.allCompletedActivities[thisLogItem].reaction = Int(slider.value)
        if summaryTextView.text == "Type how you felt here..." {
            completedActivityLog.allCompletedActivities[thisLogItem].response = nil
        }
        
        self.navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        
        //let success = completedActivityLog.saveChanges()
        //if success {
        print("Saved all of the items")
        //}
        //still have to make it so that this relfectionActivity is logged onto the server
        
        print(completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted!)
        print(completedActivityLog.allCompletedActivities[thisLogItem].reaction!)
        print(completedActivityLog.allCompletedActivities[thisLogItem].response ?? "N/A")
    }
    
    @IBAction func submitReflectionButtonPressed(_ sender: Any) {
        submitReflection()
    }
    @IBAction func sliderMoved(_ sender: Any) {
        sliderValue.text = String(Int(slider.value))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: view).x > summaryTextView.frame.maxX || touch.location(in: view).x < summaryTextView.frame.minX || touch.location(in: view).y > summaryTextView.frame.maxY || touch.location(in: view).y < summaryTextView.frame.minY || slider.frame.contains(touch.location(in: view)) {
                self.view.endEditing(true)
                if summaryTextView.text.characters.count < 1 {
                    summaryTextView.text = "Type how you felt here..."
                    summaryTextView.textColor = (UIColor.lightGray)
                }
            }
        }
    }
}


//
//  EndOfInstructionsViewController.swift
//  Social Inclusion App
//
//  Created by Mary Chopin on 4/26/17.
//  Copyright © 2017 Maryville Information Systems. All rights reserved.
//

import UIKit
import AVFoundation
import MessageUI

class ReflectionViewController: UIViewController, UITextViewDelegate, AVAudioRecorderDelegate, MFMailComposeViewControllerDelegate  {
    var writingEnabled = true
    
    //Load audio player
    var audioPlayer = AVAudioPlayer()
    var startSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "StartSound", ofType: "wav")!)
    var endSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "EndSound", ofType: "wav")!)
    func playSound(sound: NSURL) {
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        try! audioPlayer = AVAudioPlayer(contentsOf: sound as URL)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    //Storyboard elements
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var submitReflectionButton: UIButton!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var sliderValue: UILabel!
    
    @IBOutlet weak var audioRecordButton: UIButton!
    @IBOutlet weak var recordAudioLabel: UILabel!
    @IBAction func recordAudioButtonPressed(_ sender: Any) {
        if audioRecorder == nil {
            self.recordAudioLabel.text = "Tap to stop recording"
            self.startRecording()
            playSound(sound: startSound)
        } else {
            self.finishRecording(success: true)
            self.recordAudioLabel.text = "Recording complete"
            playSound(sound: endSound)
            /*if recordingEnded == false {
                self.recordAudioLabel.text = "Tap to record again"
                self.finishRecording(success: true)
                recordingEnded = true
                playSound(sound: endSound)
            } else {
                audioRecorder = nil
                recordingEnded = false
                self.recordAudioLabel.text = "Tap to stop recording"
                playSound(sound: startSound)
                self.startRecording()
            }*/
            
        }
    }
    
    @IBOutlet weak var writingAudioSegmentedControl: UISegmentedControl!
    @IBAction func writingAudioSegmentedControlTouched(_ sender: Any) {
        
        switch writingEnabled{
        case true:
            summaryTextView.isHidden = true
            audioRecordButton.isHidden = false
            recordAudioLabel.isHidden = false
            writingEnabled = false
        case false:
            audioRecordButton.isHidden = true
            recordAudioLabel.isHidden = true
            summaryTextView.isHidden = false
            writingEnabled = true
        default:
            break
        }
    }
    
    //Audio recording elements
    var recordingSession : AVAudioSession!
    var audioRecorder : AVAudioRecorder!
    var settings = [String : Int]()
    var recordingEnded = false
    
    //Data elements
    var completedActivityLog: CompletedActivityLog!
    var activityLogItem: ActivityLogItem!
    var participant : Participant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set placeholder text for the summaryTextView
        summaryTextView.text = "Type how you felt here..."
        summaryTextView.textColor = (UIColor.lightGray)
        
        summaryTextView.layer.borderWidth = 1
        if #available(iOS 10.0, *) {
            summaryTextView.layer.borderColor = UIColor(displayP3Red: 0.340, green: 0.323, blue: 0.332, alpha: 1).cgColor
        } else {
            // Fallback on earlier versions
        }
        
        summaryTextView.delegate = self
        
        
        //Create keyboard toolbar button for submitting reflection
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        keyboardToolbar.isTranslucent = false
        keyboardToolbar.barTintColor = UIColor.white
        
        let flexible = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        let submitButton = UIBarButtonItem(title: "Submit Reflection", style: .done, target: self, action: #selector(sendReflection)
        )
        submitButton.tintColor = UIColor(red: 0, green: (122/255), blue: 1, alpha: 1)
        keyboardToolbar.items = [flexible, submitButton]
        summaryTextView.inputAccessoryView = keyboardToolbar
        
        //Initially hide audio recording tool
        audioRecordButton.isHidden = true
        recordAudioLabel.isHidden = true
        
        //Set up audio recorder
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Allow")
                    } else {
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }
        
        // Audio Settings
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        print("Allow")
                    } else {
                        print("Dont Allow")
                    }
                }
            }
        } catch {
            print("failed to record!")
        }
        
        // Audio Settings
        settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

    }
    
    //Functions dealing with how the UI should respond to editing beginning/ending in the textView
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
    
    //Not sure if the mailComposeViewController stuff is still required (don't think so)
    func configureMailComposeViewController() -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        mailComposerVC.setToRecipients(["julia.louw@nuigalway.ie"])
        mailComposerVC.setSubject("\(participant.name)'s Social Activity Report")
        mailComposerVC.setMessageBody("Name: \(participant.name)\nEmail: \(participant.email ?? " ")\nParticipant code: \(participant.code)\n\nActivity: \(completedActivityLog.allCompletedActivities[thisLogItem].activityCode)\nComfort level: \(completedActivityLog.allCompletedActivities[thisLogItem].reaction!)/10\nWritten Response: \(String(completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse!) ?? " ")\nDate completed: \(completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted ?? "")", isHTML: false)
        return mailComposerVC
    }
    
    func showSendMailErrorAlert() {
        let sendMailErrorAlert = UIAlertView(title: "Could Not Send Email", message: "Your device could not send this email. Please check your device's email configuration and try again.", delegate: self, cancelButtonTitle: "OK")
        sendMailErrorAlert.show()
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case MFMailComposeResult.cancelled:
            print("Mail Cancelled")
        case MFMailComposeResult.sent:
            print("Mail Sent")
            self.dismiss(animated: true, completion: nil)
            self.navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
        default:
            break
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    //Function that prepares the completedActivityLog then performs the Post Url request with the JSON data
    func sendReflection() {
        
        //Update completedActivityLog
        let thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse = summaryTextView.text
        
        if audioRecorder != nil {
            completedActivityLog.allCompletedActivities[thisLogItem].audioResponse = audioRecorder.url
        }
        
        let today = Date()
        let d_format = DateFormatter()
        d_format.dateFormat = "dd/MM/yyyy"
        let date = d_format.string(from: today)
        let time = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none
            , timeStyle: DateFormatter.Style.short)
        
        completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted = "\(date) at \(time)"
        completedActivityLog.allCompletedActivities[thisLogItem].reaction = Int(slider.value)
        if summaryTextView.text == "Type how you felt here..." {
            completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse = nil
        }
        
        //Prepare json data
        let json: [String: Any] = ["Name" : participant.name, "Email" : participant.email ?? " ", "Participant code" : participant.code, "Activity" : completedActivityLog.allCompletedActivities[thisLogItem].activityCode, "Comfort level" : "\(completedActivityLog.allCompletedActivities[thisLogItem].reaction!)/10", "Written Response" : String(describing: completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse), "Time of completion" : completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted as Any]//["Name" : participant.name, "Email" : participant.email ?? " ", "Participant code" : participant.code, "Activity" : completedActivityLog.allCompletedActivities[thisLogItem].activityCode, "Comfort level" : "\(completedActivityLog.allCompletedActivities[thisLogItem].reaction!)/10", "Written Response" : String(describing: completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse), "Audio Response" : completedActivityLog.allCompletedActivities[thisLogItem].audioResponse as Any, "Time of completion" : completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted as Any]
        
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
        self.navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }
    
    //When the submitReflectionButton is pressed, sendReflection is called
    @IBAction func submitReflectionButtonPressed(_ sender: Any) {
        playSound(sound: audioRecorder.url as NSURL)
        sendReflection()
    }
    
    //Allows the slider's label to update whenever the slider value changes
    @IBAction func sliderMoved(_ sender: Any) {
        sliderValue.text = String(Int(slider.value))
    }
    
    //This function detects touches and whenever a touch is made outside of the summaryTextView, the keyboard is dismissed
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            if touch.location(in: view).x > summaryTextView.frame.maxX || touch.location(in: view).x < summaryTextView.frame.minX || touch.location(in: view).y > summaryTextView.frame.maxY || touch.location(in: view).y < summaryTextView.frame.minY || slider.frame.contains(touch.location(in: view)) {
                self.view.endEditing(true)
                if summaryTextView.text.count < 1 {
                    summaryTextView.text = "Type how you felt here..."
                    summaryTextView.textColor = (UIColor.lightGray)
                }
            }
        }
    }
    
    //More functions helping the audio recording work
    func directoryURL() -> NSURL? {
        let fileManager = FileManager.default
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = urls[0] as NSURL
        let soundURL = documentDirectory.appendingPathComponent("sound.m4a")
        print(soundURL)
        return soundURL as NSURL?
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            audioRecorder = try AVAudioRecorder(url: getDocumentsDirectory().appendingPathComponent("recording.m4a"),
                                                settings: settings)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
        } catch {
            finishRecording(success: false)
        }
        do {
            try audioSession.setActive(true)
            audioRecorder.record()
        } catch {
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        if success {
            print(success)
        } else {
            audioRecorder = nil
            print("Somthing Wrong.")
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}


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
    
    var Q1AudioResponse: URL?
    var Q2AudioResponse: URL?
    var Q3AudioResponse: URL?
    var Q4AudioResponse: URL?
    
    //Audio recording elements
    var player: AVAudioPlayer?
    var recordingSession : AVAudioSession!
    var audioRecorder : AVAudioRecorder!
    var settings = [String : Int]()
    var recordingEnded = false
    
    func setUpRecorder() {
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
    
    override func viewDidLoad() {
        scrollView.contentSize = CGSize(width: self.accessibilityFrame.width, height: 20000)
        
        thisLogItem = completedActivityLog.allCompletedActivities.count - 1
        
        setUpRecorder()
    }
    
    @IBAction func submitReflectionButtonPressed(_ sender: Any) {
        
        let today = Date()
        let d_format = DateFormatter()
        d_format.dateFormat = "dd/MM/yyyy"
        let date = d_format.string(from: today)
        let time = DateFormatter.localizedString(from: NSDate() as Date, dateStyle: DateFormatter.Style.none
            , timeStyle: DateFormatter.Style.short)
        
        completedActivityLog.allCompletedActivities[thisLogItem].dateCompleted = "\(date) at \(time)"
        
        let response = String(completedActivityLog.allCompletedActivities[thisLogItem].writtenResponse ?? "Not Provided" )!
        let encodedResponse = response.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
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
    
    @IBOutlet weak var R1Button: UIButton!
    @IBOutlet weak var R2Button: UIButton!
    @IBOutlet weak var R3Button: UIButton!
    @IBOutlet weak var R4Button: UIButton!
    @IBOutlet weak var R1Label: UILabel!
    @IBOutlet weak var R2Label: UILabel!
    @IBOutlet weak var R3Label: UILabel!
    @IBOutlet weak var R4Label: UILabel!
    var R1Recording = false
    var R2Recording = false
    var R3Recording = false
    var R4Recording = false
    
    
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
            
            if R1Recording {
                Q1AudioResponse = audioRecorder.url
                print(Q1AudioResponse)
            } else if R2Recording {
                Q2AudioResponse = audioRecorder.url
                print(Q2AudioResponse)
            } else if R3Recording {
                Q3AudioResponse = audioRecorder.url
                print(Q3AudioResponse)
            } else if R4Recording {
                Q4AudioResponse = audioRecorder.url
                print(Q4AudioResponse)
            }
            
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
    
    //Load audio player
    var audioPlayer = AVAudioPlayer()
    func playSound(fileName: String, fileType: String){
        // Fetch the Sound data set.
        if let asset = NSDataAsset(name:fileName){
            
            do {
                // Use NSDataAsset's data property to access the audio file stored in Sound.
                player = try AVAudioPlayer(data:asset.data, fileTypeHint:fileType)
                // Play the above sound file.
                player?.play()
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
    }
    
    @IBAction func recordButtonPressed(_ sender: AnyObject) {
        
        switch sender as! UIButton {
       
        case R1Button:
            if R1Button.imageView?.image == UIImage(named:"RecordButton") {
                R1Button.setImage(UIImage(named: "StopButton"), for: .normal)
                self.startRecording()
                playSound(fileName: "StartSound", fileType: "wav")
                R1Label.text = "Stop Recording"
                R1Recording = true
            } else {
                R1Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                self.finishRecording(success: true)
                playSound(fileName: "EndSound", fileType: "wav")
                R1Label.text = "Record Audio"
                R1Recording = false
            }
            
            if R2Button.imageView?.image == UIImage(named:"StopButton") {
                R2Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R2Label.text = "Record Audio"
                R2Recording = false
            }
            if R3Button.imageView?.image == UIImage(named:"StopButton") {
                R3Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R3Label.text = "Record Audio"
                R3Recording = false
            }
            if R4Button.imageView?.image == UIImage(named:"StopButton") {
                R4Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R4Label.text = "Record Audio"
                R4Recording = false
            }
            
        case R2Button:
            if R2Button.imageView?.image == UIImage(named:"RecordButton") {
                R2Button.setImage(UIImage(named: "StopButton"), for: .normal)
                self.startRecording()
                playSound(fileName: "StartSound", fileType: "wav")
                R2Label.text = "Stop Recording"
                R2Recording = true
            } else {
                R2Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                self.finishRecording(success: true)
                playSound(fileName: "EndSound", fileType: "wav")
                R2Label.text = "Record Audio"
                R2Recording = false
            }
            
            if R1Button.imageView?.image == UIImage(named:"StopButton") {
                R1Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R1Label.text = "Record Audio"
                R1Recording = false
            }
            if R3Button.imageView?.image == UIImage(named:"StopButton") {
                R3Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R3Label.text = "Record Audio"
                R3Recording = false
            }
            if R4Button.imageView?.image == UIImage(named:"StopButton") {
                R4Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R4Label.text = "Record Audio"
                R4Recording = false
            }
            
        case R3Button:
            if R3Button.imageView?.image == UIImage(named:"RecordButton") {
                R3Button.setImage(UIImage(named: "StopButton"), for: .normal)
                self.startRecording()
                playSound(fileName: "StartSound", fileType: "wav")
                R3Label.text = "Stop Recording"
                R3Recording = true
            } else {
                R3Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                self.finishRecording(success: true)
                playSound(fileName: "EndSound", fileType: "wav")
                R3Label.text = "Record Audio"
                R3Recording = false
            }
            
            if R1Button.imageView?.image == UIImage(named:"StopButton") {
                R1Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R1Label.text = "Record Audio"
                R1Recording = false
            }
            if R2Button.imageView?.image == UIImage(named:"StopButton") {
                R2Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R2Label.text = "Record Audio"
                R2Recording = false
            }
            if R4Button.imageView?.image == UIImage(named:"StopButton") {
                R4Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R4Label.text = "Record Audio"
                R4Recording = false
            }
            
        case R4Button:
            if R4Button.imageView?.image == UIImage(named:"RecordButton") {
                R4Button.setImage(UIImage(named: "StopButton"), for: .normal)
                self.startRecording()
                playSound(fileName: "StartSound", fileType: "wav")
                R4Label.text = "Stop Recording"
                R4Recording = true
            } else {
                R4Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                self.finishRecording(success: true)
                playSound(fileName: "EndSound", fileType: "wav")
                R4Label.text = "Record Audio"
                R4Recording = false
            }
            
            if R1Button.imageView?.image == UIImage(named:"StopButton") {
                R1Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R1Label.text = "Record Audio"
                R1Recording = true
            }
            if R2Button.imageView?.image == UIImage(named:"StopButton") {
                R2Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R2Label.text = "Record Audio"
                R2Recording = false
            }
            if R3Button.imageView?.image == UIImage(named:"StopButton") {
                R3Button.setImage(UIImage(named: "RecordButton"), for: .normal)
                R3Label.text = "Record Audio"
                R3Recording = false
            }
            
        default:
            break
        }
    }
    
}

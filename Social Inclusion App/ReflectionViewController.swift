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
    @IBOutlet weak var negativeEmotion: UIButton!
    @IBOutlet weak var neutralEmotion: UIButton!
    @IBOutlet weak var positiveEmotion: UIButton!
    
    //sound variables//
    
    @IBAction func recordButton(_ sender: Any) {
    }
    
    var recordButton: UIButton!
    var recordingSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    
    var reflectionActivity: ActivityLogItem!
    
    @IBAction func negativeEmotionSelected(_ sender: Any) {
        
        reflectionActivity.reaction = .negative
        
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
    
    }
    
    @IBAction func neutralEmotionSelected(_ sender: Any) {
        
        reflectionActivity.reaction = .neutral

        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))

    }
   
    @IBAction func positiveEmotionSelected(_ sender: Any) {
        
        reflectionActivity.reaction = .positive
        
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryTextView.text = "Type how you felt here..."
        summaryTextView.textColor = (UIColor.lightGray)
        
        summaryTextView.layer.borderWidth = 1
        summaryTextView.layer.borderColor = UIColor.black.cgColor
        
        summaryTextView.delegate = self
        
        
        //sound addition here//
        
        recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try recordingSession.setActive(true)
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                    } else {
                        print("it doesnt work!")
                    }
                    
                }
            }
        } catch {
             print("failed to record!")
        }
    }
    
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
    
    func submiteReflectionButtonPressed(_ sender: Any) {
        reflectionActivity.recording = summaryTextView.text
        reflectionActivity.dateCompleted = Date()
        //still have to make it so that this relfectionActivity is logged onto the server
    }
    
//    //Audio Recodring//
//    
    func loadRecordingUI() {
        recordButton = UIButton(frame: CGRect(x: 64, y: 64, width: 128, height: 64))
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        view.addSubview(recordButton)
    }
    
    func startRecording() {
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
            recordButton.setTitle("Tap to Stop", for: .normal)
        } catch {
            finishRecording(success: false)
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    //stop recording button//
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil
        
        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)
            // recording failed :(
        }
    }
    
    func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
}

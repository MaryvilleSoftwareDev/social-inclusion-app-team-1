//
//  EndOfInstructionsViewController.swift
//  Social Inclusion App
//
//  Created by Mary Chopin on 4/26/17.
//  Copyright © 2017 Maryville Information Systems. All rights reserved.
//

import UIKit

class ReflectionViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var summaryTextView: UITextView!
    @IBOutlet weak var submitReflectionButton: UIButton!
    @IBOutlet weak var negativeEmotion: UIButton!
    @IBOutlet weak var neutralEmotion: UIButton!
    @IBOutlet weak var positiveEmotion: UIButton!
    
    var activityLogItem: ActivityLogItem!
    
    @IBAction func negativeEmotionSelected(_ sender: Any) {
        
        activityLogItem.reaction = .negative
        
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        
        label3.text = activityLogItem.reaction.display
    
    }
    
    @IBAction func neutralEmotionSelected(_ sender: Any) {
        
        activityLogItem.reaction = .neutral

        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        
        label3.text = activityLogItem.reaction.display

    }
   
    @IBAction func positiveEmotionSelected(_ sender: Any) {
        
        activityLogItem.reaction = .positive
        
        negativeEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        neutralEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 28))
        positiveEmotion.titleLabel?.font = (UIFont .systemFont(ofSize: 55))
        
        label3.text = activityLogItem.reaction.display

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        summaryTextView.text = "Type how you felt here..."
        summaryTextView.textColor = (UIColor.lightGray)
        
        summaryTextView.layer.borderWidth = 1
        summaryTextView.layer.borderColor = UIColor.black.cgColor
        
        summaryTextView.delegate = self
        
        
        
        
        label1.text = String(describing: activityLogItem.dateCompleted)
        label2.text = activityLogItem.participantCode
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
    
    @IBAction func submiteReflectionButtonPressed(_ sender: Any) {
        activityLogItem.recording = summaryTextView.text
        activityLogItem.dateCompleted = Date()
        //still have to make it so that this relfectionActivity is logged onto the server
    }
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    
    
    
    
    
}

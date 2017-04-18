//
//  ActivityLog.swift
//  Social Inclusion App
//
//  Created by John Zaiss on 4/11/17.
//  Copyright © 2017 John Zaiss. All rights reserved.
//

import UIKit

enum EmotionEmoji {
    
    case positive
    case neutral
    case negative
    
    var display: String {
        
        switch self {
        case .positive: return "😀"
        case .neutral: return "😐"
        case .negative: return "☹️"
        }
        
    }
}

class ActivityLogItem: Activity {
    
    var dateCompleted: Date
    var reaction: EmotionEmoji
    var recording: String? //audio file
    
    init(activity: Activity, totalTime: Int, reaction: EmotionEmoji, recording: String?) {
        
        self.dateCompleted = Date()
        self.reaction = reaction
        self.recording = recording // probably better to have function in this class to start the recorder
        super.init()
        
        /*
         Additiona functions needed are
         createAudioRecording
         */
        
    }
    
    // placeholder function
    func setEmotionEmoji() -> EmotionEmoji {
        
        return .neutral
        
    }
    
    
}

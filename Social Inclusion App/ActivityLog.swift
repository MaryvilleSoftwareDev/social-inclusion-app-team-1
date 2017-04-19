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
    case none
    
    var display: String {
        
        switch self {
        case .positive: return "😀"
        case .neutral: return "😐"
        case .negative: return "☹️"
        case .none: return " "
        }
        
    }
}

class ActivityLogItem: Activity {
    
    var dateCompleted: Date
    var reaction: EmotionEmoji
    var recording: String? //audio file
    var participantCode: String
    
    override init() {
        
        self.dateCompleted = Date()
        self.reaction = .none
        self.recording = "" // probably better to have function in this class to start the recorder
        self.participantCode = ""
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

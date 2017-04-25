//
//  ActivityLog.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
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
    var participantCode: String
    
    init(activity: Activity, totalTime: Int, reaction: EmotionEmoji, recording: String?, participantCode: String) {
        
        self.dateCompleted = Date()
        self.reaction = reaction
        self.recording = recording // probably better to have function in this class to start the recorder
        self.participantCode = participantCode
        super.init(name: "", description: "", icon: #imageLiteral(resourceName: "grand-piano"), category: "", instructions: placeHolderInstructions)
        
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

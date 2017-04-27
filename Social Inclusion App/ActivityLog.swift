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

struct InstructionTimer {
    
    var instructionCode: String
    var startTime: Date?
    var stopTime: Date?
    
    mutating func startInstructionTimer(forInstruction: String) -> InstructionTimer {
        self.instructionCode = forInstruction
        self.startTime = Date()
        return self
    }
    
    mutating func stopInstructionTimer(forInstruction: String) -> InstructionTimer {
        self.instructionCode = forInstruction
        self.stopTime = Date()
        return self
    }
    
    init () {
        self.instructionCode = ""
        self.startTime = nil
        self.stopTime = nil
    }
}

class ActivityLogItem {
    
    var dateCompleted: Date?
    var reaction: EmotionEmoji
    var recording: String? //audio file
    var participantCode: String
    var activityCode: String
    var instructionCode: String
    var instructionTimer = [InstructionTimer]()
    
    init() {
        
        self.dateCompleted = nil
        self.reaction = .none
        self.recording = ""
        self.activityCode = ""
        self.instructionCode = ""
        self.participantCode = ""

    }
    
    
    
    // placeholder function
    func setEmotionEmoji() -> EmotionEmoji {
        
        return .neutral
        
    }
    
    
}

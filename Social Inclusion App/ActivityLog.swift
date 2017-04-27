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

class ActivityLogItem: NSObject, NSCoding {
    
    
    var dateCompleted: Date?
    var reaction: EmotionEmoji
    var recording: String? //audio file
    var participantCode: String
    var activityCode: String
    var instructionCode: String
    var instructionTimer = [InstructionTimer]()
    
    override init() {
        
        self.dateCompleted = nil
        self.reaction = .none
        self.recording = ""
        self.activityCode = ""
        self.instructionCode = ""
        self.participantCode = ""

    }
    
    
    // placeholder function
    required init(coder aDecoder: NSCoder) {
        dateCompleted = aDecoder.decodeObject(forKey: "dateCompleted") as? Date
        reaction = (aDecoder.decodeObject(forKey: "reaction") as? EmotionEmoji)!
        recording = aDecoder.decodeObject(forKey: "recording") as? String
        participantCode = aDecoder.decodeObject(forKey: "participantCode") as! String
        activityCode = aDecoder.decodeObject(forKey: "activityCode") as! String
        instructionCode = aDecoder.decodeObject(forKey: "instructionCode") as! String
        instructionTimer = [aDecoder.decodeObject(forKey: "instructionTimer") as! InstructionTimer]
        
        super.init()
    }

    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateCompleted, forKey: "dateCompleted")
        aCoder.encode(reaction, forKey: "reaction")
        aCoder.encode(recording, forKey: "recording")
        aCoder.encode(participantCode, forKey: "participantCode")
        aCoder.encode(activityCode, forKey: "activityCode")
        aCoder.encode(instructionCode, forKey: "instructionCode")
        aCoder.encode(instructionTimer, forKey: "instructionTimer")
        
        
    }
    func setEmotionEmoji() -> EmotionEmoji {
        
        return .neutral
        
    }
    
    func readActivityLog() {
        
    }
    
    func saveActivityLog() {
        
        
        
    }
    
    
}

//
//  ActivityLog.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

struct InstructionTimer {
    
    var instructionCode: String
    var startTime: Date?
    var stopTime: Date?
    var timeTaken: Double?
    
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
    
    mutating func convertDatesToUnix(start: Date, stop: Date){
        let unixStart = start.timeIntervalSince1970
        let unixStop = stop.timeIntervalSince1970
        timeTaken = unixStop-unixStart
    }
    
    init () {
        self.instructionCode = ""
        self.startTime = nil
        self.stopTime = nil
        self.timeTaken = nil
    }
}

class ActivityLogItem: NSObject, NSCoding {
    
    
    var dateCompleted: String?
    var reaction: Int?
    var writtenResponse: String? //audio file
    var audioResponse : URL?
    var participantCode: String
    var activityCode: String
    var instructionTimer = [InstructionTimer]()
    
    override init() {
        
        self.dateCompleted = nil
        self.reaction = nil
        self.writtenResponse = ""
        self.audioResponse = nil
        self.activityCode = ""
        self.participantCode = ""
    }
    
    required init(coder aDecoder: NSCoder) {
        dateCompleted = aDecoder.decodeObject(forKey: "dateCompleted") as? String
        reaction = (aDecoder.decodeObject(forKey: "reaction") as? Int)!
        writtenResponse = aDecoder.decodeObject(forKey: "writtenResponse") as? String
        audioResponse = aDecoder.decodeObject(forKey: "audioResponse") as! URL
        participantCode = aDecoder.decodeObject(forKey: "participantCode") as! String
        activityCode = aDecoder.decodeObject(forKey: "activityCode") as! String
        instructionTimer = [aDecoder.decodeObject(forKey: "instructionTimer") as! InstructionTimer]
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(dateCompleted, forKey: "dateCompleted")
        aCoder.encode(reaction, forKey: "reaction")
        aCoder.encode(writtenResponse, forKey: "writtenResponse")
        aCoder.encode(audioResponse, forKey: "audioResponse")
        aCoder.encode(participantCode, forKey: "participantCode")
        aCoder.encode(activityCode, forKey: "activityCode")
        aCoder.encode(instructionTimer, forKey: "instructionTimer")
    }
    
    // This method has not yet been implemented
    func updateFor(selectedActivity: Activity) {
        self.activityCode = selectedActivity.activityCode
        self.instructionTimer = [InstructionTimer()]
    }
    
    
}

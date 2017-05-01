//
//  Activity.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

// The Instructions type is used in the Activity class to create an instructions array of one or more instructions for an activity

struct Instructions {
    
    var title:String
    var instructionCode:String
    var details:String
    var image:UIImage?
    var socialSkill:String?
    var socialSkillText:String?
    
    init(title: String, instructionCode: String, details: String, image: UIImage?, socialSkill: String?, socialSkillText: String?){
        self.title = title
        self.instructionCode = instructionCode
        self.details = details
        self.image = image
        self.socialSkill = socialSkill
        self.socialSkillText = socialSkillText
    }
    
    init(from dict: [String:Any?]) {
        self.title = dict["title"] as! String
        self.instructionCode = dict["instructionCode"] as! String
        self.details = dict["details"] as! String
        
        if let imageFile = dict["image"] as? UIImage {
            self.image = imageFile
        } else {
            self.image = nil
        }
        
        if let socialSkillString = dict["socialSkill"] as? String {
            self.socialSkill = socialSkillString
        } else {
            self.socialSkill = nil
        }
        
        if let socialSkillTextString = dict["socialSkillText"] as? String {
            self.socialSkillText = socialSkillTextString
        } else {
            self.socialSkillText = nil
        }
        
    }
}

// The SocialSkills type is reserved for future revisions of the app
struct SocialSkills {
    
    var skillName:String
    var skillDetails:String
    
    init(skillName: String, skillDetails: String) {
        self.skillName = skillName
        self.skillDetails = skillDetails
    }
}

// The Activity class defines a single activity that is added to the ActivityCatalog when read from a web database
// The Activity class is extended in the ActivityLogItem class to record details about a completed activity
class Activity {
    
    var name:String
    var activityCode:String
    var description:String
    var icon:UIImage?
    var category:String
    var instructions = [Instructions]()
    
    init(name: String, activityCode: String, description: String, icon: UIImage, category: String, instructions: [Instructions]) {
        self.name = name
        self.activityCode = activityCode
        self.description = description
        self.icon = icon
        self.category = category
        self.instructions = instructions
    }
    
    init (from dict: [String:Any?]) {
        
        self.name = dict["name"] as! String
        self.activityCode = dict["activityCode"] as! String
        self.description = dict["description"] as! String
        
        // may consider adding this as a separate method
        let iconText = dict["icon"] as! String
        if iconText == "coffee" {
            self.icon = #imageLiteral(resourceName: "coffee")
        } else if iconText == "grand-piano" {
            self.icon = #imageLiteral(resourceName: "grand-piano")
        } else if iconText == "dog walk" {
            self.icon = #imageLiteral(resourceName: "dog walk")
        } else if iconText == "church" {
            self.icon = #imageLiteral(resourceName: "church")
        } else {
            self.icon = nil
        }
        
        self.category = dict["category"] as! String
        
        var instructionsTemp = [Instructions]()
        if let instructionsArray = dict["instructions"] as! [Any]? {
            for instruction in instructionsArray {
                if let instructionsDict = instruction as? [String:Any] {
                    instructionsTemp.append( Instructions(from: instructionsDict))
                }
            }
        }
        self.instructions = instructionsTemp
    }
    // once read in as part of the readActivities function the data is static as the app runs
}

// This is a class to collect all completed activities for a participant
// The CompletedActivity.log file is a temporary archive to hold completed activities until results can be submitted to a web server
// Future implementation will be to read the CompletedActivity.log archive, then stream as json to a web server and purge the archive

class CompletedActivityLog {
    
    var allCompletedActivities: [ActivityLogItem] = []
    
    let activityLogFileURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("CompletedActivity.log")
    }()
    
    // Creates a shell for the current activity log item
    func createLogEntry() -> ActivityLogItem {
        let newLogEntry = ActivityLogItem()
        allCompletedActivities.append(newLogEntry)
        return newLogEntry
    }
    
    // reads the CompletedActivity.log archive and appends a shell for the current activity log item
    // or creates a new CompletedActivityLog with a shell for the current activity log item
    init() {
        if let activityLog =
            NSKeyedUnarchiver.unarchiveObject(withFile: activityLogFileURL.path) as? [ActivityLogItem] {
            allCompletedActivities += activityLog
            allCompletedActivities += [createLogEntry()]
        } else {
            allCompletedActivities = [createLogEntry()]
        }
    }

    func saveChanges() -> Bool {
        print("Saving items to: \(activityLogFileURL.path)")
        return NSKeyedArchiver.archiveRootObject(allCompletedActivities, toFile: activityLogFileURL.path)
    }
}

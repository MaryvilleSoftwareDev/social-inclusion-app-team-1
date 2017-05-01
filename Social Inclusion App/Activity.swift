//
//  Activity.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

// The Instructions type is used to create an array of instructions in the SocialSkills struct

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

// The SocialSkills type is used to create and array of SocialSkills in the Activity class
struct SocialSkills {
    
    var skillName:String
    var skillDetails:String
    
    init(skillName: String, skillDetails: String) {
        self.skillName = skillName
        self.skillDetails = skillDetails
    }
    
    // var skillInstructions = [Instructions]()
    
    // once read in as part of the readActivities function the data is static as the app runs
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
        //self.icon = dict["icon"] as! UIImage
        
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

// The ActivityCatalog contains a list of all activities available
// We should determine how to store in a local file once read from a web database
// Also how to trigger an ActivityCatalog update if there are updates in the web database
class CompletedActivityCatalog {
    
    var allActivities = [ActivityLogItem]()
    
    let activityLogFileURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory,
                                     in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("CompletedActivityCatalog.log")
    }()
    
    init() {
        if let activityLogCatalog =
            NSKeyedUnarchiver.unarchiveObject(withFile: activityLogFileURL.path) as? [ActivityLogItem] {
            allActivities += activityLogCatalog
        }
    }

    func saveChanges() -> Bool {
        print("Saving items to: \(activityLogFileURL.path)")
        return NSKeyedArchiver.archiveRootObject(allActivities, toFile: activityLogFileURL.path)
    }
}

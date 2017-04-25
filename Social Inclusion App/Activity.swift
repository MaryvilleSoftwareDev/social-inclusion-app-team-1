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
    var socialSkill:SocialSkills?
    var socialSkillText:String?
    
    init(title: String, instructionCode: String, details: String, image: UIImage?, socialSkill: SocialSkills?, socialSkillText: String?){
        self.title = title
        self.instructionCode = instructionCode
        self.details = details
        self.image = image
        self.socialSkill = socialSkill
        self.socialSkillText = socialSkillText
    }
    
    /*
     need a start timer function
     need a stop timer function, record start time in the timer value then calculate on stopping it
     */
    
    
    // once read in as part of the readActivities function the data is static as the app runs
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
    var icon:UIImage
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
    // once read in as part of the readActivities function the data is static as the app runs
}

// The ActivityCatalog contains a list of all activities available
// We should determine how to store in a local file once read from a web database
// Also how to trigger an ActivityCatalog update if there are updates in the web database
class ActivityCatalog {
    
    private var allActivities = [Activity]()
    
    init() {
        readActivities()
    }
    
    func readActivities(){
        //get the activities from a web database
    }
    
}

//
//  Activity.swift
//  Social Inclusion App
//
//  Created by John Zaiss on 4/11/17.
//  Copyright © 2017 John Zaiss. All rights reserved.
//

import UIKit

// The Instructions type is used to create an array of instructions in the SocialSkills struct

struct Instructions {
    
    var title:String
    var details:String
    var image:UIImage?
    var startTimer = [Date]()
    var stopTimer = [Date]()
    var socialSkill:SocialSkills?
    var socialSkillText:String?
    
    /*
     need a start timer function
     need a stop timer function, record start time in the timer value then calculate on stopping it
     */
    
    mutating func update(withSkill: SocialSkills, skillComment: String) {

        self.socialSkill = withSkill
        self.socialSkillText = skillComment
        
    }
    // once read in as part of the readActivities function the data is static as the app runs
}

// The SocialSkills type is used to create and array of SocialSkills in the Activity class
struct SocialSkills {
    
    var skillName:String
    var skillDetails:String
    // var skillInstructions = [Instructions]()
    
    // once read in as part of the readActivities function the data is static as the app runs
}

// The Activity class defines a single activity that is added to the ActivityCatalog when read from a web database
// The Activity class is extended in the ActivityLogItem class to record details about a completed activity
class Activity {
    
    var name:String
    var description:String
    var icon:UIImage
    var category:String
    var instructions = [Instructions]()
    
    init() {
        self.name = ""
        self.description = ""
        self.icon = UIImage(named: "")!
        self.category = ""
        self.instructions = [Instructions]()
    }
    // once read in as part of the readActivities function the data is static as the app runs
}

// The ActivityCatalog contains a list of all activities available
// We should determine how to store in a local file once read from a web database
// Also how to trigger an ActivityCatalog update if there are updates in the web database
class ActivityCatalog {
    
    private var allActivities = [Activity]()
    
    var count:Int {
        return allActivities.count
    }
    
    init() {
        readActivities()
    }
    
    func loadDefaultActivityCatalog(newActivityCatalog: ActivityCatalog) {
        
        let activityNames = ["Walk my dog",
                             "Order a meal in a cafe",
                             "Learn to play a musical instrument",
                             "Play a sport"]
        
        let activityDescriptions = ["It's fun to walk the dog and meet new people",
                                    "Visiting your favorite restaurant or café is always fun. Most times your family or friends will go with you to enjoy a meal or a piece of cake.",
                                    "Playing an instrument is fun",
                                    "Playing a sport requiers teamwork in is lots of fun."]
        
        for x in 0...3 {
            let newActivity = Activity()
            newActivity.name = activityNames[x]
            newActivity.description = activityDescriptions[x]
            allActivities.append( newActivity )
            let defaultInstruction = Instructions(title: "Step 1", details: "", image: nil, startTimer: [Date()], stopTimer: [Date()], socialSkill: nil, socialSkillText: nil)
            
            switch x {
            case 0:
                var instruction = defaultInstruction
                instruction.title = "Step 1"
                instruction.details = "Walking the dog step 1"
                newActivity.instructions.append(instruction)
                instruction = defaultInstruction
                instruction.title = "Step 2"
                instruction.details = "Walking the dog step 2"
                newActivity.instructions.append(instruction)
                
            case 1:
                var instruction = defaultInstruction
                instruction.title = "Step 1"
                instruction.details = "When entering a restaurant or café, you will be welcomed by a person called a ‘waiter’ who will help you with your order – give them a friendly smile and say hello!"
                var socialSkill = SocialSkills(skillName: "Greeting", skillDetails: "")
                instruction.update(withSkill: socialSkill, skillComment: "Do you still remember how to ‘greet’ people you meet for the first time?")
                newActivity.instructions.append(instruction)
                instruction = defaultInstruction
                instruction.title = "Step 2"
                instruction.details = "On the table you will find a list of all your favorite foods, this is called a menu – choose which meal you would like to order and tell the waiter your choice. Remember to thank the waiter after they bring your meal. "
                newActivity.instructions.append(instruction)
                instruction.title = "Step 3"
                instruction.details = "Enjoy your lovely meal and when your family or friends are having good conversation at the table make sure to listen well."
                socialSkill = SocialSkills(skillName: "Listening", skillDetails: "")
                instruction.update(withSkill: socialSkill, skillComment: "Do you still remember how to ‘listen’ when enjoying good conversation")
                newActivity.instructions.append(instruction)
                instruction = defaultInstruction
                instruction.title = "Step 4"
                instruction.details = "When you are done, remember to pay for the meal – ask the waiter to bring you the bill or ask how much your meal cost."
                newActivity.instructions.append(instruction)
            case 2:
                var instruction = defaultInstruction
                instruction.title = "Step 1"
                instruction.details = "Playing an instrument step 1"
                newActivity.instructions.append(instruction)
                instruction = defaultInstruction
                instruction.title = "Step 2"
                instruction.details = "Playing an instrument step 2"
                newActivity.instructions.append(instruction)
            case 3:
                var instruction = defaultInstruction
                instruction.title = "Step 1"
                instruction.details = "Playing a sport step 1"
                newActivity.instructions.append(instruction)
                instruction = defaultInstruction
                instruction.title = "Step 2"
                instruction.details = "Playing a sport step 2"
                newActivity.instructions.append(instruction)
            default:break
            }
        }
        
    }
    
    func readActivities(){
        //get the activities from a web database
    }
    
}

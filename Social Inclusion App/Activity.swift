//
//  Activity.swift
//  TeamProjectDraft
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
    var skillInstructions = [Instructions]()
    
    // once read in as part of the readActivities function the data is static as the app runs
}

// The Activity class defines a single activity that is added to the ActivityCatalog when read from a web database
// The Activity class is extended in the ActivityLogItem class to record details about a completed activity
class Activity {
    
    var name:String
    var description:String
    var icon:UIImage
    var category:String
    var socialSkills = [SocialSkills]()
    
    init() {
        self.name = ""
        self.description = ""
        self.icon = UIImage(named: "")!
        self.category = ""
        self.socialSkills = [SocialSkills]()
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

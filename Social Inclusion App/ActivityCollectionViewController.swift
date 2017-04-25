//
//  ActivityCollectionViewController.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

let exampleSkill: SocialSkills = SocialSkills(skillName: "example skill", skillDetails: "this is a placeholder skill until we are told what the actual social skills are")

let instrumentInstructions = [Instructions(title: "Buy an instrument", instructionCode: "Code1", details: "You may want to start with an affordable insrument", image: #imageLiteral(resourceName: "grand-piano"), socialSkill: exampleSkill, socialSkillText: "N/a"), Instructions(title: "Find a good instructor", instructionCode: "Code2", details: "If you cannot find an affordable instructor, there are many instrument teaching books for cheap", image: #imageLiteral(resourceName: "grand-piano"), socialSkill: exampleSkill, socialSkillText: "N/a"), Instructions(title: "Begin performing in front of people you know", instructionCode: "Code3", details: "Start with performing in front of those you are closest to before performing to less well-known peers", image: #imageLiteral(resourceName: "grand-piano"), socialSkill: exampleSkill, socialSkillText: "N/a")]

let placeHolderInstructions = [Instructions(title: "", instructionCode: "Code1", details: "", image: #imageLiteral(resourceName: "grand-piano"), socialSkill: exampleSkill, socialSkillText: "N/a")]

class ActivityCollectionViewController: UICollectionViewController {
    
    let activities = [Activity(name: "Learn Instrument", activityCode: "AC1", description: "You will play an instrument", icon: #imageLiteral(resourceName: "grand-piano"), category: "example skill", instructions: instrumentInstructions), Activity(name: "Get Coffee", activityCode: "AC2", description: "You will go out and get some coffee", icon: #imageLiteral(resourceName: "coffee"), category: "example skill", instructions: placeHolderInstructions), Activity(name: "Walk Dog", activityCode: "AC3", description: "You will walk your dog", icon: #imageLiteral(resourceName: "dog walk"), category: "example skill", instructions: placeHolderInstructions), Activity(name: "Go To Chruch", activityCode: "AC4", description: "You will go to church", icon: #imageLiteral(resourceName: "church"), category: "example skill", instructions: placeHolderInstructions)]
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return activities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ActivityCell
        let item = activities[indexPath.row]
        
        cell?.cellImage.image = item.icon
        cell?.cellActivityTitle.text = item.name
        cell?.cellActivity = item
        
        return cell!
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInstructions" {
            let cell = collectionView?.indexPath(for: sender as! UICollectionViewCell)
            let selectedActivity = activities[(cell?.row)!]
            let instructionsViewController = segue.destination as! InstructionsViewController
            
            instructionsViewController.instructionActivity = selectedActivity
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}


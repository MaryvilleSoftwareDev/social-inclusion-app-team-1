//
//  ActivityCollectionViewController.swift
//  New Social Inclusion App
//
//  Created by Mary Chopin on 4/21/17.
//  Copyright © 2017 David Chopin. All rights reserved.
//

import UIKit

class ActivityCollectionViewController: UICollectionViewController {
    
    var completedActivityLog: CompletedActivityLog!
    var participantCode: String!
    
    // Cread an array of activities bt reading activities.json
    var jsonActivities:[Activity] = [Activity]()
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return jsonActivities.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? ActivityCell
        let item = jsonActivities[indexPath.row]
        cell?.cellImage.image = item.icon
        cell?.cellActivityTitle.text = item.name
        cell?.cellActivity = item
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToInstructions" {
            let cell = collectionView?.indexPath(for: sender as! UICollectionViewCell)
            let selectedActivity = jsonActivities[(cell?.row)!]
            let instructionsViewController = segue.destination as! InstructionsViewController
            instructionsViewController.instructionActivity = selectedActivity
            instructionsViewController.completedActivityLog = completedActivityLog
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let filepath = Bundle.main.path(forResource: "activities", ofType: "json") {
            let data = NSData(contentsOfFile: filepath)
            let jsonObject = try? JSONSerialization.jsonObject(with: data! as Data, options: [])
            if let jsonArray = jsonObject as? [Any] {
                for jsonActivity in jsonArray {
                    if let activityDictionary = jsonActivity as? [String:Any] {
                        jsonActivities.append( Activity(from:activityDictionary))
                    }
                }
            }
        }
    }
    
}


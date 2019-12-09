//
//  ViewController.swift
//  Fruits And Veggies
//
//  Created by Nick Haidari on 11/27/19.
//  Copyright © 2019 Nick Haidari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var editBarButton: UIBarButtonItem!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var starTotal: UILabel!
    @IBOutlet weak var emoticonImage: UIImageView!
    @IBOutlet weak var levelUpMeter: UIImageView!
    
    var foods = Food()
    var totalStars: Int = 0
    var starsUntilLevelUp = 10
    var leveledUpBlock = 0
    var pictureNames = ["regular-kid","strong-kid","special-melon-kid","eating-kid","special-heat-kid"]
    var allowedPictureNames = ["regular-kid"]
    var spotInPictureList = 0
    var defaultsData = UserDefaults.standard
    

    override func viewDidLoad() {
        super.viewDidLoad()
        //print("Initial: \(spotInPictureList)")
        tableView.delegate = self
        tableView.dataSource = self
        //allowedPictureNames = defaultsData.stringArray(forKey: "allowedPictures") ?? ["regular-kid"]
        //totalStars = defaultsData.integer(forKey: "totalStars")
        //foods = defaultsData.object(forKey: "foods") as? Food ?? Food()
        //spotInPictureList = defaultsData.integer(forKey: "spotInPictureList")
        //need to figure out how to encode and decode the custom foods for the table view.
        starTotal.text = "\(totalStars)/\(starsUntilLevelUp)"
        
        //totalStarCheck()
        starCheck()
        
//        if spotInPictureList != 0 {
//            for i in (1...spotInPictureList) {
//                allowedPictureNames.append(pictureNames[i])
//            }
//        }
        
        if foods == nil {
            foods.foodArray.append(FoodData(foodName: "", starValue: "", foodImage: ""))
        }
        
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowFruit" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.foodData = foods.foodArray[selectedIndexPath.row]
            // you'll put the struct in here
        } else {
            if let selectedPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedPath, animated: false)
            }
        }
    }
    
    func animatedLevelUp() {
        UIView.animate(withDuration: 2, animations: {self.emoticonImage.frame.origin.y = -self.emoticonImage.frame.size.height}, completion: nil)
    }
    
    func starCheck() {
        if totalStars < 2 {
                   levelUpMeter.image = UIImage(named: "zero-stars")
               } else if totalStars < 4 {
                   levelUpMeter.image = UIImage(named: "one-star")
               } else if totalStars < 6 {
                   levelUpMeter.image = UIImage(named: "two-stars")
               } else if totalStars < 8 {
                   levelUpMeter.image = UIImage(named: "three-stars")
               } else if totalStars < 10 {
                   levelUpMeter.image = UIImage(named: "four-stars")
               } else {
                   levelUpMeter.image = UIImage(named: "five-stars")
               }
    }
           
    
    
    @IBAction func kidTapped(_ sender: UITapGestureRecognizer) {
        
        spotInPictureList += 1
        
        if spotInPictureList == allowedPictureNames.count {
            spotInPictureList = 0
        }
        
        emoticonImage.image = UIImage(named: allowedPictureNames[spotInPictureList])
        
//        if spotInPictureList < 4 {
//            spotInPictureList += 1
//            allowedPictureNames.append(pictureNames[spotInPictureList])
//        }
//
//        if spotInPictureList == allowedPictureNames.count-1 {
//            spotInPictureList = 0
//        }
//        else {
//            spotInPictureList += 1
//        }
//
        
    }
    
//    func saveDefaultsData() {
//        defaultsData.set(allowedPictureNames, forKey: "allowedPictureNames")
//        defaultsData.set(spotInPictureList, forKey: "spotInPictureList")
//        defaultsData.set(totalStars, forKey: "totalStars")
//        defaultsData.object(forKey: "foods") as? Food
//    }
    
    
    
    @IBAction func unwindFromAddingViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! AddingViewController
        let newIndexPath = IndexPath(row: foods.foodArray.count, section: 0)
        foods.foodArray.append(sourceViewController.foodData)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
        tableView.reloadData()
        //saveDefaultsData()
        
    } // doesnt save anything yet
    
    func totalStarCheck() {
        if totalStars >= starsUntilLevelUp {
            animatedLevelUp()
            totalStars = 0
            starTotal.text = "\(totalStars)/\(starsUntilLevelUp)"
            levelUpMeter.image = UIImage(named: "zero-stars")
            if spotInPictureList < 4 {
                spotInPictureList += 1
                allowedPictureNames.append(pictureNames[spotInPictureList])
        }
        print(spotInPictureList)
        print(allowedPictureNames)
        emoticonImage.image = UIImage(named: allowedPictureNames[spotInPictureList])
        }
    }
    // this doesn't wait for the alert to come up, so theres no confirmation.
    @IBAction func unwindFromDetailViewController(segue: UIStoryboardSegue) {
        let sourceViewController = segue.source as! DetailViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            totalStars += Int(foods.foodArray[indexPath.row].starValue)!
            starTotal.text = "\(totalStars)/\(starsUntilLevelUp)"
            foods.foodArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //saveDefaultsData()
        }
        
        totalStarCheck()
        starCheck()
    }
    
    
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            addBarButton.isEnabled = true
            editBarButton.title = "Edit"
        } else {
            tableView.setEditing(true, animated: true)
            addBarButton.isEnabled = false
            editBarButton.title = "Done"
        }
    }
    

    
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //change this
        
        return foods.foodArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.update(with: foods.foodArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            foods.foodArray.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            //saveDefaultsData()
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = foods.foodArray[sourceIndexPath.row]
        foods.foodArray.remove(at: sourceIndexPath.row)
        foods.foodArray.insert(itemToMove, at: destinationIndexPath.row)
        //saveDefaultsData()
    }
    
    
}

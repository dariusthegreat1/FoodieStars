//
//  DetailViewController.swift
//  Fruits And Veggies
//
//  Created by Nick Haidari on 11/27/19.
//  Copyright © 2019 Nick Haidari. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var foodNameField: UILabel!
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet var starCollection: [UIImageView]!
    
    var foodData = FoodData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "farming")!)
        updateUserInterface()
      
    }
    
    func updateUserInterface() {
        foodNameField.text! = foodData.foodName
        guard let url = URL(string: foodData.foodImage) else { return }
        do {
            let data = try Data(contentsOf: url)
            foodImage.image = UIImage(data: data)
        } catch {
            print("error")
        }
        for star in starCollection {
            let image = UIImage(named: (star.tag < Int(foodData.starValue)! ? "food-star": "" ))
            star.image = image
        }
    }
  
    func showAlertToAcceptStars(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let acceptAction = UIAlertAction(title: "I Promise", style: .default, handler: { (action) in
            self.performSegue(withIdentifier: "unwindFromEaten", sender: action)} ) // how to make the segue occur after I Promise is pressed?????
        
        //alert.addAction(UIAlertAction(title:"OK", style: .Default, handler:  { action in self.performSegueWithIdentifier("mySegueIdentifier", sender: self) }
        //app completely works if I connected the segue to the green button but trying not to do that
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)  //executing the segue on cancel
        alertController.addAction(acceptAction)
        alertController.addAction(cancelAction)
        present(alertController, animated:  true, completion: nil)
    }
    

       
    
    
    
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        showAlertToAcceptStars(title: "Promise?", message: "Do You Promise That You Ate The Food?")
        
    }
    
}

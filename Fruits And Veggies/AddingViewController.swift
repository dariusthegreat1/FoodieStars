//
//  AddingViewController.swift
//  Fruits And Veggies
//
//  Created by Nick Haidari on 11/27/19.
//  Copyright © 2019 Nick Haidari. All rights reserved.
//

import UIKit

class AddingViewController: UIViewController {

    @IBOutlet weak var foodTextField: UITextField!
    @IBOutlet weak var numberOfStars: UILabel!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    
    var foodData = FoodData()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodTextField.becomeFirstResponder()
        disableEnableSaveButton()
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "farming")!)
    }
    
    func disableEnableSaveButton() {
        if let foodNameLength = foodTextField.text?.count, foodNameLength > 0 {
           saveBarButton.isEnabled = true
        } else {
           saveBarButton.isEnabled = false
        }
    }
    
    @IBAction func toDoFieldChanged(_ sender: UITextField) {
       disableEnableSaveButton()
    }
    
    
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }

    }
    
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        var numberOfStarsInteger = Int(numberOfStars.text!)
        if numberOfStarsInteger == 3 {
            numberOfStarsInteger = 1
        } else {
            numberOfStarsInteger! += 1
        }
        numberOfStars.text = String(numberOfStarsInteger!.self)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "UnwindFromSave" {
            
            //foodData.foodName = foodTextField.text!
            let rawString = foodTextField.text!
            let noWhitespaceString = rawString.trimmingCharacters(in: .whitespaces)
            let trimmedString = noWhitespaceString.replacingOccurrences(of: " ", with: "-")
            print("👨🏼‍🦲👨🏼‍🦲🤟🏼🦅\(trimmedString)")
            foodData.foodName = trimmedString
            foodData.starValue = numberOfStars.text!
            foodData.foodImage = "https://spoonacular.com/cdn/ingredients_100x100/\(foodData.foodName).jpg"
            
        }
    }

    
    
}

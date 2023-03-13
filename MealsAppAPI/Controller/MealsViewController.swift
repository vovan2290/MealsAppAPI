//
//  MealsViewController.swift
//  MealsAppAPI
//
//  Created by Imac on 3/11/23.
//

import UIKit

class MealsViewController: UIViewController {
    
    
    var meals: Meals?
    
    @IBOutlet weak var mealImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meal = meals {
            nameLbl.text = meal.strMeal
            idLbl.text = "meal id: \(meal.idMeal ?? "No Information")"
            
            if let img = meal.strMealThumb, let url = URL(string: img) {
                let data = try? Data(contentsOf: url)
                mealImage.image = UIImage(data: data!)
            }
        }
        
    }
    
}

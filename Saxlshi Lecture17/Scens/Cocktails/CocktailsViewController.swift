//
//  CocktailsViewController.swift
//  Saxlshi Lecture17
//
//  Created by Giorgi Goginashvili on 1/9/23.
//

import UIKit

class CocktailsViewController: UIViewController {
    
    //MARK: - Properties
    var drinksAPIManager: DrinksAPIManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        drinksAPIManager = DrinksAPIManager()
        drinksAPIManager?.fetchDrinks(with: .nonAlcoholic, complition: { result in
            switch result {
            case .success(let drinkResponce):
                print(drinkResponce.drinks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }


}


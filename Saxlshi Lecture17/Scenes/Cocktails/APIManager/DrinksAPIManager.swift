//
//  DrinksAPIManager.swift
//  Saxlshi Lecture17
//
//  Created by Giorgi Goginashvili on 1/10/23.
//

import Foundation

/*
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Non_Alcoholic
 https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail
 */

enum DrinkType: Int {
    case alcoholic = 0
    case nonAlcoholic
    case cocktail
    
    var endPoint: String {
        switch self {
        case .alcoholic:
            return "a=Alcoholic"
        case .nonAlcoholic:
            return "a=Non_Alcoholic"
        case .cocktail:
            return "c=Cocktail"
        }
    }
}

protocol  DrinksAPIManagerProtocol  {
    func fetchDrinks(with type: DrinkType, complition: @escaping (Result<DrinkResponse, Error>) -> ())
}

class DrinksAPIManager: DrinksAPIManagerProtocol {
    func fetchDrinks(with type: DrinkType, complition: @escaping (Result<DrinkResponse, Error>) -> ()) {
        let urlString = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?\(type.endPoint)"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                complition(.failure(error))
            }
            
            guard let data = data else { return }
            do {
                let decodedData = try JSONDecoder().decode(DrinkResponse.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(decodedData))
                }
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

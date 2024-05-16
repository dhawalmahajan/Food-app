//
//  Food.swift
//  Food App
//
//  Created by Dhawal Mahajan on 16/05/24.
//

import Foundation
// MARK: - Food
struct Food: Codable,Loopable {
    let meals: [Meal]?
}

// MARK: - Meal
struct Meal: Codable, Loopable  {
    let idMeal, strMeal: String?
    let strDrinkAlternate: String?
    let strCategory, strArea, strInstructions: String?
    let strMealThumb: String?
    let strTags: String?
    let strYoutube: String?
    let strIngredient1, strIngredient2, strIngredient3, strIngredient4: String?
    let strIngredient5, strIngredient6, strIngredient7, strIngredient8: String?
    let strIngredient9, strIngredient10, strIngredient11, strIngredient12: String?
    let strIngredient13, strIngredient14, strIngredient15, strIngredient16: String?
    let strIngredient17, strIngredient18, strIngredient19, strIngredient20: String?
    let strSource: String?
    let strImageSource, strCreativeCommonsConfirmed, dateModified: String?
}

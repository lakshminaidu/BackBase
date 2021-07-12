//
//  CitiesViewModel.swift
//  BabckBaseTest
//
//  Created by Lakshminaidu on 10/7/21.
//

import Foundation
// MARK: - CitiesViewModelType
protocol CitiesViewModelType {
    var allCities: [City]? {get set}
    var cities: Observable<[City]>? { get set}
    var showLoader: Observable<Bool> { get set }

    func fetchCities()
    func city(at index: Int) -> City?
    func searchCities(with string: String)
}

// MARK: - Ext CitiesViewModelType
extension CitiesViewModelType {
    
    func city(at index: Int) -> City? {
        return self.cities?.value[index]
    }
    
}

// MARK: - CityViewModel.

class CityViewModel: CitiesViewModelType {
    var showLoader: Observable<Bool> = Observable(false)
    
    var cities: Observable<[City]>? = Observable([])
    
    // MARK: - Globalvars
    internal var allCities: [City]?
 
    // fetch cities
    func fetchCities() {
        showLoader.value = true
        JsonService.fetch(from: "cities") { [weak self] (result: Envelope<[City]>) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.showLoader.value = false
                switch result {
                case .success(let data):
                    let sortedData = data.sorted { $0.title < $1.title }
                    self?.allCities = sortedData
                    self?.cities?.value = sortedData
                case .failure(_):
                    print("Some error")
                }
            }
        }
    }
    
    // filter the cities with input
    func searchCities(with string: String) {
        let tempCities = self.allCities ?? []
        if string.isEmpty {
            cities?.value = tempCities
        } else {
            let namepre = NSPredicate(format: "SELF BEGINSWITH[cd] %@", string )
            let country = NSPredicate(format: "SELF BEGINSWITH[cd] %@", string)
            cities?.value = tempCities.filter { namepre.evaluate(with: $0.name) || country.evaluate(with: $0.country) }
        }
    }
}



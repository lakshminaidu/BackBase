//
//  BabckBaseTestTests.swift
//  BabckBaseTestTests
//
//  Created by Lakshminaidu on 10/7/21.
//

import XCTest
import CoreLocation
import MapKit

@testable import BabckBaseTest

class BabckBaseTestTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCities() {
        let viewModel = CityViewModel()
        viewModel.fetchCities()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(viewModel.allCities)
            XCTAssertNotNil(viewModel.city(at: 0))
            viewModel.searchCities(with: "IN")
            XCTAssertEqual(viewModel.cities?.value[0].country, "IN")
            viewModel.searchCities(with: "Go")
            XCTAssertTrue(((viewModel.cities?.value[0].name.hasPrefix("Go")) != nil))
            viewModel.searchCities(with: "122")
            XCTAssertTrue(viewModel.cities?.value.count == 0)
            viewModel.searchCities(with: "")
            XCTAssertTrue(viewModel.cities?.value.count == viewModel.allCities?.count)
        }
        
    }
    
    func testMap() {
        
        let city = City(country: "XYZ", name: "CCC", id: 1234, coord: Coord(lon: 12.3333, lat: 14.222))
        let viewmodel = MapDetailViewModel(with: city)
        XCTAssertNotNil(viewmodel.mapPin())
        XCTAssertNotNil(viewmodel.city)
        XCTAssertNotNil(viewmodel.region)
        
        let art = Artwork(title: "asfdsa", coordinate: CLLocationCoordinate2D(latitude: 111, longitude: 222) )
        XCTAssertNotNil(art)
    }
    
    func testCityModel() {
        let city = City(country: "XYZ", name: "CCC", id: 1234, coord: Coord(lon: 12.3333, lat: 14.222))
        XCTAssertEqual(city.title, "CCC, XYZ")
        XCTAssertNotEqual(city.title, "XYZ, CCC")
        XCTAssertNotEqual(city.subTitle, "lat: 12.3333, lon: 14.222")
        XCTAssertEqual(city.subTitle, "lat: 14.222, lon: 12.3333")
        XCTAssertEqual(city.location.coordinate.latitude, 14.222)
        XCTAssertEqual(city.country, "XYZ")
        XCTAssertEqual(city.name, "CCC")
        XCTAssertEqual(city.id, 1234)
        XCTAssertEqual(city.coord.lat, 14.222)
        XCTAssertEqual(city.coord.lon, 12.3333)
        XCTAssertEqual(city.location.coordinate.latitude, 14.222)

    }
    
    func testJsonService() {
        JsonService.fetch(from: "cities") { (result: Envelope<[City]>) in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data)
            default: break
            }
        }
        JsonService.fetch(from: "unknown") { (result: Envelope<[City]>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error)
            default: break
            }
        }
        
        JsonService.fetch(from: "cities_NoData") { (result: Envelope<[City]>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, AppError.fileDataError)
            default: break
            }
        }
        JsonService.fetch(from: "cities_Error") { (result: Envelope<[City]>) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error, AppError.jsonParsingFailed)
            default: break
            }
        }
    }

}

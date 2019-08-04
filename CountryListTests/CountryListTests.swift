//
//  CountryListTests.swift
//  CountryListTests
//
//  Created by Andrew Konovalskiy on 7/28/19.
//  Copyright © 2019 Andrew Konovalskiy. All rights reserved.
//

import XCTest
@testable import CountryList

final class CountryListTests: XCTestCase {
    
    private var controller: ListViewController!

    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController

        controller.loadViewIfNeeded()
    }
    
    func testIsConfirmToDataSourceAndDelegate() {
        XCTAssertNotNil(controller as UITableViewDataSource)
        XCTAssertNotNil(controller as UITableViewDelegate)
    }

    func testCountryfetching() {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "json") else {
            XCTFail("Can't find file from this url")
            return
        }
        
        guard let data = try? Data(contentsOf: url) else {
            XCTFail("Can't init Data from url")
            return
        }
        XCTAssertNotNil(data)
        
        let decoder = JSONDecoder()
        guard let countryData = try? decoder.decode([Country].self, from: data) else {
            XCTFail("Can't decode this Data")
            return
        }
        XCTAssertNotNil(countryData)
    }

}

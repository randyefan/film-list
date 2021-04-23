//
//  FilmViewModelTest.swift
//  FilmListTests
//
//  Created by Randy Efan Jayaputra on 23/04/21.
//

import XCTest
@testable import film_list

class FilmViewModelTest: XCTestCase {
    
    private var sut: FilmViewModel?
    
    override class func setUp() {
        super.setUp()
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testInit() {
        let filmMock = FilmMock()
        sut = FilmViewModel(film: filmMock)
        guard let sut = sut else {
            XCTFail("cannot instance class")
            return
        }
        
        XCTAssertEqual(sut.title, filmMock.title)
        XCTAssertEqual(sut.releaseDate, filmMock.releaseYear)
        XCTAssertEqual(sut.director, filmMock.director)
        XCTAssertEqual(sut.description, filmMock.descriptionLabel)
    }
}

//
//  FilmTableViewCellTest.swift
//  FilmListTests
//
//  Created by Randy Efan Jayaputra on 23/04/21.
//

import XCTest
@testable import film_list

class FilmTableViewCellTest: XCTestCase {
    private var sut: FilmTableViewCell?

    override func setUp() {
        super.setUp()
        sut = Bundle.main.loadNibNamed("FilmTableViewCell", owner: self, options: nil)?.first as? FilmTableViewCell
    }
    
    override class func tearDown() {
        super.tearDown()
    }
    
    func testViewModel() {
        XCTAssertNotNil(sut)
        guard let sut = sut else {
            XCTFail("Expected sut not nil")
            return
        }
        
        let mock = FilmMock()
        sut.viewModel = FilmViewModel(film: mock)
        XCTAssertEqual(sut.titleLabel.text, mock.title)
        XCTAssertEqual(sut.descriptionLabel.text, mock.descriptionLabel)
        XCTAssertEqual(sut.releaseLabel.text, String(mock.releaseYear))
        XCTAssertEqual(sut.directorLabel.text, mock.director)
    }
}

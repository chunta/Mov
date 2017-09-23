//
//  MovieSearchTests.swift
//  MovieSearchTests
//
//  Created by ChunTa Chen on 9/19/17.
//  Copyright © 2017 ChunTa Chen. All rights reserved.
//

import XCTest
@testable import MovieSearch

class MovieSearchTests: XCTestCase
{
    
    override func setUp()
    {
        super.setUp()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    func testPageEmptyResult()
    {
        let expectationEmpty = expectation(description: "empty result")
        MovieModel.queryPage(page: 0) { (results:Array<MovieNail>) in
            XCTAssertNotNil(results)
            XCTAssertTrue(results.count==0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPageEmptyResultEx()
    {
        let expectationEmpty = expectation(description: "empty result")
        MovieModel.queryPage(page: -1) { (results:Array<MovieNail>) in
            XCTAssertNotNil(results)
            XCTAssertTrue(results.count==0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPageResult()
    {
        let expectationEmpty = expectation(description: "has results")
        MovieModel.queryPage(page: 1) { (results:Array<MovieNail>) in
            XCTAssertNotNil(results)
            XCTAssertTrue(results.count>0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDetailEmptyResult()
    {
        let expectationEmpty = expectation(description: "empty results")
        MovieModel.queryMovieDetail(id: "0") { (detail:MovieDetail) in
            XCTAssertNotNil(detail)
            XCTAssertTrue(detail.backdrop_path.characters.count==0)
            XCTAssertTrue(detail.title.characters.count==0)
            XCTAssertTrue(detail.popularity==0)
            XCTAssertTrue(detail.genres.count==0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDetailEmptyResultEx()
    {
        let expectationEmpty = expectation(description: "empty results")
        MovieModel.queryMovieDetail(id: "-1") { (detail:MovieDetail) in
            XCTAssertNotNil(detail)
            XCTAssertTrue(detail.backdrop_path.characters.count==0)
            XCTAssertTrue(detail.title.characters.count==0)
            XCTAssertTrue(detail.popularity==0)
            XCTAssertTrue(detail.genres.count==0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDetailResult01()
    {
        let expectationEmpty = expectation(description: "empty results")
        MovieModel.queryMovieDetail(id: "328111") { (detail:MovieDetail) in
            XCTAssertNotNil(detail)
            XCTAssertTrue(detail.backdrop_path.characters.count>=0)
            XCTAssertTrue(detail.title.characters.count>0)
            XCTAssertTrue(detail.popularity>=0)
            XCTAssertTrue(detail.genres.count>=0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testDetailResult02()
    {
        let expectationEmpty = expectation(description: "empty results")
        MovieModel.queryMovieDetail(id: "456538") { (detail:MovieDetail) in
            XCTAssertNotNil(detail)
            XCTAssertTrue(detail.backdrop_path.characters.count>=0)
            XCTAssertTrue(detail.title.characters.count>0)
            XCTAssertTrue(detail.popularity>=0)
            XCTAssertTrue(detail.genres.count>=0)
            expectationEmpty.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testPerformanceExample()
    {
        
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

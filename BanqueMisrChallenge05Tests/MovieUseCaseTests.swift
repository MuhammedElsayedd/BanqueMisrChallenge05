//
//  MovieUseCaseTests.swift
//  BanqueMisrChallenge05Tests
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import XCTest
@testable import BanqueMisrChallenge05

class MovieUseCaseTests: XCTestCase {
    var movieUseCase: MovieUseCase!
    var networkManager: NetworkManagerMock!

    override func setUp() {
        super.setUp()
        networkManager = NetworkManagerMock()
        movieUseCase = MovieUseCaseImpl(networkManager: networkManager)
    }

    override func tearDown() {
        movieUseCase = nil
        networkManager = nil
        super.tearDown()
    }

    func testFetchNowPlayingMoviesSuccess() {
        let expectation = XCTestExpectation(description: "Fetch now playing movies")
        
        movieUseCase.fetchNowPlayingMovies { result in
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies)
                XCTAssertEqual(movies.count, 10) // Assuming 10 movies for test
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success, got error: \(error)")
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchNowPlayingMoviesFailure() {
        networkManager.shouldReturnError = true
        
        let expectation = XCTestExpectation(description: "Fetch now playing movies with error")
        
        movieUseCase.fetchNowPlayingMovies { result in
            switch result {
            case .success:
                XCTFail("Expected error, got success")
            case .failure(let error):
                XCTAssertEqual(error as? NetworkError, NetworkError.noData)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}

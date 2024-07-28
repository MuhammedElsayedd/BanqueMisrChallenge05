//
//  ListMoviesViewModelTests.swift
//  BanqueMisrChallenge05Tests
//
//  Created by Muhammed Elsayed on 28/07/2024.
//

import XCTest
@testable import BanqueMisrChallenge05

class ListMoviesViewModelTests: XCTestCase {

    var viewModel: ListMoviesViewModel!
    var mockUseCase: MovieUseCaseMock!

    override func setUp() {
        super.setUp()
        mockUseCase = MovieUseCaseMock()
        viewModel = ListMoviesViewModel(movieUseCase: mockUseCase)
    }

    override func tearDown() {
        viewModel = nil
        mockUseCase = nil
        super.tearDown()
    }

    func testFetchNowPlayingMovies_Success() {
        viewModel.category = .nowPlaying
        mockUseCase.shouldReturnError = false

        let expectation = self.expectation(description: "Movies fetched successfully")

        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.count, 10)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchNowPlayingMovies_Failure() {
        viewModel.category = .nowPlaying
        mockUseCase.shouldReturnError = true

        let expectation = self.expectation(description: "Movies fetch failed")

        viewModel.onError = { error in
            XCTAssertEqual(error, NetworkError.noData.localizedDescription)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchPopularMovies_Success() {
        viewModel.category = .popular
        mockUseCase.shouldReturnError = false

        let expectation = self.expectation(description: "Movies fetched successfully")

        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.count, 10)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchPopularMovies_Failure() {
        viewModel.category = .popular
        mockUseCase.shouldReturnError = true

        let expectation = self.expectation(description: "Movies fetch failed")

        viewModel.onError = { error in
            XCTAssertEqual(error, NetworkError.noData.localizedDescription)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchUpcomingMovies_Success() {
        viewModel.category = .upcoming
        mockUseCase.shouldReturnError = false

        let expectation = self.expectation(description: "Movies fetched successfully")

        viewModel.onMoviesFetched = {
            XCTAssertEqual(self.viewModel.movies.count, 10)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchUpcomingMovies_Failure() {
        viewModel.category = .upcoming
        mockUseCase.shouldReturnError = true

        let expectation = self.expectation(description: "Movies fetch failed")

        viewModel.onError = { error in
            XCTAssertEqual(error, NetworkError.noData.localizedDescription)
            expectation.fulfill()
        }

        viewModel.fetchMovies()

        waitForExpectations(timeout: 5, handler: nil)
    }
}

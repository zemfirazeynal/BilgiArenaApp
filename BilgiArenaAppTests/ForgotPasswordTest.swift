//
//  ForgotPasswordTest.swift
//  BilgiArenaAppTests
//
//  Created by Zemfira Asadzade on 16.07.25.
//

import XCTest
@testable import BilgiArenaApp

final class ForgotPasswordTest: XCTestCase {
    
    var mockManager: MockManagerUseCase!
    var sut: ForgotPasswordManagerUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockManager = MockManager()
        sut = ForgotPasswordMockManager(manager: mockManager)
    }
    
    func testSendOtp_success() {
            sut.sendOtp(email: "test@mail.com") { success, error in
                XCTAssertTrue(success)
                XCTAssertNil(error)
            }
        }

        func testVerifyOtp_success() {
            sut.verifyOtp(email: "test@mail.com", otp: "123456") { jwt, error in
                XCTAssertNotNil(jwt)
                XCTAssertNil(error)
            }
        }

        func testResetPassword_success() {
            sut.resetPassword(password: "123456", token: "token") { success, error in
                XCTAssertTrue(success)
                XCTAssertNil(error)
            }
        }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

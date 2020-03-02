//
//  charith_cobsccomp182p_006UITests.swift
//  charith-cobsccomp182p-006UITests
//
//  Created by Charith Lakshitha on 2/12/20.
//  Copyright © 2020 Charith Lakshitha. All rights reserved.
//

import XCTest

class charith_cobsccomp182p_006UITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testUserAuthentication(){
        
        
        let app = XCUIApplication()
        app.tabBars.buttons["Profile"].tap()
        app.buttons["Log In"].tap()

        
        _ = XCUIApplication()
        let firstNameTextField = app.textFields["First Name"]
        firstNameTextField.tap()
        firstNameTextField.tap()
        
        let signUpButton = app.buttons["Sign Up"]
        signUpButton.tap()
        app.textFields["Last Name"].tap()
        
        let emailTextField = app.textFields["Email"]
        emailTextField.tap()
        emailTextField.tap()
        
        let phoneNumberTextField = app.textFields["Phone Number"]
        phoneNumberTextField.tap()
        phoneNumberTextField.tap()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        
        let confirmPasswordSecureTextField = app.secureTextFields["Confirm Password"]
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        signUpButton.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        passwordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        confirmPasswordSecureTextField.tap()
        signUpButton.tap()        

    }

}

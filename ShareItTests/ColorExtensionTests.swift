//
//  ColorExtensionTests.swift
//  ShareItTests
//
//  Created by zakaru on 08/04/2021.
//

import XCTest

class ColorExtensionTests: XCTestCase {

	func testHexDescription() {
		let white = UIColor.white

		let whiteHexCode = white.hexDescription()

		XCTAssertTrue(whiteHexCode == "Color not RGB.")
	}

	func testInitHexColor() {
		let hex = "00FFFF"

		let color = UIColor(hex: hex)

		let initializedColorDes = color.hexDescription()

		XCTAssertTrue(initializedColorDes.lowercased() == hex.lowercased())

		// test init with empty code
		let defaultColor = UIColor(hex: nil)

		XCTAssertTrue(defaultColor.hexDescription() == "000000")

		// test init with # prefix
		let newColor = UIColor(hex: "#" + hex)

		XCTAssertTrue(newColor.hexDescription() == hex.lowercased())

		// test init with 3 hex digits
		let threeHexColor = UIColor(hex: "FFF")

		XCTAssertTrue(threeHexColor.hexDescription() == "ffffff")

		// test init with css color
		let aliceBlue = UIColor(hex: "ALICEBLUE")

		XCTAssertTrue(aliceBlue.hexDescription().uppercased() == "F0F8FF")

		// test init with
		let transparent = UIColor(hex: "TRANSPARENT")

		XCTAssertTrue(transparent.hexDescription() == "000000")
	}

}

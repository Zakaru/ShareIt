//
//  BaseViewTests.swift
//  ShareItTests
//
//  Created by zakaru on 07/04/2021.
//

import XCTest
import CoreGraphics

@testable import ShareIt

class BaseViewTests: XCTestCase {

	var baseView = BaseView(frame: CGRect(x: 0, y: 0, width: 100, height: 200))

	override func setUp() {
		super.setUp()
	}

	func testAddShadow() {
		// validate adding default shadow layer

		baseView.addShadowLayer()

		XCTAssertNotNil(baseView.shadowLayer)

		baseView.removeShadowLayer()

		XCTAssertNil(baseView.shadowLayer)

		// validate adding custom shadow layer
		
		baseView.addShadowLayer(background: .red, shadowWidth: 2, shadowHeight: 3)

		let addedShadowLayer = baseView.shadowLayer

		XCTAssertNotNil(addedShadowLayer)

		let shadowBgColor = UIColor(cgColor: addedShadowLayer!.fillColor!)
		let shadowWidth = addedShadowLayer!.shadowOffset.width
		let shadowHeight = addedShadowLayer!.shadowOffset.height

		// converting color to have a proper validation
		XCTAssertEqual(shadowBgColor.hexDescription(true), UIColor.red.hexDescription(true))
		XCTAssertEqual(shadowWidth, 2)
		XCTAssertEqual(shadowHeight, 3)

		// validate adding a new shadow layer for a view already had an existing layer
		baseView.addShadowLayer(background: .yellow, shadowWidth: 10, shadowHeight: 10)

		let newAddedLayer = baseView.shadowLayer
		XCTAssertEqual(newAddedLayer, addedShadowLayer)
	}

	func testTouchAnimation() {
		baseView.touchesBegan(Set(), with: nil)

		let scaleFactor: CGFloat = 0.95
		let expectedTransform: CGAffineTransform = CGAffineTransform(scaleX: scaleFactor, y: scaleFactor)

		XCTAssertEqual(baseView.transform, expectedTransform)

		baseView.touchesEnded(Set(), with: nil)
		XCTAssertEqual(baseView.transform, .identity)

		baseView.touchesBegan(Set(), with: nil)
		XCTAssertEqual(baseView.transform, expectedTransform)

		baseView.touchesCancelled(Set(), with: nil)
		XCTAssertEqual(baseView.transform, .identity)
	}

}

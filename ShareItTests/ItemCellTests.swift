//
//  ItemCellTests.swift
//  ShareItTests
//
//  Created by zakaru on 05/04/2021.
//

import XCTest
@testable import ShareIt

class ImageContainerViewTests: XCTestCase {

	func testInitImageContainerView() {
		// init with frame
		let expectedFrame = CGRect(x: 0, y: 0, width: 200, height: 200)
		let framedContainer = ImageContainerView(frame: expectedFrame)

		XCTAssertTrue(framedContainer.frame == expectedFrame)
	}

}

class ItemCellTests: XCTestCase {

	var tableView: UITableView!

	let testMockId = ItemCell.name + "test"
	let maxImageLength = 4

	override func setUp() {
		super.setUp()

		tableView = UITableView(frame: .zero)
		tableView.register(UINib(nibName: ItemCell.name, bundle: nil),
						   forCellReuseIdentifier: testMockId)
	}

	override func tearDown() {
		super.tearDown()

		tableView = nil
	}

	@discardableResult
	func testLoadImages(_ imgs: [UIImage], forCell cell: UITableViewCell? = nil) -> UITableViewCell {
		let newCell: ItemCell =
			cell as? ItemCell ??
			tableView.dequeueReusableCell(withIdentifier: testMockId) as! ItemCell

		//
		// when this cell is reused the number of subviews might not be nil
		//
		// XCTAssertTrue(newCell.imageContainerView.subviews.count == 0)
		//

		newCell.loadImages(imgs)

		let firstView = newCell.imageContainerView.subviews.first as? ImageContainerView

		XCTAssertTrue(newCell.imageContainerView.subviews.count == 1)

		XCTAssertTrue(firstView != nil)

		let imgViews: [BaseImageView] = UIView.getSubviewsOf(view: firstView!)

		if imgs.count > maxImageLength {
			XCTAssertTrue(imgViews.count == maxImageLength)
		} else {
			XCTAssertTrue(imgViews.count == imgs.count)
		}

		return newCell
	}

	func testLoadImages() {
		// test load 1 image
		var imgs = [UIImage]()
		imgs.append(UIImage(named: String(1))!)

		testLoadImages(imgs)


		// test load 2 images
		imgs = [UIImage]()
		for i in 1...2 {
			imgs.append(UIImage(named: String(i))!)
		}

		testLoadImages(imgs)

		// test load 3 images
		imgs = [UIImage]()
		for i in 1...3 {
			imgs.append(UIImage(named: String(i))!)
		}

		testLoadImages(imgs)


		// test load 4 images
		imgs = [UIImage]()
		for i in 1...4 {
			imgs.append(UIImage(named: String(i))!)
		}

		testLoadImages(imgs)


		// test load > 4 images
		imgs = [UIImage]()
		for i in 1...6 {
			imgs.append(UIImage(named: String(i))!)
		}

		let loadedCell = testLoadImages(imgs)

		// try to reuse this cell
		imgs = [UIImage]()
		for i in 1...2 {
			imgs.append(UIImage(named: String(i))!)
		}

		testLoadImages(imgs, forCell: loadedCell)
	}
}

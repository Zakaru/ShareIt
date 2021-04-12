//
//  ListBasedViewModelTests.swift
//  ShareItTests
//
//  Created by zakaru on 01/04/2021.
//

import XCTest
@testable import ShareIt

class ListBasedViewModelTests: XCTestCase {

	var listBasedVM: ListBasedViewModel!
	var modelArray = randomBooks()

	override func setUp() {
		super.setUp()

		listBasedVM = HomeViewModel(modelArray: modelArray)
	}

	func testNumberOfItems() {
		let originalItemsCount = modelArray.count
		let itemsCount = listBasedVM.numberOfItems()

		XCTAssertTrue(originalItemsCount == itemsCount)
	}

	func testGetItemAtIdx() {
		// test getting first item
		let originalFirstItem = modelArray.first!
		let actualFirstItem = listBasedVM.itemAtIndex(0)

		XCTAssertTrue(actualFirstItem != nil)
		XCTAssertTrue(originalFirstItem.id == actualFirstItem!.id)

		// test getting item in bounds
		let idx = modelArray.count - 1
		let originalItemAtIdx = modelArray[idx]
		let actualItemAtIdx = listBasedVM.itemAtIndex(idx)

		XCTAssertTrue(originalItemAtIdx.id == actualItemAtIdx!.id)

		// test getting item out bounds
		let outBoundsIdx = modelArray.count
		let actualOutBoundsItemAtIdx = listBasedVM.itemAtIndex(outBoundsIdx)

		XCTAssertNil(actualOutBoundsItemAtIdx)


		let outOfBoundIdx = 999
		let actualItemAtOutBoundShouldBeNil = listBasedVM.itemAtIndex(outOfBoundIdx)

		XCTAssertTrue(actualItemAtOutBoundShouldBeNil == nil)
	}

	func testGetImagesForItemAtIdx() {
		// test item count
		let originalImgUrls = modelArray.first?.imageUrls

		XCTAssertNotNil(originalImgUrls)

		let originalMappedImages = originalImgUrls!.compactMap{ UIImage(named: $0) }

		let actualImagesCount = listBasedVM.imagesOfItemsAt(0).count

		XCTAssertTrue(originalMappedImages.count == actualImagesCount)

		// test item with no image
		let newBook = Book(id: UUID(),
						   name: "Book with no image",
						   description: "This book contains no image",
						   publishedDate: Date(),
						   uploadedUser: Uploader(username: "Test user", fullname: "Test user fullname"),
						   imageUrls: nil)
	
		listBasedVM.modelArray = [newBook]

		var newImgCount = listBasedVM.imagesOfItemsAt(0).count

		XCTAssertTrue(newImgCount == 0)

//		// test item with image not found
		let imgs = ["1", "2", "21"]

		let aNewerBook = Book(id: UUID(),
							  name: "Book contains an empty image",
							  description: "This book contains an empty image",
							  publishedDate: Date(),
							  uploadedUser: Uploader(username: "Test user", fullname: "Test user fullname"),
							  imageUrls: imgs)

		listBasedVM.modelArray = [aNewerBook]

		newImgCount = listBasedVM.imagesOfItemsAt(0).count

		XCTAssertTrue(newImgCount == 2)
	}

	func testFetchData() {
		listBasedVM = HeadlineViewModel(modelArray: [Item]())

		listBasedVM.fetchData()

		XCTAssertTrue(listBasedVM.modelArray.count > 0)
	}

}

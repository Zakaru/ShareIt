//
//  NSObjectTests.swift
//  ShareItTests
//
//  Created by zakaru on 09/04/2021.
//

import XCTest

@testable import ShareIt

class BookTests: XCTestCase {

	func testCompareTwoBooks() {
		// test Uploader with Equatable conformation
		let uploaderId = UUID()
		let theUploader = Uploader(id: uploaderId, username: "The uploader",
								   fullname: "Name", avatarUrl: nil)
		let sameUploaderWithDifferentName = Uploader(id: uploaderId,
													 username: "The new wine",
													 fullname: "I'm the previous uploader",
													 avatarUrl: "1")

		XCTAssertTrue(theUploader == sameUploaderWithDifferentName)


		// test Book with Equatable conformation
		let bookId = UUID()

		let firstBook = Book(id: bookId,
							  name: "first book",
							  description: "Detail of the first book",
							  publishedDate: Date(),
							  uploadedUser: theUploader,
							  imageUrls: nil)

		let secondBook = Book(id: bookId,
							  name: "Second book",
							  description: "Detail of the second book",
							  publishedDate: Date(),
							  uploadedUser: theUploader,
							  imageUrls: nil)

		XCTAssertTrue(firstBook == secondBook)
	}
}

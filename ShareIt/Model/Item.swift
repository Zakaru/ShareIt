//
//  Item.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import Foundation

// MARK: - Interfaces

protocol Item {
	var id: UUID { get }
	var name: String { get set }
	var description: String { get set }
	var publishedDate: Date { get set }
	var uploadedUser: User { get set }
	var imageUrls: [String]? { get set }
}

protocol User {
	var id: UUID { get }
	var username: String { get set }
	var fullname: String { get set }
	var avatarUrl: String? { get set }
}

// MARK: - Implementation model

struct Book: Item, Equatable {

	var id: UUID = UUID()

	var name: String

	var description: String

	var publishedDate: Date

	var uploadedUser: User

	var imageUrls: [String]?

	static func == (lhs: Book, rhs: Book) -> Bool {
		return lhs.id == rhs.id
	}

}

struct Uploader: User, Equatable {

	var id: UUID = UUID()

	var username: String

	var fullname: String

	var avatarUrl: String?

	static func == (lhs: Uploader, rhs: Uploader) -> Bool {
		return lhs.id == rhs.id
	}
	
}

struct Quote: Codable {
	var author: String
	var quote: String
}

// MARK: - Demo data

let uploader = Uploader(username: "Avatar",
						fullname: "Dummy Johny",
						avatarUrl: "7")

let users = [Uploader(username: "User X",
					  fullname: "Dummy Johny",
					  avatarUrl: "1"),
			 Uploader(username: "Shakira Dummy",
					  fullname: "Dummy Johny",
					  avatarUrl: "2"),
			 Uploader(username: "Simmy",
					  fullname: "Dummy Johny",
					  avatarUrl: "3"),
			 Uploader(username: "Dominic",
					  fullname: "Dummy Johny",
					  avatarUrl: "4")]

let dummyBooks = [
	Book(name: "First", description: "", publishedDate: Date(), uploadedUser: uploader, imageUrls: ["1", "2"]),
	Book(name: "Random", description: "", publishedDate: Date(), uploadedUser: uploader, imageUrls: ["2"]),
	Book(name: "First", description: "", publishedDate: Date(), uploadedUser: uploader, imageUrls:  ["4", "2", "3"]),
	Book(name: "First", description: "", publishedDate: Date(), uploadedUser: uploader, imageUrls: ["4", "2"])]

func rawImageList() -> [String] {
	let arr2 = Array(0..<29)
	return arr2.map({String($0 + 1)})
}

func randomBooks() -> [Item] {
	var imgList: [String] = rawImageList()

	var books = [Book]()

	var quotes = queryQuotes()

	for _ in 0..<7 {
		quotes.shuffle()

		let des = quotes.first
		quotes.removeFirst()

		let imgCount = Int.random(in: 0...8)
		let covers = getRandomImages(count: imgCount, imgList: &imgList)
		Log.d(tag: "Cover", msg: "\(covers)")

		let uploadedUser = Uploader(username: des?.author ?? "Anonymous",
									fullname: des?.author ?? "Anonymous",
									avatarUrl: covers.first ?? "13")

		let book = Book(name: des?.author ?? "",
						description: des?.quote ?? "",
						publishedDate: Date(),
						uploadedUser: uploadedUser,
						imageUrls: covers.count > 0 ? covers : nil)

		books.append(book)
	}

	return books
}

func getRandomImages(count: Int, imgList: inout [String]) -> [String] {
	var urls = [String]()
	for _ in 0..<count {
		imgList.shuffle()
		if let name = imgList.first {
			imgList.remove(at: 0)
			urls.append(name)
		}
	}

	return urls
}

func queryQuotes() -> [Quote] {
	guard let path = Bundle.main.path(forResource: "quotes", ofType: "json") else {
		return []
	}

	do {
		let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
		let quotes = try! JSONDecoder().decode([Quote].self, from: data)

		return quotes
	} catch {
		return []
	}
}

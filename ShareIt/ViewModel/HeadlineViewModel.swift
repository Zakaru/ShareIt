//
//  HeadlineViewModel.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import UIKit

class HeadlineViewModel: ListBasedViewModel {

	var modelArray: [Item] = [Item]()

	init(modelArray: [Item]) {
		self.modelArray = modelArray
	}

	private func headlineItems() -> [Item] {
		let names = ["Bingo", "Tree", "Leaf", "Transcend"]
		let desc = ["Time", "Tree bing", "Leaf", "Transcend kkekk"]
		var books = [Book]()

		for i in 0...6 {
			let name = names.shuffled().first! + " " + names.shuffled().last!
			let des = desc.shuffled().first! + " " + desc.shuffled().last!
			let book = Book(name: name,
							description: des,
							publishedDate: Date(),
							uploadedUser: uploader,
							imageUrls: ["h" + String(i+1)])
			books.append(book)
		}

		return books
	}
}

// MARK: - Public APIs

extension HeadlineViewModel {

	func fetchData() {
		modelArray = headlineItems()
	}

}

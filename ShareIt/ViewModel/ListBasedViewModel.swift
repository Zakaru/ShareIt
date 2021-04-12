//
//  ListViewModel.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import UIKit

protocol ListBasedViewModel {

	var modelArray: [Item] { get set }

	// MARK: Base methods
	
	func numberOfItems() -> Int
	func itemAtIndex(_ index: Int) -> Item?
	func imagesOfItemsAt(_ index: Int) -> [UIImage]
	func fetchData()

}

// MARK: - Default methods

extension ListBasedViewModel {

	func numberOfItems() -> Int {
		return modelArray.count
	}

	func itemAtIndex(_ index: Int) -> Item? {
		guard modelArray.indices.contains(index) else { return nil }
		return modelArray[index]
	}

	func imagesOfItemsAt(_ index: Int) -> [UIImage] {
		guard let urls = modelArray[index].imageUrls else {
			return [UIImage]()
		}

		return urls.map({ (UIImage(named: $0) ?? nil) }).compactMap{ $0 }
	}

}

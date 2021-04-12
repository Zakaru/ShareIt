//
//  HomeViewModel.swift
//  ShareIt
//
//  Created by zakaru on 23/03/2021.
//

import Foundation

class HomeViewModel: ListBasedViewModel	{

	var modelArray: [Item] = [Item]()

	init(modelArray: [Item]) {
		self.modelArray = modelArray
	}

}

extension HomeViewModel {

	func fetchData() {
		modelArray = randomBooks()
	}

}

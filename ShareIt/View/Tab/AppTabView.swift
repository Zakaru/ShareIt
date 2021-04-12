//
//  AppTabView.swift
//  ShareIt
//
//  Created by zakaru on 02/04/2021.
//

import UIKit

class AppTabView: BaseView {

	struct TabItem {
		var title: String
		var image: UIImage
	}

	public var tabImages = [UIImage]() {
		willSet {
			if !tabImages.isEmpty {
				fatalError("tab images already set")
			}
		}
		didSet {
			addTabImages()
			layoutTabViews()
		}
	}

	public var tabTitles = [String]() {
		willSet {
			if !tabTitles.isEmpty {
				fatalError("tab images already set")
			}
		}
		didSet {
			addTabTitles()
			layoutTabViews()
		}
	}

	private var tabItems = [TabItem]()
	private var tabViews = [BaseView]()

	// MARK: Overriding methods

	override func initialize() {

	}

	// MARK: Public methods

	// MARK: Private methods

	private func addTabImages() {
		for i in 0..<tabImages.count {
			let img = tabImages[i]

			if tabItems.indices.contains(i) {
				var currentItem = tabItems[i]
				currentItem.image = img
			} else {
				let tabItem = TabItem(title: "", image: img)
				addTabItem(tabItem)
			}
		}
	}

	private func addTabTitles() {
		for i in 0..<tabTitles.count {
			let title = tabTitles[i]

			if tabItems.indices.contains(i) {
				var currentItem = tabItems[i]
				currentItem.title = title
			} else {
				let tabItem = TabItem(title: title, image: UIImage())
				addTabItem(tabItem)
			}
		}
	}

	private func addTabItem(_ item: TabItem) {
		let tabView = BaseView(frame: .zero)
		tabView.translatesAutoresizingMaskIntoConstraints = false

		let button = UIButton(frame: .zero)
		button.translatesAutoresizingMaskIntoConstraints = false

		let hStack = UIStackView(frame: .zero)
		
		let imgView = UIImageView(frame: .zero)
		imgView.image = item.image

		let label = UILabel(frame: .zero)
		label.text = item.title

		hStack.addArrangedSubview(imgView)
		hStack.addArrangedSubview(label)

		tabView.addSubViewAndMatchedBounds(button)
		tabView.addSubViewAndMatchedBounds(hStack)

		addSubview(tabView)
		tabViews.append(tabView)
	}

	private func layoutTabViews() {

	}

}


//
//  AppTabBarController.swift
//  ShareIt
//
//  Created by zakaru on 02/04/2021.
//

import UIKit

class AppTabBarController: BaseViewController {

	public var selectedIndex: Int = 0 {
		didSet {

		}
	}

	public let viewControllers: [UIViewController]

	init(controllers: [UIViewController]) {
		self.viewControllers = controllers

		super.init()
	}

	required init?(coder: NSCoder) {
		self.viewControllers = [UIViewController]()

		super.init(coder: coder)
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
	}

	// MARK: Private methods

	private func setupView() {

	}

	private func updateSelectedIndex(_ index: Int) {

	}


}

//
//  MainTabBarController.swift
//  ShareIt
//
//  Created by zakaru on 25/03/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

		setupTabBar()
    }

	fileprivate func setupTabBar() {
		UITabBar.appearance().tintColor = AppColor.mainColor
	}

}

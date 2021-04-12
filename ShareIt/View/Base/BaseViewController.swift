//
//  BaseViewController.swift
//  ShareIt
//
//  Created by zakaru on 19/03/2021.
//

import UIKit

// MARK: - Base screen presenter

fileprivate protocol ListBasedPresenter {
	var viewModel: ListBasedViewModel! { get set }
}

fileprivate protocol ItemBasedPresenter {
	var viewModel: ItemBasedViewModel { get set }
}

// MARK: - Base view controller

class BaseViewController: UIViewController {

	deinit {
		Log.d(tag: self.name, msg: "deinit")
	}

	init() {
		let name = String(describing: type(of: self))
		super.init(nibName: name, bundle: nil)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

// MARK: - ListBasedViewController

class ListBasedViewController: BaseViewController,
							   ListBasedPresenter {

	internal var viewModel: ListBasedViewModel!

	internal var lastContentOffset: CGFloat = 0

	internal var autoAdjustNavigationBarVisibility: Bool = false

	init(viewModel: ListBasedViewModel) {
		super.init()
		self.viewModel = viewModel
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	fileprivate func adjustNavigationBarVisibility(_ scrollView: UIScrollView) {
		if lastContentOffset < scrollView.contentOffset.y {
			UIView.animate(withDuration: 0.3) {
				self.navigationController?.setNavigationBarHidden(true, animated: false)
			}

		} else if lastContentOffset > scrollView.contentOffset.y {
			UIView.animate(withDuration: 0.3) {
				self.navigationController?.setNavigationBarHidden(false, animated: false)
			}

		} else {

		}
	}

}

extension ListBasedViewController: UIScrollViewDelegate {

	func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
		lastContentOffset = scrollView.contentOffset.y
	}

	func scrollViewDidScroll(_ scrollView: UIScrollView) {

	}

	func scrollViewWillEndDragging(_ scrollView: UIScrollView,
								   withVelocity velocity: CGPoint,
								   targetContentOffset: UnsafeMutablePointer<CGPoint>) {
		if autoAdjustNavigationBarVisibility {
			adjustNavigationBarVisibility(scrollView)
		}
	}

	func scrollViewDidEndDragging(_ scrollView: UIScrollView,
								  willDecelerate decelerate: Bool) {
	}

}

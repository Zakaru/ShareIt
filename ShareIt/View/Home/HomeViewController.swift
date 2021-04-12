//
//  ViewController.swift
//  ShareIt
//
//  Created by zakaru on 18/03/2021.
//

import UIKit

class HomeViewController: ListBasedViewController {

	@IBOutlet weak var tableView: UITableView!

	private lazy var headlineViewController =
		HeadlineViewController(viewModel: HeadlineViewModel(modelArray: [Item]()))

	private lazy var homeViewModel = HomeViewModel(modelArray: [Item]())

	// MARK: Overriding props

	override internal var viewModel: ListBasedViewModel! {
		get {
			return homeViewModel
		}
		set {
			if let newViewModel = newValue as? HomeViewModel {
				homeViewModel = newViewModel
			}
		}
	}

	override init(viewModel: ListBasedViewModel) {
		super.init(viewModel: viewModel)
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: Overriding methods

	override func viewDidLoad() {
		super.viewDidLoad()

		setupView()
		fetchData()
	}

	fileprivate func setupView() {
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.prefersLargeTitles = true
		}

		navigationItem.title = "Home"

		autoAdjustNavigationBarVisibility = false

		registerCells()
	}

	fileprivate func registerCells() {
		tableView.register(UINib(nibName: ItemCell.name, bundle: nil),
						   forCellReuseIdentifier: ItemCell.name)
	}

	fileprivate func fetchData() {
		viewModel.fetchData()
	}

}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}

	func tableView(_ tableView: UITableView,
				   numberOfRowsInSection section: Int) -> Int {
		if section == 0 {
			return 0
		}

		return viewModel.numberOfItems()
	}

	func tableView(_ tableView: UITableView,
				   heightForHeaderInSection section: Int) -> CGFloat {
		return headerHeightAt(section)
	}

	func tableView(_ tableView: UITableView,
				   viewForHeaderInSection section: Int) -> UIView? {
		return headlineViewController.view
	}

	func tableView(_ tableView: UITableView,
				   heightForRowAt indexPath: IndexPath) -> CGFloat {
		return rowHeightAt(indexPath)
	}

	func tableView(_ tableView: UITableView,
				   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if indexPath.section == 0 {
			return UITableViewCell()
		}

		return itemAt(indexPath)
	}

	func tableView(_ tableView: UITableView,
				   estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	// MARK: Support methods

	fileprivate func rowHeightAt(_ indexPath: IndexPath) -> CGFloat {
		if indexPath.section == 0 {
			return 0
		}

		return UITableView.automaticDimension
	}

	fileprivate func headerHeightAt(_ section: Int) -> CGFloat {
		if section == 0 {
			return (view.bounds.size.width - 16 * 2) * 2 / 3
		}

		return 0
	}

	fileprivate func itemAt(_ index: IndexPath) -> UITableViewCell {
		guard let item = viewModel.itemAtIndex(index.row) else {
			return UITableViewCell()
		}

		let cell =
			tableView.dequeueReusableCell(withIdentifier: ItemCell.name) as! ItemCell
		cell.userImageView.image = UIImage(named: item.uploadedUser.avatarUrl ?? "")
		cell.usernameLabel.text = item.uploadedUser.username
		cell.itemDetailTextView.text = item.description
		cell.loadImages(viewModel.imagesOfItemsAt(index.row))

		return cell
	}

}


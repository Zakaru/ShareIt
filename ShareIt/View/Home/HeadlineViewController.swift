//
//  HeadlineViewController.swift
//  ShareIt
//
//  Created by zakaru on 22/03/2021.
//

import UIKit

class HeadlineViewController: BaseViewController {

	@IBOutlet weak var headlineCollectionView: UICollectionView!

	private var viewModel: ListBasedViewModel!

	init(viewModel: HeadlineViewModel) {
		super.init()
		self.viewModel = viewModel
		self.viewModel.fetchData()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}

	// MARK: Overriding methods

	override func viewDidLoad() {
        super.viewDidLoad()

		setupView()
    }

	private func setupView() {
		headlineCollectionView.register(UINib(nibName: HeadlineCell.name, bundle: nil),
										forCellWithReuseIdentifier: HeadlineCell.name)
	}

}

extension HeadlineViewController: UICollectionViewDataSource,
								  UICollectionViewDelegate {

	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}

	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return viewModel.numberOfItems()
	}

	func collectionView(_ collectionView: UICollectionView,
						cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeadlineCell.name,
													  for: indexPath) as! HeadlineCell

		cell.imageView.image = viewModel.imagesOfItemsAt(indexPath.row).first

		return cell
	}
}

extension HeadlineViewController: UICollectionViewDelegateFlowLayout {

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						sizeForItemAt indexPath: IndexPath) -> CGSize {
		let cellHeight = view.bounds.height - 16
		let cellWidth = cellHeight * 2 / 3
		return CGSize(width: cellWidth, height: cellHeight)
	}

	func collectionView(_ collectionView: UICollectionView,
						layout collectionViewLayout: UICollectionViewLayout,
						insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
	}

}

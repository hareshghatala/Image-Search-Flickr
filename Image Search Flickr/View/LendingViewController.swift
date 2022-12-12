//
//  LendingViewController.swift
//  Image Search Flickr
//
//  Created by Haresh Ghatala on 2022/12/12.
//

import UIKit

class LendingViewController: UIViewController {
    
    @IBOutlet weak var mainSearchBar: UISearchBar!
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var searchHistoryTableView: UITableView! {
        didSet {
            searchHistoryTableView.layer.cornerRadius = 15
            searchHistoryTableView.layer.borderColor = UIColor(named: "Flickr-Blue")!.cgColor
            searchHistoryTableView.layer.borderWidth = 0.5
            searchHistoryTableView.tableFooterView = UIView()
        }
    }
    
    let viewModel = LendingViewModel()
    
    private var cellSize: Int = defaultCellWidth
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.bindImageFeedToController = { wipeData in
            self.dataBindingHandler(wipeData: wipeData)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateCellSize(columns: 2)
    }
    
    private func calculateCellSize(columns: Int = 3) {
        let columns = columnSpace * (columns + 1)
        cellSize = (Int(view.frame.width) - columns) / 2
    }
    
    private func dataBindingHandler(wipeData: Bool) {
        if wipeData {
            if mainCollectionView.visibleCells.isEmpty == false {
                mainCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .bottom, animated: true)
            }
        }
        mainCollectionView.reloadData()
    }
    
}

// MARK: - UICollectionView DataSource & Delegate methods

extension LendingViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: flickrFeedCellId, for: indexPath) as! FlickrImageCollectionViewCell
        
        cell.setupCellData(photoItem: viewModel.imageList[indexPath.item], index: indexPath.item)
        
        return cell
    }
}

extension LendingViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        /// Cell animation
        cell.alpha = 0
        let dir = ((indexPath.item % 2) == 0) ? 150 : -150
        let transform = CATransform3DTranslate(CATransform3DIdentity, CGFloat(dir), 0, 0)
        cell.layer.transform = transform
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            cell.alpha = 1
            cell.layer.transform = CATransform3DIdentity
        }, completion: nil)
        
        /// Loading next page data
        print("willDisplay \(indexPath.item) \(indexPath.row) - \(indexPath.item == viewModel.imageList.count - 5)")
        if indexPath.item == viewModel.imageList.count - 5 {
            guard let text = mainSearchBar.text, !text.isEmpty else {
                return
            }
            viewModel.fetchImages(searchText: text, offset: viewModel.searchOffset)
        }
    }
    
}

extension LendingViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize)
    }
}


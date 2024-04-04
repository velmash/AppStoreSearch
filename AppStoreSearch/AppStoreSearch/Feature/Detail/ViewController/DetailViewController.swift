//
//  DetailViewController.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit

class DetailViewController: BaseViewController<DetailView> {
    var viewModel: DetailViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contentView.preCollectionView.delegate = self
    }
    
    override func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        let input = DetailViewModel.Input()
        let output = viewModel.transform(input: input)
        
        output.appInfoPost
            .driveNext { [weak self] data in
                self?.contentView.configure(appInfo: data)
            }
            .disposed(by: bag)
        
        output.preCollectionPost
            .asObservable()
            .bind(to: contentView.preCollectionView.rx.items(cellIdentifier: PreCollectionViewCell.reuseIdentifier, cellType: PreCollectionViewCell.self)) { row, item, cell in
                cell.configure(url: item)
            }
            .disposed(by: bag)
        
        self.contentView.backBtn.rx.tap
            .subscribeNext { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }
            .disposed(by: bag)
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: contentView.deviceWidth * 0.6, height: contentView.deviceWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
}

extension DetailViewController: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let spacing = CGFloat(7)
        let pageWidth = self.contentView.deviceWidth * 0.6 + spacing
        let currentOffset = scrollView.contentOffset.x
        let targetOffset = targetContentOffset.pointee.x
        var newTargetOffset: CGFloat
        
        if velocity.x > 0 { //오른쪽 swipe
            newTargetOffset = ceil(currentOffset / pageWidth) * pageWidth
        } else if velocity.x < 0 { //왼쪽 swift
            newTargetOffset = floor(currentOffset / pageWidth) * pageWidth
        } else { //느리거나 빠를때
            newTargetOffset = round(targetOffset / pageWidth) * pageWidth
        }
        
        newTargetOffset -= 20
        
        let maxOffset = max(scrollView.contentSize.width - scrollView.bounds.width, 0) // 스크롤 범위 max 조정
        targetContentOffset.pointee.x = min(max(newTargetOffset, 0), maxOffset)
    }
}



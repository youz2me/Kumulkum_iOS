//
//  PromiseInfoViewController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 7/9/24.
//

import UIKit

class PromiseInfoViewController: BaseViewController {
    
    
    // MARK: Property
    
    private let promiseInfoViewModel: PromiseInfoViewModel
    private let promiseInfoView: PromiseInfoView = PromiseInfoView()
    
    
    // MARK: - Setup
    
    init(promiseInfoViewModel: PromiseInfoViewModel) {
        self.promiseInfoViewModel = promiseInfoViewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: 서버 통신하고 데이터 바인딩
    }
    
    override func setupView() {
        view.addSubview(promiseInfoView)
        self.navigationController?.navigationBar.shadowImage = nil
        
        promiseInfoView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func setupDelegate() {
        promiseInfoView.participantCollectionView.delegate = self
        promiseInfoView.participantCollectionView.dataSource = self
    }
}


// MARK: - UICollectionViewDataSource

extension PromiseInfoViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        // TODO: 데이터 바인딩 필요
        return 10
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension PromiseInfoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ParticipantCollectionViewCell.reuseIdentifier,
            for: indexPath) as? ParticipantCollectionViewCell 
        else { return UICollectionViewCell() }
        
        // TODO: 데이터 바인딩 필요
        
        if indexPath.row == 0 {
            cell.profileImageView.image = .imgEmptyCell
            cell.profileImageView.contentMode = .scaleAspectFill
        }
        
        return cell
    }
}

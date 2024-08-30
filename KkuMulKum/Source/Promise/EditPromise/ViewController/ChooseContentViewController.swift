//
//  ChooseContentViewController.swift
//  KkuMulKum
//
//  Created by YOUJIM on 8/25/24.
//

import UIKit

class ChooseContentViewController: BaseViewController {
    let viewModel: EditPromiseViewModel
    
    private let rootView: SelectPenaltyView = SelectPenaltyView()
    
    
    // MARK: - LifeCycle
    
    init(viewModel: EditPromiseViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBarTitle(with: "약속 수정하기", isBorderHidden: true)
        setupNavigationBarBackButton()
        
        setupBinding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    
    // MARK: - Setup
    
    override func setupView() {
        rootView.confirmButton.isEnabled = true
        rootView.confirmButton.setTitle("수정하기", style: .body03, color: .white)
    }
    
    override func setupAction() {
        rootView.confirmButton.addTarget(self, action: #selector(confirmButtonDidTap), for: .touchUpInside)
        rootView.levelButtons.forEach {
            $0.addTarget(self, action: #selector(dressLevelButtonDidTap), for: .touchUpInside)
        }
        rootView.penaltyButtons.forEach {
            $0.addTarget(self, action: #selector(penaltyButtonDidTap), for: .touchUpInside)
        }
    }
}


// MARK: - Extension

private extension ChooseContentViewController {
    func setupBinding() {
        viewModel.dressUpLevel?.bind(with: self, { owner, level in
            for button in self.rootView.levelButtons {
                button.isSelected = (button.identifier == level)
            }
        })
        
        viewModel.penalty?.bind(with: self, { owner, penalty in
            for button in self.rootView.penaltyButtons {
                button.isSelected = (button.identifier == penalty)
            }
        })
        
        viewModel.isSuccess.bindOnMain(with: self) { owner, success in
            let viewController = AddPromiseCompleteViewController(promiseID: self.viewModel.promiseID)
            
            viewController.setupNavigationBarTitle(with: "약속 수정하기")
            viewController.rootView.titleLabel.text = "약속이 수정되었어요!"
            
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    @objc
    func dressLevelButtonDidTap(_ selectedButton: SelectCapsuleButton) {
        viewModel.updateDressLevel(text: selectedButton.identifier)
    }
    
    @objc
    func penaltyButtonDidTap(_ selectedButton: SelectCapsuleButton) {
        viewModel.updatePenaltyLevel(text: selectedButton.identifier)
    }
    
    @objc
    func confirmButtonDidTap() {
        viewModel.putPromiseInfo()
    }
}

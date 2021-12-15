//
//  SnapDetailViewController.swift.swift
//  
//
//  Created by SEUNGMIN OH on 2021/12/14.
//

import UIKit
import SnapKit
import FirebaseCore

class SnapDetailViewController: UIViewController {
    
    let activateButton = MainActivitiButton()
    
    let firstSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스뱅크"
        view.imageView.image = UIImage(systemName: "trash.fill")
        return view
    }()
    let secondSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "토스증권"
        view.imageView.image = UIImage(systemName: "chart.xyaxis.line")
        return view
    }()
    let thirdSquareView: SquareBoxView = {
        let view = SquareBoxView()
        view.label.text = "고객센터"
        view.imageView.image = UIImage(systemName: "person")
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let moneyLable: UILabel = {
            return UILabel()
    }()
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    @objc func activateButtonClicked() {
//        let vc = SettingViewController(nibName: "SettingViewController", bundle: nil)
//        vc.name = "스윙칩"
//        present(vc, animated: true, completion: nil)
        let vc = SettingViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // StackView
        view.addSubview(stackView)
        [firstSquareView, secondSquareView, thirdSquareView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalTo(view)
            make.width.equalTo(view.snp.width).inset(20)
        }
        
        // Animation
        firstSquareView.alpha = 0
        secondSquareView.alpha = 0
        thirdSquareView.alpha = 0
        
        UIView.animate(withDuration: 1) {
            self.firstSquareView.alpha = 1
        } completion: { bool in
            UIView.animate(withDuration: 1) {
                self.secondSquareView.alpha = 1
            } completion: { bool in
                UIView.animate(withDuration: 1) {
                    self.thirdSquareView.alpha = 1
                } 
            }
        }
        
        activateButton.addTarget(self, action: #selector(activateButtonClicked), for: .touchUpInside)
        
        view?.backgroundColor = .white
        [activateButton, moneyLable, descriptionLabel, blueView].forEach {
            view.addSubview($0)
        }
        
        moneyLable.backgroundColor = .yellow
        moneyLable.text = "13,532원"
        
        moneyLable.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(80)
        }
        
        activateButton.snp.makeConstraints { make in
            make.leadingMargin.trailingMargin.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
            make.height.equalToSuperview().multipliedBy(0.1)
        }
        
        
//        redView.addSubview(blueView)
//        blueView.backgroundColor = .blue
        
//        blueView.snp.makeConstraints { make in
//            make.edges.equalTo(view).offset(50)
//        }
//
//        redView.backgroundColor = .red
//        redView.snp.makeConstraints { make in
//            make.edges.equalTo(blueView).inset(100)
//        }
//
//        redView.snp.updateConstraints{ make in
//            make.bottom.equalTo(-500)
//        }
    }
}

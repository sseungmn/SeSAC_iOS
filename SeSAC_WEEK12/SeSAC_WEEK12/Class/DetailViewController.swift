//
//  DetailViewController.swift
//  SeSAC_WEEK12
//
//  Created by SEUNGMIN OH on 2021/12/13.
//

import UIKit

class DetailViewController: UIViewController {
    
    let titleLabel = UILabel()
    let captionLabel = UILabel()
    let activateButton = MainActivitiButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setTitleLabelContraints()
        setCaptionLabelConstraints()
        setActivateButtonConstraints()
    }
    
    func setActivateButtonConstraints() {
        view.addSubview(activateButton)
        activateButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activateButton.widthAnchor.constraint(equalToConstant: 300),
            activateButton.heightAnchor.constraint(equalToConstant: 50),
            activateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setTitleLabelContraints() {
        titleLabel.text = "관심 있는 회사\n3개를 선택해주세요"
        titleLabel.backgroundColor = .lightGray
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        
        // 레이아웃 구현시 필수 1
        view.addSubview(titleLabel)
        // 레이아웃 구현시 필수 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 100.0)
        let centerX = NSLayoutConstraint(item: titleLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: titleLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1.0, constant: 0)
        view.addConstraints([topConstraint, centerX, width])
    }
    
    func setCaptionLabelConstraints() {
        captionLabel.text = "맞춤 정보를 알려드려요"
        captionLabel.backgroundColor = .darkGray
        captionLabel.font = .systemFont(ofSize: 12)
        captionLabel.textAlignment = .center
        view.addSubview(captionLabel)
        captionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraints = NSLayoutConstraint(item: captionLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1.0, constant: 15)
        let centerX = NSLayoutConstraint(item: captionLabel, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let width = NSLayoutConstraint(item: captionLabel, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 0.7, constant: 0)
        let height = NSLayoutConstraint(item: captionLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0.5, constant: 0)
        view.addConstraints([topConstraints, centerX, width, height])
    }
    
}

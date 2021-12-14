//
//  SnapDetailViewController.swift.swift
//  
//
//  Created by SEUNGMIN OH on 2021/12/14.
//

import UIKit
import SnapKit

class SnapDetailViewController: UIViewController {
    
    let activateButton = MainActivitiButton()
    let moneyLable: UILabel = {
            return UILabel()
    }()
    
    let descriptionLabel = UILabel()
    
    let redView = UIView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        
        redView.addSubview(blueView)
        blueView.backgroundColor = .blue
        
        blueView.snp.makeConstraints { make in
            make.edges.equalTo(view).offset(50)
        }
        
        redView.backgroundColor = .red
        redView.snp.makeConstraints { make in
            make.edges.equalTo(blueView).inset(100)
        }
        
        redView.snp.updateConstraints{ make in
            make.bottom.equalTo(-500)
        }
    }
}

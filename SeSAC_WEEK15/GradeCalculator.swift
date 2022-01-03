//
//  ㅎㄱㅁㅇㄷㅊ미쳐ㅣㅁ색.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GradeCalculator: UIViewController {
  let disposeBag = DisposeBag()
  
  let mySwitch = UISwitch()
  let first = UITextField()
  let second = UITextField()
  let resultLabel = UILabel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
    
    Observable.combineLatest(first.rx.text.orEmpty, second.rx.text.orEmpty) { textValue1, textValue2 -> Double in
      return ( (Double(textValue1) ?? 0.0) + (Double(textValue2) ?? 0.0) ) / 2
    }
    .map { $0.description }
    .bind(to: resultLabel.rx.text)
    .disposed(by: disposeBag)
    
    Observable.of(true)
      .bind(to: mySwitch.rx.isOn)
      .disposed(by: disposeBag)
  }
  
  func setup() {
    
    view.addSubview(mySwitch)
    mySwitch.snp.makeConstraints { make in
      make.center.equalToSuperview()
    }
    
    view.addSubview(first)
    view.addSubview(second)
    view.addSubview(resultLabel)
    first.backgroundColor = .white
    second.backgroundColor = .white
    resultLabel.textColor = .white
    first.snp.makeConstraints { make in
      make.top.equalTo(160)
      make.size.equalTo(50)
      make.leading.equalToSuperview()
    }
    second.snp.makeConstraints { make in
      make.top.equalTo(160)
      make.size.equalTo(50)
      make.leading.equalTo(120)
    }
    resultLabel.snp.makeConstraints { make in
      make.top.equalTo(100)
      make.size.equalTo(50)
      make.leading.equalTo(200)
    }
  }
}

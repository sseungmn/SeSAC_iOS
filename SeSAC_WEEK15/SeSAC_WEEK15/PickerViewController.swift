//
//  PickerViewController.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import RxSwift
import RxCocoa
import SnapKit
import UIKit

class PickerViewController: UIViewController {
  
  let pickerView = UIPickerView()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    
    let items = Observable.just([
      "영화",
      "드라마",
      "애니메이션"
    ])
    
    items
      .bind(to: pickerView.rx.itemTitles) { (row, element) in
        return element
        //           return NSAttributedString(string: element.title)
      }
      .disposed(by: disposeBag)
    
    pickerView.rx.modelSelected(String.self)
      .subscribe {
        print($0)
      }
      .disposed(by: disposeBag)
  }
  
  func configure() {
    pickerView.backgroundColor = .white
    view.addSubview(pickerView)
    pickerView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
  }
}

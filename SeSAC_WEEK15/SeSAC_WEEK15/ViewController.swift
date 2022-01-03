//
//  ViewController.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ViewController: UIViewController {
  
  let tableView = UITableView()
  let label = UILabel()
  let disposeBag = DisposeBag()
  let viewModel = ViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
    
    viewModel.items
      .bind(to: tableView.rx.items) { (tableView, row, element) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = "\(element) @ row \(row)"
        return cell
      }
      .disposed(by: disposeBag)
    
    tableView.rx.modelSelected(String.self)
      .map { "\($0)를 클릭했습니다!" }
      .bind(to: label.rx.text)
      .disposed(by: disposeBag)
  }
  
  func configure() {
    view.addSubview(tableView)
    tableView.snp.makeConstraints { make in
      make.edges.equalToSuperview()
    }
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    view.addSubview(label)
    label.snp.makeConstraints { make in
      make.center.equalToSuperview()
      make.height.equalTo(50)
    }
  }
  
}

class ViewModel {
  
  let items = Observable.just([
    "First Item",
    "Second Item",
    "Third Item"
  ])
}

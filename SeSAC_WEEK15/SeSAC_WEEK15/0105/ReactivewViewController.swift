//
//  ReactivewViewController.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/05.
//

import UIKit
import RxSwift
import RxRelay
import SnapKit

struct SampleData {
    var user: String
    var age: Int
    var rate: Double
}

class ReactivewViewModel {
    var data = [
        SampleData(user: "seuoh", age: 25, rate: 3.3),
        SampleData(user: "Jack", age: 12, rate: 4.2),
        SampleData(user: "Hue", age: 18, rate: 2.2),
        SampleData(user: "Dustin", age: 10, rate: 3.9)
    ]
    
    let dataSubject = PublishRelay<[SampleData]>()
    
    func fetchData() {
        dataSubject.accept(data)
    }
    
    func filterData(query: String) {
        let result = !query.isEmpty ? data.filter { $0.user.contains(query) } : data
        dataSubject.accept(result)
    }
}

class ReactivewViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let resetButton = UIButton()
    
    let viewModel = ReactivewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        viewModel.dataSubject
            .asDriver(onErrorJustReturn: [])
            .drive(tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { (row, element, cell) in
                cell.textLabel?.text = "\(element.user): \(element.age)세 (\(element.rate))"
            }
            .disposed(by: disposeBag)
        resetButton.rx.tap
            .subscribe { [weak self] _ in
                print("Click")
                self?.viewModel.fetchData()
            }
            .disposed(by: disposeBag)
        searchBar.rx.text // SerachBar에서 텍스트가 변경될 때 이벤트 발생
            .orEmpty // 옵셔널 해제
            .debounce(RxTimeInterval.milliseconds(300), scheduler: MainScheduler.instance) // 기다린다...
            .distinctUntilChanged() // 같은 값은 받지 않는다.
            .subscribe { [weak self] value in
                let query = value.element ?? ""
                self?.viewModel.filterData(query: query)
            }
            .disposed(by: disposeBag)
        
    }
    
    func setup() {
        navigationItem.titleView = searchBar
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.addSubview(resetButton)
        resetButton.backgroundColor = .red
        resetButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func reactiveTest() {
        var apple = 1
        var banana = 2
        
        print(apple + banana)
       
        apple = 10
        banana = 20
        
        let a = BehaviorSubject(value: 1)
        let b = BehaviorSubject(value: 2)
        
        Observable.combineLatest(a, b) { $0 + $1 }
        .subscribe {
            print($0)
        }
        .disposed(by: disposeBag)
        
        a.onNext(50)
        a.onNext(10)
    }
}

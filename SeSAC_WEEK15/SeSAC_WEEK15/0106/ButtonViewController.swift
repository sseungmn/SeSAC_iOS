//
//  ButtonViewController.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/06.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ButtonViewModel: CommonViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let tap: ControlEvent<Void>
    }
    
    struct Output {
        let text: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        let result = input.tap
            .map { "안녕 반가워" }
            .asDriver(onErrorJustReturn: "")
        
        return Output(text: result)
    }
}

class ButtonViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = ButtonViewModel()
    
    let button = UIButton()
    let label = UILabel()
    
    let aa = PublishRelay<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        // 방법 1
//        button.rx.tap
//            .map({ "안녕 반가워!" })
//            .bind(to: aa)
//            .disposed(by: disposeBag)
//
//        aa
//            .bind(to: label.rx.text)
//            .disposed(by: disposeBag)
        
        // 방법 2
//        button.rx.tap
//            .map { "안녕 반가워! "}
//            .asDriver(onErrorJustReturn: "")
//            .drive(label.rx.text)
//            .disposed(by: disposeBag)
        bind()
    }
    
    func bind() {
        let input = ButtonViewModel.Input(tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.text
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(button)
        view.addSubview(label)
        button.backgroundColor = .brown
        label.backgroundColor = .lightGray
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(50)
        }
        label.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}

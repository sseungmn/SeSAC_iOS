//
//  ValidationViewController.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/05.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

protocol CommonViewModel {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
class ValidationViewModel: CommonViewModel {
    
    var disposeBag: DisposeBag = DisposeBag()
    
    struct Input {
        let text: ControlProperty<String?>
        let tap: ControlEvent<Void>
    }

    struct Output {
        let validStatus: Observable<Bool>
        let validDescription: BehaviorRelay<String>
        let sceneTransition: ControlEvent<Void>
    }

    func transform(input: Input) -> Output {
        let resultText = input.text
            .orEmpty
            .map { $0.count >= 8 }
            .share(replay: 1, scope: .whileConnected)
        return  Output(validStatus: resultText, validDescription: validDescription, sceneTransition: input.tap)
    }
    
    var validDescription = BehaviorRelay<String>(value: "최소 8자 이상 입력해")
}

class ValidationViewController: UIViewController {
    
    let nameValidationLabel = UILabel()
    let nameTextField = UITextField()
    let button = UIButton()
    
    let viewModel = ValidationViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MVVM으로 변경 전
//        viewModel.validDescription
//            .asDriver()
//            .drive(nameValidationLabel.rx.text)
//            .disposed(by: disposeBag)
//
//        let validation = nameTextField.rx.text
//            .orEmpty
//            .map { $0.count >= 8 }
//            .share(replay: 1, scope: .whileConnected)
//            .debug()
//
//        validation
//            .bind(to: button.rx.isEnabled)
//            .disposed(by: disposeBag)
//
//        validation
//            .bind(to: nameValidationLabel.rx.isHidden)
//            .disposed(by: disposeBag)
//        bind()
//        button.rx.tap
//            .subscribe { _ in
//                self.present(ReactivewViewController(), animated: true, completion: nil)
//            }
//            .disposed(by: disposeBag)
        
        setup()
    }
    
    func bind() {
        let input = ValidationViewModel.Input(text: nameTextField.rx.text, tap: button.rx.tap)
        let output = viewModel.transform(input: input)
        
        output.validStatus
            .bind(to: button.rx.isEnabled, nameValidationLabel.rx.isHidden)
            .disposed(by: disposeBag)
        output.validDescription
            .asDriver()
            .drive(nameValidationLabel.rx.text)
            .disposed(by: disposeBag)
        output.sceneTransition
            .subscribe { _ in
                self.present(ReactivewViewController(), animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        [nameValidationLabel, nameTextField, button].forEach {
            $0.backgroundColor = .lightGray
            view.addSubview($0)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        nameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(200)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        button.snp.makeConstraints { make in
            make.top.equalTo(300)
            make.centerX.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
    }
}

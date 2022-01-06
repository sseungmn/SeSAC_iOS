//
//  Subject.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/04.
//

import UIKit
import RxSwift

class SubjectViewController: UIViewController {
    
    let label = UILabel()
    let disposeBag = DisposeBag()
    let nickname = PublishSubject<String>()
    
    let array1 = [1,1,1,1,1]
    let array2 = [2,2,2,2,2]
    let array3 = [3,3,3,3,3]
    
    let subject = PublishSubject<[Int]>()
    let behavior = BehaviorSubject<[Int]>(value: [0,0,0,0,0])
    let replay = ReplaySubject<[Int]>.create(bufferSize: 3)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let randomSubject = BehaviorSubject(value: 0)
        randomSubject.onNext(Int.random(in: 1...100))
        
        randomSubject
            .subscribe { value in
                print("randomSubject1 \(value)")
            }
            .disposed(by: disposeBag)
    }
    
    func replaySubejct() {
        replay.onNext(array1)
        replay.onNext(array2)
        replay.onNext(array3)
        replay.onNext([1,2,3,4,5])
        
        replay
            .subscribe { value in
                print("replay subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        replay.onNext([5,6,7,8,9])
        
    }
    
    func behaviorSubject() {
        behavior
            .subscribe { value in
                
                print("behavior subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        
        behavior.onNext(array2)
        behavior.onNext(array3)
        behavior.onCompleted()
        
        behavior.onNext(array1)
    }
    
    
    func publishSubject() {
        subject.onNext(array1)
        
        subject
            .subscribe { value in
                print("publish subject - \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        subject.onNext(array2)
        subject.onNext(array3)
        subject.onCompleted()
        
        subject.onNext(array1)
        
    }
    
    func aboutSubject() {
        setup()
        
        nickname
            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.nickname.onNext("Minios")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.nickname.onNext("fjdsjfdks")
        }
    }
    
    func setup() {
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        label.backgroundColor = .white
        label.textAlignment = .center
    }
}

//
//  Operator.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/03.
//

import UIKit
import RxSwift

enum ExampleError: Error {
    case fail
}

class Operator: UIViewController {
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Observables: Create > Subscribe > next -> completed / error ( -> disposed )
        // disposed: deinit
        
        Observable.from(["가", "나", "다", "라", "마"])
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        Observable.repeatElement("seuoh")
            .take(Int.random(in: 1...10))
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)

        Observable<Int>.interval(.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { value in
                print("next: \(value)")
            } onError: { error in
                print(error)
            } onCompleted: {
                print("onCompleted")
            } onDisposed: {
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.disposeBag = DisposeBag()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            intervalObservable.dispose()
//            self.navigationController?.pushViewController(GradeCalculator(), animated: true)
        }
    }
    
    deinit {
        print("Operator deinit")
    }
    
    func basic() {
        let itemsA = [3.3, 4.0, 5.0, 2.0, 3.6, 4.8]
        let itemsB = [2.3, 2.0, 1.3]
        
        Observable.just(itemsA)
            .subscribe { value in
                print("just - \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable.of(itemsA, itemsB)
            .subscribe { value in
                print("of - \(value)")
            }
            .disposed(by: disposeBag)
        
        Observable.from(itemsA)
            .subscribe { value in
                print("from - \(value)")
            }
            .disposed(by: disposeBag)
        
        let items = [3.3, 4.0, 5.0, 3.6, 4.8]
        
        Observable<Double>.create { (observer) -> Disposable in
            for item in items {
                if item < 3.0 {
                    observer.onError(ExampleError.fail)
                    break
                }
                observer.onNext(item)
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
        .subscribe(onNext: { print($0) },
                   onError: { print($0) },
                   onCompleted: { print("Complete") },
                   onDisposed: { print("Disposed") })
        .disposed(by: disposeBag)
    }
}

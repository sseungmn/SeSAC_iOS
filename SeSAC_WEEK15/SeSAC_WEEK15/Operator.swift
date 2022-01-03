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
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
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

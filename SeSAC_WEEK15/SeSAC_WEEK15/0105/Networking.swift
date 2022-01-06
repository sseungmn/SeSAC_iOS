//
//  Networking.swift
//  SeSAC_WEEK15
//
//  Created by SEUNGMIN OH on 2022/01/04.
//

import Foundation
import UIKit
import RxSwift
import RxAlamofire
import RxCocoa

struct Lotto: Codable {
    let totSellamnt: Int
    let returnValue, drwNoDate: String
    let firstWinamnt, drwtNo6, drwtNo4, firstPrzwnerCo: Int
    let drwtNo5, bnusNo, firstAccumamnt, drwNo: Int
    let drwtNo2, drwtNo3, drwtNo1: Int
}

class NetworkingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    let astroURL = "https://aztro.sameerkumar.website/?sign=gemini&day=today"
    let lottoURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=903"
    
    let label = UILabel()
    
    var number = BehaviorSubject<String>(value: "오늘의 운세")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        number
            .subscribe { value in
                self.label.text = value
            }
        //            .bind(to: label.rx.text)
            .disposed(by: disposeBag)
        
        let request = userURLSession(url: lottoURL)
            .share()
            .decode(type: Lotto.self, decoder: JSONDecoder())
        
        request
            .observe(on: MainScheduler.instance)
            .subscribe { value in
//                guard let lotto = value.element else { return }
//                self.number.onNext(lotto.drwNoDate)
                print("value1")
            }
            .disposed(by: disposeBag)
    
        request
            .observe(on: MainScheduler.instance)
            .subscribe { value in
//                guard let lotto = value.element else { return }
//                self.number.onNext(lotto.drwNoDate)
                print("value2")
            }
            .disposed(by: disposeBag)
    }
    
    func setup() {
        view.addSubview(label)
        label.backgroundColor = .white
        label.textAlignment = .center
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func rxalamofire() {
        json(.post, astroURL) // parameters: ["a": "g", "asdf": "ads"])
            .subscribe { value in
                print(value)
                guard let data = value as? [String: Any] else { return }
                guard let result = data["lucky_number"] as? String else { return }
                self.number.onNext(result)
            } onError: { error in
                print(error)
            } onCompleted: {
                print("completed")
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)
    }
    
    func userURLSession(url: String) -> Observable<Data> {
        return Observable.create { value in
            let url = URL(string: self.lottoURL)!
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard error == nil else {
                    value.onError(ExampleError.fail)
                    return
                }
                // resopnse, encoding 생략
                if let data = data {
                    print("dataTask")
                    value.onNext(data)
                }
                value.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}

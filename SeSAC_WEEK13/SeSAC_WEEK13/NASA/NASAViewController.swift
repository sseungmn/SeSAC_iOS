//
//  NASAViewController.swift
//  SeSAC_WEEK13
//
//  Created by SEUNGMIN OH on 2021/12/21.
//

import UIKit

// BaseViewController 를 상속받기 때문에 import 를 굳이 해줄 필요 없음

class NASAViewController: BaseViewController {
    
    //뷰객체가 많아 질 경우, setupConstraints 가 길어질 수 밖에 없다. -> SignVC 확인
    let imageView = UIImageView()
    let label = UILabel()
    
    var session: URLSession!
    
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            label.text = "\(result * 100)/100"
        }
    }
    var total: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buffer = Data()
        request()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //세션 해제해주는 과정
//        session.finishTasksAndInvalidate()
        session.invalidateAndCancel() //리소스 정리 (실행중인 테스크가 있더라도)
    }
    
    override func configure() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        label.textAlignment = .center
        label.backgroundColor = .white
        label.textColor = .black
    }
    
    override func setupConstraints() {
        view.addSubview(imageView)
        view.addSubview(label)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(100)
        }
        label.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    //오늘은 핸들러말고 세션딜리게이트를 사용
    //만약 서버로부터 가져올 데이터가 용량이 클 경우에 핸들러를 사용하게 되면 얼마나 다운 받았는지 확인 할 수 없음
    func request() {
        let url = URL(string: "https://apod.nasa.gov/apod/image/2112/WinterSolsticeMW_Seip_1079.jpg")!
        
        //커스텀 조건을 많이주는 default 로 생각
//        let configuration = URLSessionConfiguration.default
//        configuration.allowsCellularAccess = false
//        URLSession(configuration: configuration).dataTask(with: url).resume()
        
        //간단한 default
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        session.dataTask(with: url).resume()
        
        //shared는 딜리게이트 불가능
//        URLSession.shared.dataTask(with: url).resume()
    }
}

extension NASAViewController: URLSessionDataDelegate {
    
    //서버에서 최초로 응답 받은 경우 호출 -> 상태코드에 따른 분기처리
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            //헤더에 파일 총 용량있으니까, 퍼센트 출력도 가능하다
            total = Double(response.value(forHTTPHeaderField: "Content-Length")!)!
            return .allow // -> 2
        } else {
            return .cancel // -> 3
        }
        
    }
    
    //서버에서 데이터를 받을 때마다 반복적으로 호출
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print(data)
        buffer?.append(data)
    }
    
    //응답이 완료되었을 때 : nil
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let error = error {
            print("ERROR", error)
        } else {
            print("SUCCESS")
            //buffer에 data가 모두 채워졌을때, 이미지로 변환
            guard let buffer = buffer else {
                print("buffer error")
                return
            }
            let image = UIImage(data: buffer)
            imageView.image = image
        }
    }
    
}

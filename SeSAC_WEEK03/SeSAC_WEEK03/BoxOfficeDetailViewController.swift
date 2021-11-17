//
//  BoxOfficeDetailViewController.swift
//  SeSAC_03Week
//
//  Created by OHSEUNGMIN on 2021/10/15.
//

import UIKit

class BoxOfficeDetailViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var overviewTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.delegate = self
        
        // 텍스트 뷰 플레이스 홀더 만들기 : 글자, 글자색상
        overviewTextView.text = "이곳에 줄거리를 남겨보세요"
        overviewTextView.textColor = .lightGray
    }
    
    // 커서 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
           textView.text = nil
            textView.textColor = .black
        }
    }
    
    // 커서 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "이 곳에 줄거리를 남겨보세요"
            textView.textColor = .lightGray
        }
    }
    
}

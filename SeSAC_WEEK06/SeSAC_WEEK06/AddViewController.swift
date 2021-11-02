//
//  AddViewController.swift
//  SeSAC_WEEK06
//
//  Created by OHSEUNGMIN on 2021/11/01.
//

import UIKit
import RealmSwift

class AddViewController: UIViewController {

    let localRealm = try! Realm()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUI()
        
        print("Realm is located at : ", localRealm.configuration.fileURL!)
    }
    
    func setUI() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(cancelButtonClicked))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(saveButtonClicked))
        
        // Background color
        titleTextField.backgroundColor = .systemGray4
        dateButton.backgroundColor = .systemGray4
        contentTextView.backgroundColor = .systemGray4
        
        titleTextField.layer.cornerRadius = 5
        titleTextField.placeholder = "제목을 입력해주세요"
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy년 MM월 dd일"
        dateButton.titleLabel?.text = dateFormat.string(from: Date())
    }
    
    @objc
    func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        let task = UserDiary(diaryTitle: "테스트", content: "졸려죽겠다", writeDate: Date(), regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
        }
    }
}

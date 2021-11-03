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
    
    @IBOutlet weak var contentImageView: UIImageView!
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
        
        dateButton.titleLabel?.text = Date().toString()
    }
    
    @objc
    func cancelButtonClicked() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveButtonClicked() {
        let task = UserDiary(diaryTitle: titleTextField.text ?? "No title", content: contentTextView.text ?? "No content", writeDate: Date(), regDate: Date())
        try! localRealm.write {
            localRealm.add(task)
            saveImageToDocumentDirectory(imageName: "\(task._id).jpg", image: contentImageView.image!)
        }
    }
    
    func saveImageToDocumentDirectory(imageName: String, image: UIImage) {
        // 1. 이미지 저장 경로 설정: 도큐먼트 폴더(.documentDirectory), FileManager
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        
        // 2. 이미지 파일 이름 & 최종 경로 설정
        let imageURL = documentDirectory.appendingPathComponent(imageName)
        
        // 3. 이미지 압축
        guard let data = image.jpegData(compressionQuality: 0.2) else { return }
        
        // 4. 이미지 저장: 동일한 경로에 이미지를 저장하게 될 경우, 덮어쓰기
        // 4 - 1. 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: imageURL.path) {
            
            // 4 - 2. 기존 경로에 있는 이미지 삭제
            do {
                try FileManager.default.removeItem(at: imageURL)
                print("이미지 삭제 완료")
            } catch {
                print("이미지를 삭제하지 못했습니다.")
            }
        }
        // 5. 이미지를 도큐먼트에 저장
        do {
            try data.write(to: imageURL)
        } catch {
            print("이미지 저장 못함")
        }
    }
}
